%% Control variables

inner_radius=2.65;
axis_a = 26/2;
axis_b = 20/2;

%number of electrodes in a ring
n_elec_ring = 8;


value_change_pos = pi;

% Protocol1 = [1 17, 2 18];
% Protocol2 = [2 18, 3 19];
% Protocol3 = [3 19, 4 20];
% Protocol4 = [4 20, 5 21];

Protocol1 = [1 9, 2 10];
Protocol2 = [2 10, 3 11];
Protocol3 = [3 11, 4 12];
Protocol4 = [4 12, 5 13];

shape = 'elliptical16fr';
%% now with square electrodes USE THIS ONE

% keep the mesh in meters and then divide nodes into mm as netgen gets
% confused with small coordinates and element sizes

%outer elliptic cylinder
height=40;

elec_width =0.1;
elec_height=0.3;
% ring heights
ring_z =[0 40];

%mesh element size
body_geometry.max_edge_length = 0.5;
elec_edge_size =0.05;

% outer cyl
body_geometry.intersection.elliptic_cylinder.top_center = [0, 0, height];
body_geometry.intersection.elliptic_cylinder.bottom_center = [0, 0, 0];
body_geometry.intersection.elliptic_cylinder.axis_a = [axis_a 0 0];
body_geometry.intersection.elliptic_cylinder.axis_b = [0 axis_b 0];

%inner cyl
body_geometry.intersection.cylinder.radius = inner_radius;
body_geometry.intersection.cylinder.top_center = [0, 0, 0];
body_geometry.intersection.cylinder.bottom_center = [0, 0, height];
body_geometry.intersection.cylinder.complement_flag = 1;

% add electrodes
nRing=length(ring_z);
%divide circle into evenly spaced centres
theta = linspace(0, value_change_pos, n_elec_ring+1); theta(end) = [];
theta=repmat(theta,[1,nRing]);
theta_degrees = rad2deg(theta);


elec_z=[];
for iRing=1:nRing
   elec_z=[elec_z, repmat(ring_z(iRing),[1,n_elec_ring])]; 
end


for iElec = 1:n_elec_ring*nRing   % find electrode centre
    elec_centre=[inner_radius*cos(theta(iElec)) inner_radius*sin(theta(iElec)) elec_z(iElec)];
    
    %direction normal to this point. we are assuming that the centre of the
    %mesh is 0,0,elec_z; and that direction has no z component i,e, are
    %pointing into centre
    
    dirn=elec_centre - [0,0,elec_z(iElec)];
    %normalise
    dirn = dirn/norm(dirn);
    %find perpendicular vector, assuming no z component
    dirnp = [-dirn(2),dirn(1),0];
    dirnp = dirnp/norm(dirnp);
    
    % the corners of the block can be described using the centre points and
    % translations along the directions dirn and dirp and z
    w = elec_width;
    h= elec_height;
    c=elec_centre;
    d=inner_radius*0.2; % try changing to bigger value 
    
    % bottom left
    bl = c - (d/2)* dirn + (w/2)*dirnp - [0,0,h/2];
    % top right (for ref)
    tr = c + (d/2)* dirn - (w/2)*dirnp + [0,0,h/2];
  
    %cannot use orthobrick as it always aligned to x/y/z, so instead we
    %need to use parallelepipd(!). defined by one vertex and three
    %vectors
    
    electrode_geometry{iElec}.parallelepiped.vertex   = bl;
    electrode_geometry{iElec}.parallelepiped.vector_a = dirn*(d);
    electrode_geometry{iElec}.parallelepiped.vector_b = -dirnp*(w);
    electrode_geometry{iElec}.parallelepiped.vector_c = [0,0,1]*h; 
    
    
    electrode_geometry{iElec}.max_edge_length = elec_edge_size;
    electrode_geometry{iElec}.keep_material_flag =0; 
    
end

fmdl = ng_mk_geometric_models(body_geometry,electrode_geometry);
fmdl.nodes = fmdl.nodes./1000;


