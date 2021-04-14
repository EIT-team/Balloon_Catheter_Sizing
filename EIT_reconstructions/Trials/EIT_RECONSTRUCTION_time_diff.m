%% GET VOLTAGE BASELINE FROM SMALL MODEL

M=meshio.read('model1.vtu'); % THE MESH IS IN MM
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
elecRingZ=[0.005, 0.035];
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
Protocol = readmatrix('sp_mp560.xlsx', 'Range', 'A1:D560') % A1:D462 
stim = stim_meas_list(Protocol, N_elec, Amp);
MDL.stimulation=stim;

MDL = remove_unused_nodes(MDL);
% MDL=remove_unused_nodes(MDL);
if valid_fwd_model(MDL)
    disp('Forward model is ok! Yay!');
end

S_deflated = 0.16; % balloon deflate
S=1.6;
S_pert = S*1.05;
Inj_number = 1;
img = mk_image(MDL,S);
img.fwd_solve.get_all_meas = 1;
v_baseline = fwd_solve(img)

img_v = rmfield(img, 'elem_data');
img_v.node_data = v_baseline.volt;
figure
img_v.calc_colours.cb_shrink_move = [.3,.8,-0.02];
show_slices(img_v)

% Earlier in time data
img_0 = mk_image(MDL, S_deflated)
img_0.fwd_solve.get_all_meas = 1;
v_deflated = fwd_solve(img_0);

figure
plot([v_deflated.meas, v_baseline.meas]);

%% Fine model as forward model

fine_model=meshio.read('fine_models/fine_model2_no_loft_2Xdiam_3mm.vtu'); 
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

Protocol = readmatrix('sp_mp560.xlsx', 'Range', 'A1:D560') % A1:D462 
stim = stim_meas_list(Protocol, N_elec, Amp);
fine_mdl.stimulation=stim;

fine_mdl=remove_unused_nodes(fine_mdl);

figure
show_fem(fine_mdl)

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
coarse_model =meshio.read('coarse/coarse_model2_no_loft_2Xdiam_3mm.vtu'); 
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
inv_mdl.solve = @eidors_default; %Default 
inv_mdl.reconst_type = 'difference'; 
inv_mdl.fwd_model = fine_mdl; % MDL_3 mesh with no electrodes and less dense 
inv_mdl.inv_solve_gn.max_iterations = 10 ; %Number of iterations
inv_mdl.RtR_prior=@prior_noser;  
% inv_mdl.parameters.term_tolerance= 1e-5;

inv_mdl.hyperparameter.value = 0.1; % check 0.1 to 0.01 ...
% MDL_2.inv_solve_gn.elem_working = 'log_conductivity';
inv_mdl.jacobian_bkgnd.value= 5; % check
% MDL_2.inv_solve_core.update_method = 'pcg';
inv_mdl.fwd_model.coarse2fine = ...
       mk_coarse_fine_mapping(fine_mdl, coarse_mdl);
   
img4  = inv_solve(inv_mdl, v_deflated, v_baseline);   
figure
clf; 
axes('position',[.1,.1,.65,.8]);
show_fem(img4,[1,1]); axis off; axis image % check threshold 

title('EIT time-difference reconstruction model 1 3mm - distance 30mm', ...
'Fontsize', 14);
axes('position',[.8,.1,.15,.8]);
show_slices(img4, 5)

img.elem_data = ones(size(img4.elem_data))
meshio.write('eit_reconstruction_model1_6mm.vtu',coarse_mdl.nodes, coarse_mdl.elems, {img4.elem_data},{'elem_data'});

coarse_recon_img= mk_image(coarse_mdl, img4.elem_data);
figure
show_fem( coarse_recon_img ); 