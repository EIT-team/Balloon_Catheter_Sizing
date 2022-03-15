% Create square mesh model
imdl= mk_common_model('g2s');
s_mdl= rmfield(imdl.fwd_model,{'electrode','stimulation'});
s_mdl.nodes = s_mdl.nodes ./ 150;

% assign one parameter to each square
e= size(s_mdl.elems,1);
params= ceil(( 0.1:e )/2);
s_mdl.coarse2fine = sparse(1:e,params,1,e,max(params));

% s_mdl.nodes = s_mdl.nodes ./ 10;

figure
show_fem(s_mdl)
title('Coarse model slice Netgen model g2s with nodes divided by 150')
xlabel('x(m)')
ylabel('y(m)')
set(gca,'FontSize',18)
%% create eidors structure
M=meshio.read('15mm_height/9fr/elliptical6mm.vtu'); % THE MESH IS IN MM
model_name = 'Elliptical Model D_{major axis} = 6mm '
save('modelslice', 'M')

MDL=eidors_obj('fwd_model','BalloonCatheter');
MDL.nodes = M.vtx./1000; % the 3d coordinates of the nodes IN METERS
MDL.elems = M.cells(4).tri; % which nodes create a tetrahedron 
[srf, idx] = find_boundary(M.cells(4).tri);
MDL.boundary = srf;
gnd_pos=[0,-0.01,0];
gnd_dist=sqrt(sum((MDL.nodes - gnd_pos).^2,2));
[~, gnd_node] = min(gnd_dist);
MDL.gnd_node = gnd_node;

% Define electrodes z direction
elecRingZ=[0.0025, 0.0125];
phi_offset = 0; 
radius_centre = 0.0015;
nElecRing = 8; % number of electrodes in each ring

for iElec=1:nElecRing
    phi_e = 2*pi*(iElec-1)/nElecRing + phi_offset;
    elec_pos_ring(iElec,:) = radius_centre * [cos(phi_e) sin(phi_e)]; % center coordinates (0,0)
end

% create points in 3D
elec_pos=[];
nRing=length(elecRingZ);
for iRing=1:nRing
elec_pos=[elec_pos; elec_pos_ring repmat(elecRingZ(iRing),[nElecRing,1])]
end

figure;
show_fem(MDL);
hold on;
plot3(elec_pos(:,1),elec_pos(:,2),elec_pos(:,3), '.','Markersize',50); 
hold off

% create electrode structure
z_contact=1e-3;
elec_radius = .008;
for iElec = 1:size(elec_pos,1)
    
    %assign conductivity to structure
    electrodes(iElec).z_contact= z_contact;
    
    % find surface nodes within electrode radius
    edist = sqrt(sum((MDL.nodes - elec_pos(iElec,:)).^2,2));
    [~,enode] = min(edist);

    electrodes(iElec).nodes = enode;
end

% add electrode strucutre to model struct
MDL.electrode =     electrodes;


for i = 1:length(electrodes)
    position_electrodes = M.vtx(MDL.electrode(i).nodes, :);
end

figure
show_fem(MDL)
title('Mesh with electrode locations');
set(gca,'FontSize',18)
% Forward model
MDL.solve=          @fwd_solve_1st_order;
MDL.jacobian=       @jacobian_adjoint;
MDL.system_mat=     @system_mat_1st_order;
MDL.normalize_measurements = 0;

Amp=141e-6; % Current amplitude in Amps this is the most you can inject below 1 kHz, but we are not really limited to that
N_elec=size(elec_pos,1);

UniquePairs = nchoosek(1:N_elec,2);
nPairs=size(UniquePairs,1);

Protocol=[];
for iInj=1:nPairs

    Protocol=[Protocol; repmat(UniquePairs(iInj,:),[nPairs,1]) UniquePairs];

end

% Protocol = [3 25, 4 26]
Protocol = readmatrix('sp_mp1920.xlsx', 'Range', 'A1:D1920') % A1:D462 
stim = stim_meas_list(Protocol, N_elec, Amp);
MDL.stimulation=stim;

MDL = remove_unused_nodes(MDL);

if valid_fwd_model(MDL)
    disp('Forward model is ok! Yay!');
end

S=1.6;
S_deflated = 0.016;
S_pert = S*1.05;
Inj_number = 1;
img = mk_image(MDL,S);
img.fwd_solve.get_all_meas = 1;
v_baseline = fwd_solve(img)

% Earlier in time data
img_0 = mk_image(MDL, S_deflated)
img_0.fwd_solve.get_all_meas = 1;
v_deflated = fwd_solve(img_0);

img_v = rmfield(img, 'elem_data');
img_v.node_data = v_baseline.volt;
figure
img_v.calc_colours.cb_shrink_move = [.3,.8,-0.02];
show_slices(img_v)

%% Fine model as forward model