%% mesh element size
% figure
% show_fem(fmdl)

%meshio.write('elliptical11mm_9fr.vtu',fmdl.nodes,fmdl.elems);

%%
fmdl.solve=          @fwd_solve_1st_order;
fmdl.jacobian=       @jacobian_adjoint;
fmdl.system_mat=     @system_mat_1st_order;
fmdl.normalize_measurements = 0;

Amp=141e-6;
N_elec = iElec;

%% PROTOCOLS 40mm

% PROTOCOL 1
stim = stim_meas_list(Protocol1,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_40mm_1 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);

name = strcat(shape, 'protocol1_40mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});

%% PROTOCOL 2
stim = stim_meas_list(Protocol2,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_40mm_2 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);

name = strcat(shape, 'protocol2_40mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});

%% PROTOCOL 3
stim = stim_meas_list(Protocol3,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_40mm_3 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);


name = strcat(shape, 'protocol3_40mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});

%% PROTOCOL 4
stim = stim_meas_list(Protocol4,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_40mm_4 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);

min_J = min(J);
max_J = max(J);

%J=log10(abs(J));


name = strcat(shape, 'protocol4_40mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});

%% now with square electrodes USE THIS ONE

% keep the mesh in meters and then divide nodes into mm as netgen gets
% confused with small coordinates and element sizes

%outer elliptic cylinder
height=40;

elec_width =0.1;
elec_height=0.3;
% ring heights
ring_z =[5 35];

%mesh element size
body_geometry.max_edge_length = 0.5;
elec_edge_size =0.05;

% outer cyl
body_geometry.intersection.elliptic_cylinder.top_center = [0, 0, height];
body_geometry.intersection.elliptic_cylinder.bottom_center = [0, 0, 0];
body_geometry.intersection.elliptic_cylinder.axis_a = [axis_a 0 0];
body_geometry.intersection.elliptic_cylinder.axis_b = [0 axis_b 0];

%inner cyl
body_geometry.intersection.cylinder.radius = inner_radius;
body_geometry.intersection.cylinder.top_center = [0, 0, 0];
body_geometry.intersection.cylinder.bottom_center = [0, 0, height];
body_geometry.intersection.cylinder.complement_flag = 1;

% add electrodes
nRing=length(ring_z);
%divide circle into evenly spaced centres
theta = linspace(0, value_change_pos, n_elec_ring+1); theta(end) = [];
theta=repmat(theta,[1,nRing]);
theta_degrees = rad2deg(theta);


elec_z=[];
for iRing=1:nRing
   elec_z=[elec_z, repmat(ring_z(iRing),[1,n_elec_ring])]; 
end


for iElec = 1:n_elec_ring*nRing   % find electrode centre
    elec_centre=[inner_radius*cos(theta(iElec)) inner_radius*sin(theta(iElec)) elec_z(iElec)];
    
    %direction normal to this point. we are assuming that the centre of the
    %mesh is 0,0,elec_z; and that direction has no z component i,e, are
    %pointing into centre
    
    dirn=elec_centre - [0,0,elec_z(iElec)];
    %normalise
    dirn = dirn/norm(dirn);
    %find perpendicular vector, assuming no z component
    dirnp = [-dirn(2),dirn(1),0];
    dirnp = dirnp/norm(dirnp);
    
    % the corners of the block can be described using the centre points and
    % translations along the directions dirn and dirp and z
    w = elec_width;
    h= elec_height;
    c=elec_centre;
    d=inner_radius*0.2; % try changing to bigger value 
    
    % bottom left
    bl = c - (d/2)* dirn + (w/2)*dirnp - [0,0,h/2];
    % top right (for ref)
    tr = c + (d/2)* dirn - (w/2)*dirnp + [0,0,h/2];
  
    %cannot use orthobrick as it always aligned to x/y/z, so instead we
    %need to use parallelepipd(!). defined by one vertex and three
    %vectors
    
    electrode_geometry{iElec}.parallelepiped.vertex   = bl;
    electrode_geometry{iElec}.parallelepiped.vector_a = dirn*(d);
    electrode_geometry{iElec}.parallelepiped.vector_b = -dirnp*(w);
    electrode_geometry{iElec}.parallelepiped.vector_c = [0,0,1]*h; 
    
    
    electrode_geometry{iElec}.max_edge_length = elec_edge_size;
    electrode_geometry{iElec}.keep_material_flag =0; 
    
end

fmdl = ng_mk_geometric_models(body_geometry,electrode_geometry);
fmdl.nodes = fmdl.nodes./1000;



%% mesh element size
% figure
% show_fem(fmdl)

%meshio.write('elliptical11mm_9fr.vtu',fmdl.nodes,fmdl.elems);

%%
fmdl.solve=          @fwd_solve_1st_order;
fmdl.jacobian=       @jacobian_adjoint;
fmdl.system_mat=     @system_mat_1st_order;
fmdl.normalize_measurements = 0;

Amp=141e-6;
N_elec = iElec;

%% PROTOCOLS 30mm

% PROTOCOL 1
stim = stim_meas_list(Protocol1,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_30mm_1 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);

name = strcat(shape, 'protocol1_30mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});
%% PROTOCOL 2
stim = stim_meas_list(Protocol2,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_30mm_2 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);

name = strcat(shape, 'protocol2_30mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});

%% PROTOCOL 3
stim = stim_meas_list(Protocol3,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_30mm_3 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);

name = strcat(shape, 'protocol3_30mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});

%% PROTOCOL 4
stim = stim_meas_list(Protocol4,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_30mm_4 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);


name = strcat(shape, 'protocol4_30mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});

%% now with square electrodes USE THIS ONE

% keep the mesh in meters and then divide nodes into mm as netgen gets
% confused with small coordinates and element sizes

%outer elliptic cylinder
height=40;

elec_width =0.1;
elec_height=0.3;
% ring heights
ring_z =[10 30];

%mesh element size
body_geometry.max_edge_length = 0.5;
elec_edge_size =0.05;

% outer cyl
body_geometry.intersection.elliptic_cylinder.top_center = [0, 0, height];
body_geometry.intersection.elliptic_cylinder.bottom_center = [0, 0, 0];
body_geometry.intersection.elliptic_cylinder.axis_a = [axis_a 0 0];
body_geometry.intersection.elliptic_cylinder.axis_b = [0 axis_b 0];

%inner cyl
body_geometry.intersection.cylinder.radius = inner_radius;
body_geometry.intersection.cylinder.top_center = [0, 0, 0];
body_geometry.intersection.cylinder.bottom_center = [0, 0, height];
body_geometry.intersection.cylinder.complement_flag = 1;

% add electrodes
nRing=length(ring_z);
%divide circle into evenly spaced centres
theta = linspace(0, value_change_pos, n_elec_ring+1); theta(end) = [];
theta=repmat(theta,[1,nRing]);
theta_degrees = rad2deg(theta);


elec_z=[];
for iRing=1:nRing
   elec_z=[elec_z, repmat(ring_z(iRing),[1,n_elec_ring])]; 
end


for iElec = 1:n_elec_ring*nRing   % find electrode centre
    elec_centre=[inner_radius*cos(theta(iElec)) inner_radius*sin(theta(iElec)) elec_z(iElec)];
    
    %direction normal to this point. we are assuming that the centre of the
    %mesh is 0,0,elec_z; and that direction has no z component i,e, are
    %pointing into centre
    
    dirn=elec_centre - [0,0,elec_z(iElec)];
    %normalise
    dirn = dirn/norm(dirn);
    %find perpendicular vector, assuming no z component
    dirnp = [-dirn(2),dirn(1),0];
    dirnp = dirnp/norm(dirnp);
    
    % the corners of the block can be described using the centre points and
    % translations along the directions dirn and dirp and z
    w = elec_width;
    h= elec_height;
    c=elec_centre;
    d=inner_radius*0.2; % try changing to bigger value 
    
    % bottom left
    bl = c - (d/2)* dirn + (w/2)*dirnp - [0,0,h/2];
    % top right (for ref)
    tr = c + (d/2)* dirn - (w/2)*dirnp + [0,0,h/2];
  
    %cannot use orthobrick as it always aligned to x/y/z, so instead we
    %need to use parallelepipd(!). defined by one vertex and three
    %vectors
    
    electrode_geometry{iElec}.parallelepiped.vertex   = bl;
    electrode_geometry{iElec}.parallelepiped.vector_a = dirn*(d);
    electrode_geometry{iElec}.parallelepiped.vector_b = -dirnp*(w);
    electrode_geometry{iElec}.parallelepiped.vector_c = [0,0,1]*h; 
    
    
    electrode_geometry{iElec}.max_edge_length = elec_edge_size;
    electrode_geometry{iElec}.keep_material_flag =0; 
    
end

fmdl = ng_mk_geometric_models(body_geometry,electrode_geometry);
fmdl.nodes = fmdl.nodes./1000;

%% mesh element size
% figure
% show_fem(fmdl)

%meshio.write('elliptical11mm_9fr.vtu',fmdl.nodes,fmdl.elems);

%%
fmdl.solve=          @fwd_solve_1st_order;
fmdl.jacobian=       @jacobian_adjoint;
fmdl.system_mat=     @system_mat_1st_order;
fmdl.normalize_measurements = 0;

Amp=141e-6;
N_elec = iElec;

%% PROTOCOLS 20mm

% PROTOCOL 1
stim = stim_meas_list(Protocol1,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_20mm_1 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);


name = strcat(shape, 'protocol1_20mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});

%% PROTOCOL 2
stim = stim_meas_list(Protocol2,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_20mm_2 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);

name = strcat(shape, 'protocol2_20mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});

%% PROTOCOL 3
stim = stim_meas_list(Protocol3,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_20mm_3 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);


name = strcat(shape, 'protocol3_20mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});

%% PROTOCOL 4
stim = stim_meas_list(Protocol4,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_20mm_4 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);

name = strcat(shape, 'protocol4_20mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});

%% now with square electrodes USE THIS ONE

% keep the mesh in meters and then divide nodes into mm as netgen gets
% confused with small coordinates and element sizes

%outer elliptic cylinder
height=40;

elec_width =0.1;
elec_height=0.3;
% ring heights
ring_z =[15 25];

%mesh element size
body_geometry.max_edge_length = 0.5;
elec_edge_size =0.05;

% outer cyl
body_geometry.intersection.elliptic_cylinder.top_center = [0, 0, height];
body_geometry.intersection.elliptic_cylinder.bottom_center = [0, 0, 0];
body_geometry.intersection.elliptic_cylinder.axis_a = [axis_a 0 0];
body_geometry.intersection.elliptic_cylinder.axis_b = [0 axis_b 0];

%inner cyl
body_geometry.intersection.cylinder.radius = inner_radius;
body_geometry.intersection.cylinder.top_center = [0, 0, 0];
body_geometry.intersection.cylinder.bottom_center = [0, 0, height];
body_geometry.intersection.cylinder.complement_flag = 1;

% add electrodes
nRing=length(ring_z);
%divide circle into evenly spaced centres
theta = linspace(0, value_change_pos, n_elec_ring+1); theta(end) = [];
theta=repmat(theta,[1,nRing]);
theta_degrees = rad2deg(theta);


elec_z=[];
for iRing=1:nRing
   elec_z=[elec_z, repmat(ring_z(iRing),[1,n_elec_ring])]; 
end


for iElec = 1:n_elec_ring*nRing   % find electrode centre
    elec_centre=[inner_radius*cos(theta(iElec)) inner_radius*sin(theta(iElec)) elec_z(iElec)];
    
    %direction normal to this point. we are assuming that the centre of the
    %mesh is 0,0,elec_z; and that direction has no z component i,e, are
    %pointing into centre
    
    dirn=elec_centre - [0,0,elec_z(iElec)];
    %normalise
    dirn = dirn/norm(dirn);
    %find perpendicular vector, assuming no z component
    dirnp = [-dirn(2),dirn(1),0];
    dirnp = dirnp/norm(dirnp);
    
    % the corners of the block can be described using the centre points and
    % translations along the directions dirn and dirp and z
    w = elec_width;
    h= elec_height;
    c=elec_centre;
    d=inner_radius*0.2; % try changing to bigger value 
    
    % bottom left
    bl = c - (d/2)* dirn + (w/2)*dirnp - [0,0,h/2];
    % top right (for ref)
    tr = c + (d/2)* dirn - (w/2)*dirnp + [0,0,h/2];
  
    %cannot use orthobrick as it always aligned to x/y/z, so instead we
    %need to use parallelepipd(!). defined by one vertex and three
    %vectors
    
    electrode_geometry{iElec}.parallelepiped.vertex   = bl;
    electrode_geometry{iElec}.parallelepiped.vector_a = dirn*(d);
    electrode_geometry{iElec}.parallelepiped.vector_b = -dirnp*(w);
    electrode_geometry{iElec}.parallelepiped.vector_c = [0,0,1]*h; 
    
    
    electrode_geometry{iElec}.max_edge_length = elec_edge_size;
    electrode_geometry{iElec}.keep_material_flag =0; 
    
end

fmdl = ng_mk_geometric_models(body_geometry,electrode_geometry);
fmdl.nodes = fmdl.nodes./1000;

%% mesh element size
% figure
% show_fem(fmdl)

%meshio.write('elliptical11mm_9fr.vtu',fmdl.nodes,fmdl.elems);

%%
fmdl.solve=          @fwd_solve_1st_order;
fmdl.jacobian=       @jacobian_adjoint;
fmdl.system_mat=     @system_mat_1st_order;
fmdl.normalize_measurements = 0;

Amp=141e-6;
N_elec = iElec;

%% PROTOCOLS

% PROTOCOL 1
stim = stim_meas_list(Protocol1,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_10mm_1 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);

name = strcat(shape, 'protocol1_10mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});
%% PROTOCOL 2
stim = stim_meas_list(Protocol2,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_10mm_2 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);

name = strcat(shape, 'protocol2_10mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});

%% PROTOCOL 3
stim = stim_meas_list(Protocol3,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_10mm_3 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);

name = strcat(shape, 'protocol3_10mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});
%% PROTOCOL 4
stim = stim_meas_list(Protocol4,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_10mm_4 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);

name = strcat(shape, 'protocol4_10mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});
%% now with square electrodes USE THIS ONE

% keep the mesh in meters and then divide nodes into mm as netgen gets
% confused with small coordinates and element sizes

%outer elliptic cylinder
height=40;

elec_width =0.1;
elec_height=0.3;
% ring heights
ring_z =[17.5 22.5];

%mesh element size
body_geometry.max_edge_length = 0.5;
elec_edge_size =0.05;

% outer cyl
body_geometry.intersection.elliptic_cylinder.top_center = [0, 0, height];
body_geometry.intersection.elliptic_cylinder.bottom_center = [0, 0, 0];
body_geometry.intersection.elliptic_cylinder.axis_a = [axis_a 0 0];
body_geometry.intersection.elliptic_cylinder.axis_b = [0 axis_b 0];

%inner cyl
body_geometry.intersection.cylinder.radius = inner_radius;
body_geometry.intersection.cylinder.top_center = [0, 0, 0];
body_geometry.intersection.cylinder.bottom_center = [0, 0, height];
body_geometry.intersection.cylinder.complement_flag = 1;

% add electrodes
nRing=length(ring_z);
%divide circle into evenly spaced centres
theta = linspace(0, value_change_pos, n_elec_ring+1); theta(end) = [];
theta=repmat(theta,[1,nRing]);
theta_degrees = rad2deg(theta);


elec_z=[];
for iRing=1:nRing
   elec_z=[elec_z, repmat(ring_z(iRing),[1,n_elec_ring])]; 
end


for iElec = 1:n_elec_ring*nRing   % find electrode centre
    elec_centre=[inner_radius*cos(theta(iElec)) inner_radius*sin(theta(iElec)) elec_z(iElec)];
    
    %direction normal to this point. we are assuming that the centre of the
    %mesh is 0,0,elec_z; and that direction has no z component i,e, are
    %pointing into centre
    
    dirn=elec_centre - [0,0,elec_z(iElec)];
    %normalise
    dirn = dirn/norm(dirn);
    %find perpendicular vector, assuming no z component
    dirnp = [-dirn(2),dirn(1),0];
    dirnp = dirnp/norm(dirnp);
    
    % the corners of the block can be described using the centre points and
    % translations along the directions dirn and dirp and z
    w = elec_width;
    h= elec_height;
    c=elec_centre;
    d=inner_radius*0.2; % try changing to bigger value 
    
    % bottom left
    bl = c - (d/2)* dirn + (w/2)*dirnp - [0,0,h/2];
    % top right (for ref)
    tr = c + (d/2)* dirn - (w/2)*dirnp + [0,0,h/2];
  
    %cannot use orthobrick as it always aligned to x/y/z, so instead we
    %need to use parallelepipd(!). defined by one vertex and three
    %vectors
    
    electrode_geometry{iElec}.parallelepiped.vertex   = bl;
    electrode_geometry{iElec}.parallelepiped.vector_a = dirn*(d);
    electrode_geometry{iElec}.parallelepiped.vector_b = -dirnp*(w);
    electrode_geometry{iElec}.parallelepiped.vector_c = [0,0,1]*h; 
    
    
    electrode_geometry{iElec}.max_edge_length = elec_edge_size;
    electrode_geometry{iElec}.keep_material_flag =0; 
    
end

fmdl = ng_mk_geometric_models(body_geometry,electrode_geometry);
fmdl.nodes = fmdl.nodes./1000;



%% mesh element size
% figure
% show_fem(fmdl)

%meshio.write('elliptical11mm_9fr.vtu',fmdl.nodes,fmdl.elems);

%%
fmdl.solve=          @fwd_solve_1st_order;
fmdl.jacobian=       @jacobian_adjoint;
fmdl.system_mat=     @system_mat_1st_order;
fmdl.normalize_measurements = 0;

Amp=141e-6;
N_elec = iElec;

%% PROTOCOLS

% PROTOCOL 1
stim = stim_meas_list(Protocol1,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_5mm_1 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);

name = strcat(shape, 'protocol1_5mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});
%% PROTOCOL 2
stim = stim_meas_list(Protocol2,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_5mm_2 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);

name = strcat(shape, 'protocol2_5mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});
%% PROTOCOL 3
stim = stim_meas_list(Protocol3,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_5mm_3 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);

min_J = min(J);
max_J = max(J);

%J=log10(abs(J));

name = strcat(shape, 'protocol3_5mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});

%% PROTOCOL 4
Protocol4 = [4 12, 5 13]
stim = stim_meas_list(Protocol4,N_elec, Amp);
fmdl.stimulation = stim;

% Check FWD is ok
%some nodes are not used which is bad
fmdl=remove_unused_nodes(fmdl);
if valid_fwd_model(fmdl)
    disp('Forward model is ok! Yay!');
end


% Solve all voltage patterns
S=1.6;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
Inj_number = 1
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
v_baseline_5mm_4 = fwd_solve(img)

% sensitivity analysis

% get the jacobian for this model
J= calc_jacobian(img);

% % scale for element size
J=J./(get_elem_volume(img.fwd_model)');
J=abs(J);

name = strcat(shape, 'protocol4_5mm.vtu')
meshio.write(name,fmdl.nodes,fmdl.elems,{J},{'J'});


