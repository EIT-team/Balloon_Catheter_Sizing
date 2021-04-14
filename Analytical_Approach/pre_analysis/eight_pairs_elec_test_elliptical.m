%% load the mesh into matlab

M=meshio.read('model5.vtu'); % THE MESH IS IN MM
save('model5', 'M')

% we can plot everything in this file:
figure
meshio.plot(M)


%% create eidors stucture

% create blank fwd object
MDL=eidors_obj('fwd_model','BalloonCatheter');

% specify nodes and triangulation
MDL.nodes = M.vtx./1000; % the 3d coordinates of the nodes IN METERS
MDL.elems = M.cells(4).tri; % which nodes create a tetrahedron 


quality = meshquality(MDL.nodes, MDL.elems);
mean_quality = mean(quality)

% specify boundary elements - eidors needs this separately
[srf, idx] = find_boundary(M.cells(4).tri);
MDL.boundary = srf;

gnd_pos=[0,-0.01,0]; % looking at the figure from line 23, around here seems like a good spot

% find the nearest node to this point
gnd_dist=sqrt(sum((MDL.nodes - gnd_pos).^2,2));
[~, gnd_node] = min(gnd_dist);
MDL.gnd_node = gnd_node;

%% Define electrodes z direction

% as an example, let's define a ring of electrodes at Z =0 as per Sainas
% example
elecRingZ=[0.0175, 0.0225];
% radius of the inner bore hole
radius_centre=0.0015;

% create a ring of points
phi_offset = 0; 
nElecRing = 8; % number of electrodes in each ring

for iElec=1:nElecRing
    % phi_e = (-1).^(iElec) * pi/2 ; % taking 2 opposite points on the ring
    if mod(iElec, 2) == 0
        phi_e = 2*pi*(iElec-1)/nElecRing + 0.25
    else 
        phi_e = 2*pi*(iElec-1)/nElecRing 
    end
    elec_pos_ring(iElec,:) = radius_centre * [cos(phi_e) sin(phi_e)] % center coordinates (0,0)
end


% create points in 3D
elec_pos=[];
nRing=length(elecRingZ);
for iRing=1:nRing
elec_pos=[elec_pos; elec_pos_ring repmat(elecRingZ(iRing),[nElecRing,1])];
end
figure;
show_fem(MDL);
hold on;
plot3(elec_pos(:,1),elec_pos(:,2),elec_pos(:,3), '.','Markersize',50); 
% plot3(elec_pos_2(:,1),elec_pos_2(:,2),elec_pos_2(:,3), '.','Markersize',50); 
hold off


%% create electrodes structure

% z_contact = 100; % ohms 
elec_radius = .008; %in meters 

% loop through each electrode
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
    M.vtx(MDL.electrode(i).nodes, :)
end


figure
show_fem(MDL)
title('Mesh with electrode locations');

%% Forward model settings

% set some default solver parameters we dont really ever need to change
% these for our purpose
MDL.solve=          @fwd_solve_1st_order;
MDL.jacobian=       @jacobian_adjoint;
MDL.system_mat=     @system_mat_1st_order;
MDL.normalize_measurements = 0;

% Convert protocol file to EIDORS stim patterns

Amp=141e-6; % Current amplitude in Amps this is the most you can inject below 1 kHz, but we are not really limited to that

N_elec=size(elec_pos,1);

% here we can just find unique possible electrode pairs
UniquePairs = nchoosek(1:N_elec,2);
nPairs=size(UniquePairs,1);
% measurements can be the same too

%doing it this way is lazy!
Protocol=[];
for iInj=1:nPairs

Protocol=[Protocol; repmat(UniquePairs(iInj,:),[nPairs,1]) UniquePairs];

end

% I am just running a single protocol line to make it quick
Protocol=[3 11, 2 10] % [2 6, 2 6] sector 2


% create eidors stimulation structure
[stim]= stim_meas_list( Protocol,N_elec,Amp);

MDL.stimulation=stim;

%% Check FWD is ok

%some nodes are not used which is bad
MDL=remove_unused_nodes(MDL);
if valid_fwd_model(MDL)
    disp('Forward model is ok! Yay!');
end

%% Conductivity values

% conductivity - each element in mesh needs to be assigned a conductivity
% value in S/m

S=1.6; % conductivity in S/m this is based on 0.9% saline 

% in this case we are going to define a region in the mesh that has changed
% conductivity
S_pert=S*1.05;

%% EIT Forward model

% Forward model simulates the electric fields in the chosen mesh for chosen
% electrode and stimulation pattern. This gives you all the voltages
% measurements you would get in an ideal experiment

% create img object and get "baseline" data. Setting each element to the
% conductivity S
img = mk_image(MDL,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline = fwd_solve(img)

%% Visualise sensitivity 
% 
% % each row in the jacobian shows the sensitivity of the measurement to changes in
% % conductivity in each element. i.e. how much does the voltage obtained change
% % if the conductivity in a particular element changes
% % These are all then combined to create a total sensitivity map. 
% 
% % get the jacobian for this model
% J= calc_jacobian(img);
% 
% % scale for element size
% J=J./(get_elem_volume(img.fwd_model)');
% 
% J = abs(J);
% 
% % sometimes its necessary to take dB to make it easier to visualise, the range of values are huge! 
% % J=log10(abs(J));
% 
% meshio.write('CLOSER1mm_8pairs_elec_model5_z1_2.vtu',MDL.nodes,MDL.elems,{J},{'J'});