fine_model=meshio.read('15mm_height/9fr/circular20mm.vtu'); 
save('model_infinite', 'fine_model');
fine_mdl=eidors_obj('fwd_model','balloonx3b');
fine_mdl.nodes = fine_model.vtx./1000; % the 3d coordinates of the nodes IN METERS
fine_mdl.elems = fine_model.cells(4).tri; % which nodes create a tetrahedron 
[srf3, idx3] = find_boundary(fine_model.cells(4).tri);
fine_mdl.boundary = srf3;
gnd_pos=[0,-0.01,0];
gnd_dist=sqrt(sum((fine_mdl.nodes - gnd_pos).^2,2));
[~, gnd_node] = min(gnd_dist);
fine_mdl.gnd_node = gnd_node;

for iElec = 1:size(elec_pos,1)
    
    %assign conductivity to structure
    electrodes3(iElec).z_contact= z_contact;
    
    % find surface nodes within electrode radius
    edist3 = sqrt(sum((fine_mdl.nodes - elec_pos(iElec,:)).^2,2));
    [~,enode3] = min(edist3);

    electrodes3(iElec).nodes = enode3;
end

fine_mdl.electrode =     electrodes3;

% forward model
fine_mdl.solve=          @fwd_solve_1st_order;
fine_mdl.jacobian=       @jacobian_adjoint;
fine_mdl.system_mat=     @system_mat_1st_order;
fine_mdl.normalize_measurements = 0;

% Convert protocol file to EIDORS stim patterns

Amp=141e-6; % Current amplitude in Amps this is the most you can inject below 1 kHz, but we are not really limited to that

N_elec=size(elec_pos,1);

UniquePairs = nchoosek(1:N_elec,2);
nPairs=size(UniquePairs,1);

Protocol=[];
for iInj=1:nPairs

Protocol=[Protocol; repmat(UniquePairs(iInj,:),[nPairs,1]) UniquePairs];

end

Protocol = readmatrix('sp_mp1920.xlsx', 'Range', 'A1:D1920'); % A1:D462 
stim = stim_meas_list(Protocol, N_elec, Amp);
fine_mdl.stimulation=stim;

fine_mdl=remove_unused_nodes(fine_mdl);

figure
show_fem(fine_mdl)

%% Map coarse model geometry
% figure
% show_slices(img4)
% hold on
% show_fem(fine_mdl)
% hold off
% % axis equal; axis tight;
% 
% figure
% show_fem(fine_mdl);  % fine model
% hold on
% plot3(xpts,ypts,zpts,'b');
% hold off
% 
% axis(0.1*[-1.1,+1.1,-1.1,+1.1,0.1-0.4,0.1+0.4]);

%% coarse model slice

% coarse_model =meshio.read('slice.vtu'); 
% save('model_infinite', 'coarse_model'); 
% coarse_mdl=eidors_obj('fwd_model','Balloon');
% coarse_mdl.nodes = coarse_model.vtx./1000; % the 3d coordinates of the nodes IN METERS
% coarse_mdl.elems = coarse_model.cells(4).tri; % which nodes create a tetrahedron 
% [srf, idx] = find_boundary(coarse_model.cells(4).tri);
% coarse_mdl.boundary = srf;
% gnd_pos=[0,-0.01,0];
% gnd_dist=sqrt(sum((coarse_mdl.nodes - gnd_pos).^2,2));
% [~, gnd_node] = min(gnd_dist);
% coarse_mdl.gnd_node = gnd_node;
% 
% 
% e= size(coarse_mdl.elems,1)
% params= ceil(( 1:e )/10)
% coarse_mdl.coarse2fine = sparse(1:e,params,1,e,max(params));
% 
% figure
% show_fem(coarse_mdl)
% 


%% Reconstruction absolute
% special parameter for this model absolute

% less elements for MDL_2
imdl.name = 'Eit reconstruction'
imdl= eidors_obj('inv_model', imdl);
imdl.rec_model= s_mdl;
imdl.fwd_model = fine_mdl; % MDL_3 mesh with no electrodes and less dense 
imdl.inv_solve_gn.max_iterations = 10 ; %Number of iterations 
imdl.parameters.term_tolerance= 1e-5;

imdl.jacobian_bkgnd.value= 1;

s_mdl.mk_coarse_fine_mapping.z_depth = 0.02;
s_mdl.mk_coarse_fine_mapping.f2c_offset = [0,0,0.0025];
% s_mdl.mk_coarse_fine_mapping.f2c_project = 0.1*speye(3);
c2f= mk_coarse_fine_mapping(fine_mdl, s_mdl);
imdl.fwd_model.coarse2fine = c2f;

imdl.hyperparameter.value= 0.01;

% time difference
imdl.RtR_prior = @prior_gaussian_HPF;
imdl.solve = @inv_solve_diff_GN_one_step;
imdl.reconst_type = 'difference';
img_slice  = inv_solve(imdl, v_deflated, v_baseline); 

%% figure inv 
figure 
fig1 = show_fem(img_slice,[1,1]); axis off; axis image
title(strcat('EIT slice reconstruction at ring of electrodes at 25mm',model_name, ' in fine model 20mm'), ...
'Fontsize', 10);
xlabel('x(m)')
ylabel('y(m)')
set(gca,'FontSize',18)
saveas(fig1,'reconstruction_slice.fig');

