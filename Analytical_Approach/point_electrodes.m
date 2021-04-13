%% load the mesh into matlab

M=meshio.read('16FR/elliptical14mm_16FR.vtu'); % THE MESH IS IN MM

% create eidors stucture
MDL=eidors_obj('fwd_model','BalloonCatheter');

% specify nodes and triangulation
MDL.nodes = M.vtx./1000; % the 3d coordinates of the nodes IN METERS
MDL.elems = M.cells(4).tri; % which nodes create a tetrahedron 

% specify boundary elements - eidors needs this separately
[srf, idx] = find_boundary(M.cells(4).tri);
MDL.boundary = srf;
gnd_pos=[0,-0.01,0]; % looking at the figure from line 23, around here seems like a good spot
% find the nearest node to this point
gnd_dist=sqrt(sum((MDL.nodes - gnd_pos).^2,2));
[~, gnd_node] = min(gnd_dist);
MDL.gnd_node = gnd_node;

% Define electrodes z direction

% we are going to use "point" electrodes to start with, these are on a
% single node only. eidors requires a stucture with the surface nodes for
% each electrode, and the contact impedance

% as an example, let's define a ring of electrodes at Z =0 as per Sainas
% example
elecRingZ=[0.0025, 0.0125];
% radius of the inner bore hole
radius_centre=0.00235; % 0.00235

% create a ring of points
phi_offset = 0; 
nElecRing = 38; % number of electrodes in each ring 22 for 9fr - 34 for 14FR - 38 16FR

for iElec=1:nElecRing
    phi_e = 2*pi*(iElec-1)/nElecRing + phi_offset;
    elec_pos_ring(iElec,:) = radius_centre * [cos(phi_e) sin(phi_e)]; % center coordinates (0,0)
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
hold off

% create electrodes structure

z_contact=1e-3; % ohms per meter (this isnt that important in our application
% z_contact = 100; % ohms 
elec_radius = .008; %in meters 

% unique surface node references - this saves checking distance of nodes
% that are not on the surface

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
    x = M.vtx(MDL.electrode(i).nodes, 1);
    y = M.vtx(MDL.electrode(i).nodes, 2);
    phi_electrodes(i) = atan2(x,y);
end
% 
% for i = 1:length(electrodes)
%     if i < 44
%         phi_electrodes_diff(i) = phi_electrodes(i+1) - phi_electrodes(i);
%     end
% end 

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

% EIT measurements are defined in the following way:
% CS+ CS- V+ V-
% 1,2,1,6
% i.e. inject between 1 and 2, measure 1 referenced to 6 etc.

% in reality there are many factors that go into deciding the protocol
% choice, like hardware, time and noise constraints. here we can just do
% all of them - part of the project is to find which ones are important

% here we can just find unique possible electrode pairs
UniquePairs = nchoosek(1:N_elec,2);
nPairs=size(UniquePairs,1);
% measurements can be the same too

%doing it this way is lazy!
Protocol=[];
for iInj=1:nPairs

Protocol=[Protocol; repmat(UniquePairs(iInj,:),[nPairs,1]) UniquePairs];

end

Protocol = readmatrix('15mm_height/pointed16FR.xlsx', 'Range', 'A1:D10') % A1:D9, 6, 10
stim = stim_meas_list(Protocol, N_elec, Amp);
MDL.stimulation=stim;

%Check FWD is ok
%some nodes are not used which is bad
MDL=remove_unused_nodes(MDL);
if valid_fwd_model(MDL)
    disp('Forward model is ok! Yay!');
end

%% EIT Forward model

% conductivity - each element in mesh needs to be assigned a conductivity
% value in S/m

S=1.6; % conductivity in S/m this is based on 0.9% saline 
S_pert=S*1.05;

% Forward model simulates the electric fields in the chosen mesh for chosen
% electrode and stimulation pattern. This gives you all the voltages
% measurements you would get in an ideal experiment

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(MDL,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline = fwd_solve(img)
