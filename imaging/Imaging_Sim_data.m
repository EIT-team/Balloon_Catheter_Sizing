run('C:\Users\djave\Downloads\eidors-v3.10-ng\eidors\startup.m')
eidors_cache( 'clear_all' );

% Example imaging pipeline with simulated data

%% fixed options


% opt.max_edge_length = 0.5;
% opt.elec_edge_size =0.05;

opt.max_edge_length = 1;
opt.elec_edge_size =0.1;

opt.height=40;
opt.inner_radius=2.6501; %9fr


opt.axis_a = 30/2;
opt.axis_b = opt.axis_a;

%number of electrodes in a ring
opt.n_elec_ring = 8;

%how much of the ring do the electrodes take up i.e pi means 8 elecs in
%quatre of ring
opt.value_change_pos = 2*pi;

opt.Amp=141e-6;
opt.S=1.6;

%width, height
elec_geom=[1 2];

% ring heights
ring_z =[15 25];

%%
DoMesh =0;

if DoMesh
    
    fmdl=makemesh(ring_z,elec_geom,opt);
    show_fem(fmdl,[0,1.025])
    
    save(['imagingoutput/mesh'],'fmdl','elec_geom','ring_z','opt');
    
else
    load(['imagingoutput/mesh']);
end


%% contact impedance

% z_contact = ContactR * electrode area

width=(elec_geom(1)/1000);
height=(elec_geom(2)/1000);
r=opt.inner_radius/1000;

elec_area=(width * height);

% actually slightly bigger as its an arc on surface
elec_area_arc=2*asin((width/2)/r) * r * height;

% impedance measured for electrode impedance
elec_impedance = 200;
z_contact=elec_impedance * elec_area_arc;



for iElec=1:length(fmdl.electrode)
fmdl.electrode(iElec).z_contact = z_contact;
end



%% make protocol

% inject across rings and measure across rings - add measurements on each
% ring?

N_elec = size(fmdl.electrode,2);

% across
inj_chn_opp=[(1:8)' (9:16)'];
meas_chn_opp=[(1:8)' (9:16)'];


Ninj=length(inj_chn_opp);
Nmeas=length(meas_chn_opp);
protocol_opp=zeros(Ninj*Nmeas,4);

for iInj= 1:Ninj
    cIdx=1+(iInj-1)*Ninj;
    protocol_opp(cIdx:cIdx+Nmeas-1,:)=[repmat(inj_chn_opp(iInj,:),[Nmeas,1]), meas_chn_opp];
end

% each ring

inj_chn_adj=[(1:8)' circshift((1:8)',[-1])];
meas_chn_adj = [(1:8)' circshift((1:8)',[-1])];

Ninj=length(inj_chn_adj);
Nmeas=length(meas_chn_adj);
protocol_adj=zeros(Ninj*Nmeas,4);

for iInj= 1:Ninj
    cIdx=1+(iInj-1)*Ninj;
    protocol_adj(cIdx:cIdx+Nmeas-1,:)=[repmat(inj_chn_adj(iInj,:),[Nmeas,1]), meas_chn_adj];
end

protocol=[protocol_opp; protocol_adj; protocol_adj+8];

[stim] = stim_meas_list(protocol,N_elec, opt.Amp);

meas_sel=logical(zeros(length(protocol),1));
for iPrt=1:length(protocol)
    meas_sel(iPrt)=~any(ismember(protocol(iPrt,[1 2]),protocol(iPrt,[3 4])));
end

%%
[data,img] = runfwd(fmdl,stim,opt);

%% create perturbation fwd

fmdl_p=fmdl;
opt_p=opt;

% define perturbation as a circle with radius and x y centre
pert_loc=[0.01, 0.008,0.02];
pert_radius=0.006;

% find elements of mesh within the radius of circle

% find centres of all elements
elem_cnts=(fmdl.nodes(fmdl.elems(:,1),:)+ ...
    fmdl.nodes(fmdl.elems(:,2),:)+ ...
    fmdl.nodes(fmdl.elems(:,3),:)+ ...
    fmdl.nodes(fmdl.elems(:,4),:))./4;

%find elements within radius
dist_pert=sum((elem_cnts-pert_loc).^2,2).^0.5;

% find element index within perturbation
pert_idx=find(dist_pert <= pert_radius);


Sp=0.001;
Svec=(img.elem_data);
Svec(pert_idx)=Sp;

opt_p.S=Svec;

[data_p,img_p] = runfwd(fmdl_p,stim,opt_p);
show_fem(img_p)


save(['imagingoutput/fwd_data'],'data','data_p','meas_sel','fmdl','fmdl_p');

%%
if ~exist('data','var')
    load(['imagingoutput/fwd_data'])
    
end

%%
figure
hold on
plot(data.meas(meas_sel));
plot(data_p.meas(meas_sel));
grid minor
hold off

%% make reconstruction  mesh

[Mesh_hex,J_hex] = convert_fine2coarse(fmdl.elems,fmdl.nodes,data.J,0.0012);

Sens = (sum(J_hex(meas_sel, :).^2, 1).^0.5);