% absolute
% imdl.RtR_prior = @prior_noser 
% inv_mdl.solve = @inv_solve_gn;
% imdl.reconst_type = 'absolute';
% img4  = inv_solve(imdl, v_baseline);  

%% Map coarse model geometry
figure
show_fem(fine_mdl)
hold on
hh = show_fem(s_mdl)
set(hh,'EdgeColor',[0,0,1]);
hold off


%% GET DIMENSIONS
% 
elem = img_slice.elem_data;
elem_thresholded = zeros(size(elem));
max_elem_slice = max(elem);
Threshold = 1/3 * max_elem_slice
threshold_name = ' 1/3 * max element'
index = find(elem>Threshold);


for i=length(elem)
    elem_thresholded(index) = elem(elem>Threshold)
end

img_slice.elem_data = elem_thresholded
figure
show_fem(img_slice ,[1,1])
axis image
title(strcat('EIT slice reconstruction', model_name, ' with threshold', num2str(threshold_name)), ...
'Fontsize', 25);
xlabel('x(m)')
ylabel('y(m)')
set(gca, 'Fontsize', 18)

%% find centres and plot threshold


% get the data for each element in the slice - eidors does this in the
% background when you do show_fem(img_slice)
slice_data=get_img_data(img_slice);

%find element centres
elem_cnts=(imdl.rec_model.nodes(imdl.rec_model.elems(:,1),:)+ ...
imdl.rec_model.nodes(imdl.rec_model.elems(:,2),:)) ./2;

% figure
% title(strcat('Slice reconstruction', model_name), 'fontsize', 16)
% hold on
% 
% plot(elem_cnts(:,1),elem_cnts(:,2),'bo')

selectedpoints= slice_data > Threshold;

plot(elem_cnts(selectedpoints,1),elem_cnts(selectedpoints,2),'.r')
set(gca,'FontSize',12)

hold off

daspect([1,1,1])


x = elem_cnts(selectedpoints,1);
y = elem_cnts(selectedpoints,2);

% Get sum of elements for each sector
x_polar = atan(y./x);
x_polar_new = myatan(y,x); % interval 0 and 2pi instead of -pi/2 and pi/2
radius = sqrt(x.^2 + y.^2);


figure
polarscatter(x_polar_new, radius)
title(strcat('Polar scatter plot of elements obtained from slice reconstruction ', model_name, ' with threshold ', ...
    num2str(threshold_name)), 'fontsize', 16)

set(gca,'FontSize',16)
%% Divide into sectors and get max elements to find radius
angle_degrees = x_polar.*(180/pi);
angle_degrees_new = x_polar_new.*(180/pi);
angle_degrees_elems = transpose(angle_degrees_new);
n_sectors = 12;
angle_of_one_sector = 360/n_sectors;
angle_sector_2 = zeros(n_sectors, 1);
angle_sector_1 = zeros(n_sectors, 1);
angle_sector_2(1) = angle_of_one_sector;
index_interval = {};

for i=1:n_sectors-1
    angle_sector_1(i+1) = angle_sector_2(i);
    angle_sector_2(i+1) = angle_sector_2(i) + angle_of_one_sector;
end
        
for i=1:n_sectors
    index_interval{i} = find(angle_sector_1(i) <= angle_degrees_elems & ...
            angle_degrees_elems <= angle_sector_2(i));
        
    sum_elements_in_sector(i) = sum(angle_sector_1(i) <= angle_degrees_elems & ...
            angle_degrees_elems <= angle_sector_2(i));
end

figure
plot(angle_sector_2, sum_elements_in_sector, 'Linewidth', 2)
xlabel('Sector angle in degrees', 'Fontsize', 16)
ylabel(strcat('Number of elements with threshold', num2str(threshold_name)), 'Fontsize', 16)
title(strcat('Number of elements from slice reconstruction ', model_name, ' against sector angle'), 'Fontsize', 16)
set(gca,'FontSize',16)

%% All radius values in each sector
dimensions_sectors = zeros(n_sectors, 1);
for i_sectors=1:n_sectors
    radius_val = radius(index_interval{i_sectors});
    radius_vals = radius_val(radius_val < 0.01);
    
    if  isempty(radius_vals) == 0
        max_rad = max(radius_vals);
        dimensions_sectors_max(i_sectors) = max_rad;
        
        angle = angle_degrees_new(index_interval{i_sectors})';
        index_max_rad = find(radius_val == max_rad)
        if length(index_max_rad) > 1
            angle_max_rad(i_sectors) = angle(index_max_rad(1));
        else
            angle_max_rad(i_sectors) = angle(index_max_rad);
        end
        
    end

end


% disp('mean')
% dimensions_sectors_mean'
% disp('median')
% dimensions_sectors_median'
disp('max')
dimensions_sectors_max'
disp('max angle')
angle_max_rad'

