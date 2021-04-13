%% GET VOLTAGE BASELINE FROM SMALL MODEL

M=meshio.read('15mm_height/9fr/elliptical6mm.vtu'); % THE MESH IS IN MM
save('model1', 'M')

% create eidors structure
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
% Protocol = readmatrix('sp_mp.xlsx', 'Range', 'A1:D462') % A1:D462 
Protocol = readmatrix('sp_mp1920.xlsx', 'Range', 'A1:D1920') % A1:D462 
stim = stim_meas_list(Protocol, N_elec, Amp);
MDL.stimulation=stim;

MDL = remove_unused_nodes(MDL);
% MDL=remove_unused_nodes(MDL);
if valid_fwd_model(MDL)
    disp('Forward model is ok! Yay!');
end

%% Conductivity and voltage measurements
S=1.6;
Inj_number = 1;


% Centers of elements
elems_tetras_a = MDL.elems;
nodes_coord_a = MDL.nodes;

for i=1:length(elems_tetras_a)
        index_nodes_coord_a = elems_tetras_a(i, :);
        nodes_a=nodes_coord_a(index_nodes_coord_a,:);
        cell_coord{i}=nodes_a;
        for m=1:4
            centroid_coord_a = mean(nodes_a);
            centroids_a{i} = centroid_coord_a;
        end
end

centroids_mat_a = cell2mat(centroids_a);
centroids_mat_reshape_a = reshape(centroids_mat_a,3, []);
x = centroids_mat_reshape_a(1, :);
y = centroids_mat_reshape_a(2, :);
z = centroids_mat_reshape_a(3, :);
% figure
% scatter3(x,y,z)

% Choose elements we want to create perturbation
x_blob = find(x>0);
y_blob = find(y>0);
z_blob = find(z>=0.012);
blob = intersect(intersect(x_blob,y_blob),z_blob);

% Assign conductivity to those elements
S_perturbation = 1.6*ones(43856,1);
S_perturbation(blob, :) = 10;
length_elements = length(S_perturbation(blob, :))

% img = mk_image(MDL,S);
img = mk_image(MDL,S_perturbation);

img.fwd_solve.get_all_meas = 1;
v_baseline = fwd_solve(img)


img_v = rmfield(img, 'elem_data');
img_v.node_data = v_baseline.volt;
figure
img_v.calc_colours.cb_shrink_move = [.3,.8,-0.02];
show_slices(img_v)

%%
figure
show_fem(img)
title('Mesh showing blob elements for conductivity perturbation')
%% Fine model as forward model

fine_model=meshio.read('15mm_height/9fr/circular7mm.vtu'); 
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

% Protocol = readmatrix('sp_mp.xlsx', 'Range', 'A1:D462') % A1:D462 
Protocol = readmatrix('sp_mp1920.xlsx', 'Range', 'A1:D1920')
stim = stim_meas_list(Protocol, N_elec, Amp);
fine_mdl.stimulation=stim;

fine_mdl=remove_unused_nodes(fine_mdl);

figure
show_fem(fine_mdl, 3)

%% PREPARE INV MODEL

% inv_model =meshio.read('model_for_reconstruction4-X3DIAM.vtu'); 
% save('model_infinite', 'inv_model');
% inv_mdl=eidors_obj('inv_model','balloonx3');
% inv_mdl.nodes = inv_model.vtx./1000; % the 3d coordinates of the nodes IN METERS
% inv_mdl.elems = inv_model.cells(4).tri; % which nodes create a tetrahedron 
% [srf2, idx2] = find_boundary(inv_model.cells(4).tri);
% inv_mdl.boundary = srf2;
% gnd_pos=[0,-0.01,0];
% gnd_dist=sqrt(sum((inv_mdl.nodes - gnd_pos).^2,2));
% [~, gnd_node] = min(gnd_dist);
% inv_mdl.gnd_node = gnd_node;
% 
% 
% % loop through each electrode
% for iElec = 1:size(elec_pos,1)
%     
%     %assign conductivity to structure
%     electrodes2(iElec).z_contact= z_contact;
%     
%     % find surface nodes within electrode radius
%     edist = sqrt(sum((inv_mdl.nodes - elec_pos(iElec,:)).^2,2));
%     [~,enode2] = min(edist);
% 
%     electrodes2(iElec).nodes = enode2;
% end
% 
% % add electrode strucutre to model struct
% inv_mdl.electrode =     electrodes2;