writeVTKcell_hex(['imagingoutput/hexmesh_J'],Mesh_hex.Hex,Mesh_hex.Nodes,Mesh_hex.k); % no noise based correction

%% Tik0

dV= data_p.meas-data.meas;


dV=dV(meas_sel,:);

figure
plot(dV');
title('dV')

[Usvd,Ssvd,Vsvd] = svd(J_hex(meas_sel, :),'econ'); % do this here to avoid doing it over and over again
n=3e-6*randn(500,length(dV)); % estimate of the noise in the measurments, we dont have any here so just make it up
lambda = logspace(-15,-2,400); % the range of regularisation parameters to try

[Sigma,X,sv_i]=eit_recon_tik0(dV',J_hex(meas_sel, :),['imagingoutput/rec_'],n,Usvd,Ssvd,Vsvd,lambda);


writeVTKcell_hex(['imagingoutput/rec_hex_'],Mesh_hex.Hex,Mesh_hex.Nodes,Sigma); % with correction added


%% Tik1

[Mesh_hex_Tik1,J_hex_Tik1] = convert_fine2coarse(fmdl.elems,fmdl.nodes,data.J,0.004);


% %remove hexes that arent of interest like the edge and centre ones
% good_hex = Mesh_hex_Tik1.k > 400;
%
% Mesh_hex_Tik1.Hex=Mesh_hex_Tik1.Hex(good_hex,:);

Sens = (sum(J_hex_Tik1(meas_sel, :).^2, 1).^0.5);

writeVTKcell_hex(['imagingoutput/hexmesh_J_Tik1'],Mesh_hex_Tik1.Hex,Mesh_hex_Tik1.Nodes,Mesh_hex_Tik1.k); % no noise based correction

%% Tik 1 Connectivity

element_size=Mesh_hex_Tik1.d/1000;


xyz = (Mesh_hex_Tik1.Nodes(Mesh_hex_Tik1.Hex(:,1),:) + Mesh_hex_Tik1.Nodes(Mesh_hex_Tik1.Hex(:,2),:) + ...
    Mesh_hex_Tik1.Nodes(Mesh_hex_Tik1.Hex(:,3),:) + Mesh_hex_Tik1.Nodes(Mesh_hex_Tik1.Hex(:,4),:) + ...
    Mesh_hex_Tik1.Nodes(Mesh_hex_Tik1.Hex(:,5),:) + Mesh_hex_Tik1.Nodes(Mesh_hex_Tik1.Hex(:,6),:))./6000; %divide by 6 if HEX-mesh is in metres
tic

L = gen_Laplacian_matrix(xyz,element_size);
disp(sprintf('Laplacian done: %.2f min.',toc/60));

% do the GSVD
[U,sm,X,~,~] = cgsvd(J_hex_Tik1(meas_sel, :),L);
disp(sprintf('GSVD done: %.2f min.',toc/60));


%%
% my lambda is usually: logspace(-15,10,3000)
% and I use either lambda(1300) or lambda(1400) for the reconstructions

lambda_vec=logspace(-10,15,3000);

% comment out if you want to save all recs with all lambda
lambda=lambda_vec(100);
% lambda=lambda_vec;

[x_lambda,rho,eta] = tikhonov(U,sm,X,dV,lambda); % lambda can be single value or vector

figure;
loglog(rho,eta)

%%
writeVTKcell_hex(['imagingoutput/rec_hex_Tik1'],Mesh_hex_Tik1.Hex,Mesh_hex_Tik1.Nodes,x_lambda);



%%
function [data,img] = runfwd(fmdl,stim,opt)


%%
fmdl.solve=          @fwd_solve_1st_order;
fmdl.jacobian=       @jacobian_adjoint;
fmdl.system_mat=     @system_mat_1st_order;
fmdl.normalize_measurements = 0;

%% PROTOCOLS 40mm

% PROTOCOL 1
fmdl.stimulation = stim;

% Check FWD is ok
try
    valid_fwd_model(fmdl);
catch
end

% Solve all voltage patterns
S=opt.S;

% create img object and get "baseline" data. Setting each element to the
% conductivity S
img = mk_image(fmdl,S);
% we want all the outputs because we want to see the current flow
img.fwd_solve.get_all_meas = 1;
% solve the fwd model for this img to get baseline voltages
data = fwd_solve(img);

% sensitivity analysis

% get the jacobian for this model
data.J= calc_jacobian(img);

% % scale for element size
% J=J./(get_elem_volume(img.fwd_model)');
% J=abs(J);
end
%%

function fmdl = makemesh(ring_z,elec_geom,opt)


%outer elliptic cylinder
height=opt.height;

axis_a=opt.axis_a;
axis_b=opt.axis_b;
inner_radius = opt.inner_radius;
value_change_pos=opt.value_change_pos;
n_elec_ring=opt.n_elec_ring;


elec_width =elec_geom(1);
elec_height=elec_geom(2);
% ring heights
% ring_z =[0 40];

%mesh element size
body_geometry.max_edge_length = opt.max_edge_length;
elec_edge_size =opt.elec_edge_size;

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
end