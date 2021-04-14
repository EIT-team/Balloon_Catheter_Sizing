%% GET VOLTAGE BASELINE FROM SMALL MODEL

extra={'ball','solid ball = cylinder(0,0,0;0,0,1;0.1) and orthobrick(-1,-1,0;1,1,3) -maxh=0.05;'}
fmdl= ng_mk_cyl_models([3,0.4],[0],[],extra); 
figure
show_fem(fmdl);

% Define electrodes z direction
elecRingZ=[0.1, 2.9];
phi_offset = 0; 
radius_centre = 0.1;
nElecRing = 13; % number of electrodes in each ring

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
show_fem(fmdl);
hold on;
plot3(elec_pos(:,1),elec_pos(:,2),elec_pos(:,3), '.','Markersize',50); 
hold off

% create electrode structure
z_contact=1e-3;
elec_radius = .03;
for iElec = 1:size(elec_pos,1)
    
    %assign conductivity to structure
    electrodes(iElec).z_contact= z_contact;
    
    % find surface nodes within electrode radius
    edist = sqrt(sum((fmdl.nodes - elec_pos(iElec,:)).^2,2));
    [~,enode] = min(edist);

    electrodes(iElec).nodes = enode;
end

% add electrode strucutre to model struct
fmdl.electrode =     electrodes;

for i = 1:length(electrodes)
    position_electrodes = fmdl.nodes(fmdl.electrode(i).nodes, :)
end


figure
show_fem(fmdl)
title('Mesh with electrode locations');

% Forward model
fmdl.solve=          @fwd_solve_1st_order;
fmdl.jacobian=       @jacobian_adjoint;
fmdl.system_mat=     @system_mat_1st_order;
fmdl.normalize_measurements = 0;

Amp=141e-6; % Current amplitude in Amps this is the most you can inject below 1 kHz, but we are not really limited to that
N_elec=size(elec_pos,1);

UniquePairs = nchoosek(1:N_elec,2);
nPairs=size(UniquePairs,1);

Protocol=[];
for iInj=1:nPairs

    Protocol=[Protocol; repmat(UniquePairs(iInj,:),[nPairs,1]) UniquePairs];

end

% Protocol = [3 25, 4 26]
Protocol = readmatrix('sp_mp13.xlsx', 'Range', 'A1:D168') % A1:D462 
stim = stim_meas_list(Protocol, N_elec, Amp);
fmdl.stimulation=stim;

fmdl = remove_unused_nodes(fmdl);

if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end

S=1.6;
S_pert = S*1.05;
Inj_number = 1;
img = mk_image(fmdl,S);
img.fwd_solve.get_all_meas = 1;
v_baseline = fwd_solve(img)

img_v = rmfield(img, 'elem_data');
img_v.node_data = v_baseline.volt;
figure
img_v.calc_colours.cb_shrink_move = [.3,.8,-0.02];
show_slices(img_v)

%% MDL forward for reconstruction
extra={'ball','solid ball = cylinder(0,0,0;0,0,1;0.1) and orthobrick(-1,-1,0;1,1,3) -maxh=0.05;'}
rec_mdl= ng_mk_cyl_models([3,0.2],[0],[],extra); 
z_contact = 1e-10

for iElec = 1:size(elec_pos,1)
    
    %assign conductivity to structure
    electrodes3(iElec).z_contact= z_contact;
    
    % find surface nodes within electrode radius
    edist3 = sqrt(sum((rec_mdl.nodes - elec_pos(iElec,:)).^2,2));
    [~,enode3] = min(edist3);

    electrodes3(iElec).nodes = enode3;
end

rec_mdl.electrode =     electrodes3;

% forward model
rec_mdl.solve=          @fwd_solve_1st_order;
rec_mdl.jacobian=       @jacobian_adjoint;
rec_mdl.system_mat=     @system_mat_1st_order;
rec_mdl.normalize_measurements = 0;

% Convert protocol file to EIDORS stim patterns

Amp=141e-6; % Current amplitude in Amps this is the most you can inject below 1 kHz, but we are not really limited to that

N_elec=size(elec_pos,1);

UniquePairs = nchoosek(1:N_elec,2);
nPairs=size(UniquePairs,1);

Protocol=[];
for iInj=1:nPairs

Protocol=[Protocol; repmat(UniquePairs(iInj,:),[nPairs,1]) UniquePairs];

end

Protocol = readmatrix('sp_mp13.xlsx', 'Range', 'A1:D168') % A1:D462 
stim = stim_meas_list(Protocol, N_elec, Amp);
rec_mdl.stimulation=stim;

rec_mdl=remove_unused_nodes(rec_mdl);

figure
show_fem(rec_mdl)

%% Coarse model

extra={'ball','solid ball = cylinder(0,0,0;0,0,1;0.1) and orthobrick(-1,-1,0;1,1,3) -maxh=0.05;'}
coarse= ng_mk_cyl_models([3,0.2],[0],[],extra); 
show_fem(coarse)
%% Reconstruction absolute
% special parameter for this model absolute

% less elements for MDL_2
inv_mdl.name = 'Eit reconstruction 2'
inv_mdl = eidors_obj('inv_model', inv_mdl);
inv_mdl.solve = @inv_solve_gn; %Default Gauss Newton solvers 
inv_mdl.reconst_type = 'absolute'; 
inv_mdl.fwd_model = rec_mdl; % MDL_3 mesh with no electrodes and less dense 
inv_mdl.inv_solve_gn.max_iterations = 10 ; %Number of iterations
inv_mdl.RtR_prior=@prior_noser;  
inv_mdl.parameters.term_tolerance= 1e-5;

inv_mdl.hyperparameter.value = 0.05; % check 0.1 to 0.01 ...
inv_mdl.inv_solve_gn.elem_working = 'log_conductivity';
inv_mdl.jacobian_bkgnd.value= 0.01; % check
inv_mdl.fwd_model.coarse2fine = ...
       mk_coarse_fine_mapping(rec_mdl, coarse);

img4  = inv_solve(inv_mdl, v_baseline);   
figure
clf; 
axes('position',[.1,.1,.65,.8]);
show_fem(img4,[1,1]); axis off; axis image % check threshold 

title('EIT absolute reconstruction model 1 - distance 40mm', ...
'Fontsize', 14);
axes('position',[.8,.1,.15,.8]);
show_slices(img4, 5)

% meshio.write(elem data from img4)

meshio.write('eit_reconstruction.vtu',rec_mdl.nodes, rec_mdl.elems, {img4.elem_data},{'elem_data'});