%% Create coarse model with less elements
coarse_model =meshio.read('15mm_height/coarse7_less/model7mm.vtu'); 
save('model_infinite', 'coarse_model'); 
coarse_mdl=eidors_obj('fwd_model','Balloon');
coarse_mdl.nodes = coarse_model.vtx./1000; % the 3d coordinates of the nodes IN METERS
coarse_mdl.elems = coarse_model.cells(4).tri; % which nodes create a tetrahedron 
[srf, idx] = find_boundary(coarse_model.cells(4).tri);
coarse_mdl.boundary = srf;
gnd_pos=[0,-0.01,0];
gnd_dist=sqrt(sum((coarse_mdl.nodes - gnd_pos).^2,2));
[~, gnd_node] = min(gnd_dist);
coarse_mdl.gnd_node = gnd_node;
figure
show_fem(coarse_mdl)

%% Reconstruction absolute
% special parameter for this model absolute

% less elements for MDL_2
inv_mdl.name = 'Eit reconstruction'
inv_mdl= eidors_obj('inv_model', inv_mdl);
inv_mdl.solve = @inv_solve_gn; %Default Gauss Newton solvers 
inv_mdl.reconst_type = 'absolute'; 
inv_mdl.fwd_model = fine_mdl; % MDL_3 mesh with no electrodes and less dense 
inv_mdl.inv_solve_gn.max_iterations = 10 ; %Number of iterations
inv_mdl.RtR_prior=@prior_noser;  
inv_mdl.parameters.term_tolerance= 1e-5;

inv_mdl.hyperparameter.value = 0.1; % check 0.1 to 0.01 ...
% MDL_2.inv_solve_gn.elem_working = 'log_conductivity';
inv_mdl.jacobian_bkgnd.value= 0.05; % check
inv_mdl.fwd_model.coarse2fine = ...
       mk_coarse_fine_mapping(fine_mdl, coarse_mdl);
   
img4  = inv_solve(inv_mdl, v_baseline);   
figure
clf; 
axes('position',[.1,.1,.65,.8]);
fig1 = show_fem(img4,[1,1]); axis off; axis image % check threshold 
title('EIT absolute reconstruction height 15mm - distance 10mm', ...
'Fontsize', 14);
axes('position',[.8,.1,.15,.8]);
hold on
show_slices(img4, 5)
hold off
saveas(fig1,'reconstruction_3Dabs.fig');

figure
fig2 = show_slices(img4, [inf,inf,0.0125])
title('EIT absolute reconstruction slice ring of electrodes at 12.5mm', ...
'Fontsize', 25);
figure
fig3 = show_slices(img4, [inf,inf,0.0025])
title('EIT absolute reconstruction slice second ring of electrodes at 2.5mm', ...
'Fontsize', 25);

% 
% img.elem_data = ones(size(img4.elem_data))
meshio.write('eit_3D_abs_reconst.vtu',coarse_mdl.nodes, coarse_mdl.elems, {img4.elem_data},{'elem_data'});


%%
coarse_recon_img= mk_image(coarse_mdl, img4.elem_data);
figure
show_fem(coarse_recon_img); 
title('coarse model with reconstructed data', ...
'Fontsize', 14);


%% GET ELEMENTS AND FIND DIMENSIONS

% Threshold 
% elem = img4.elem_data;
% elem_thresholded = zeros(size(elem));
% Threshold = 0.9;
% index = find(elem>Threshold); % elem superior
% 
% 
% for i=length(elem)
%     elem_thresholded(index) = elem(elem>Threshold);
% end
% 
% img4.elem_data = elem_thresholded;
% figure
% show_fem(img4)
% title('EIT absolute reconstruction thresholded at 0.8', ...
% 'Fontsize', 25);
% 
