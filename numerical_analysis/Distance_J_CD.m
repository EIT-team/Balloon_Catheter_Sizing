%run('\eidors-v3.10-ng\eidors\startup.m')
eidors_cache( 'clear_all' );

% Find spread of sensitivity and current for different electrode spacings
% and sizes

%% fixed options

opt.max_edge_length = 0.5;
opt.elec_edge_size =0.05;

opt.height=40;
opt.inner_radius=2.65; %9fr
opt.axis_a = 26/2;
opt.axis_b = 20/2;

%number of electrodes in a ring
opt.n_elec_ring = 8;

%how much of the ring do the electrodes take up i.e pi means 8 elecs in
%quatre of ring
opt.value_change_pos = pi;


opt.Amp=141e-6;
opt.S=1.6;

elec_geom=[0.1 0.3];

elec_gap=40:-5:5;

ring_z_all(:,1)=20+[-1].*(elec_gap)./2;
ring_z_all(:,2)=20+[+1].*(elec_gap)./2;

Protocol1 = [1 9, 2 10];
Protocol2 = [2 10, 3 11];
Protocol3 = [3 11, 4 12];
Protocol4 = [4 12, 5 13];

Protocol=[Protocol1;Protocol2;Protocol3;Protocol4];


% flags to choose whether to load data or calculate again
DoFwd=1;
DoSpread=1;


%% get data

if DoFwd

    for iGap=1:size(ring_z_all,1)

        ring_z=ring_z_all(iGap,:);

        fmdl=makemesh(ring_z,elec_geom,opt);
        datacur=runfwd(fmdl,Protocol,opt);

        mdls(iGap)=fmdl;
        data(iGap)=datacur;

        elemcurrent{iGap}=getcurrent(mdls(iGap),data(iGap),opt);


    end

    save(['distanceoutput/mesh_fwd'],'mdls','data','elemcurrent');

end


if ~DoFwd
    load('distanceoutput/mesh_fwd.mat');
end
%% measure spread

if DoSpread

    for iGap=1:size(ring_z_all,1)
        S(iGap)=getspread(mdls(iGap),data(iGap),elemcurrent{iGap},ring_z_all(iGap,:),[0.1,0.9],opt);

    end

    save(['distanceoutput/Spread'],'S');

else
    load('distanceoutput/Spread')

end




%%
for iGap=1:size(ring_z_all,1)

    Jwidth(iGap,:)=S(iGap).J_width;
    CDwidth(iGap,:)=S(iGap).cd_width;

    Jthres(iGap,:)=S(iGap).J_thres;
    CDthres(iGap,:)=S(iGap).cd_thres;

end
%%


figure
title('Sensitivity at wall for 4 different angles')
plot(elec_gap,Jthres)
ylabel('J at wall')
xlabel('Separation mm')

saveas(gcf,'figs/J_wall.png')

figure
title('Current spread')
plot(elec_gap,CDwidth)
ylabel('cd angle deg')
xlabel('Separation mm')

saveas(gcf,'figs/cd_spread.png')


%%

% correct for the fact that the deg isnt correctly calculated for the last
% separations

CDwidth_plot=CDwidth(:,1);
CDwidth_plot(1:3)=360;



figure
f=tiledlayout('flow');
f.TileSpacing='compact';

nexttile
plot(elec_gap,CDwidth_plot);
ylabel('CD_{\theta} ^{o}')
grid minor
nexttile

plot(elec_gap,Jthres)
ylabel('J_{wall}')
xlabel('Separation D (mm)')
legend('V1','V2','V3','V4','NumColumns',4,'Location','South','FontSize',6)
grid minor

%legend
set(gcf,'Units','centimeters')
set(gcf,'Position',[ 1 1 10 8])
saveas(gcf,'figs/sim_fig.fig')



%%

meshio.write(['distanceoutput/FineMesh.vtu'],mdls(4).nodes, mdls(4).elems, {ones(size(mdls(4).elems,1),1)},{'elem_data'});
%%

cidx=7;

meshio.write(['distanceoutput/CDspread.vtu'],mdls(cidx).nodes, mdls(cidx).elems, {elemcurrent{cidx}(:,1)},{'Current Density'});

cidx=5;

J=data(cidx).J(1,:)./(get_elem_volume(mdls(cidx))');
J=abs(J);

meshio.write(['distanceoutput/J.vtu'],mdls(cidx).nodes, mdls(cidx).elems, {J},{'J'});

%%

mdl_fig=mdls(5);
mdl_fig.nodes=mdls(5).nodes(:,[1 3 2]);

h=show_fem(mdl_fig);
xlabel('x (mm)')
ylabel('y (mm)')
zlabel('z (mm)')
set(gcf,'Units','centimeters')
set(gcf,'Position',[ 1 1 20 16])
saveas(gcf,'figs/mesh.fig')

%% function to get current magnitude
function elemcur = getcurrent(fmdl,data,opt)

Ninj=size(data.meas,1);

img = mk_image(fmdl,opt.S);

elemcur=nan(size(fmdl.elems,1),Ninj);

for iInj=1:Ninj

    elemcur(:,iInj) = vecnorm(calc_elem_current( img, data.volt(:,iInj)),2,2);

end

end

%% calculte spread
function out = getspread(fmdl,data,currentin,ring_z,width_thres,opt)

ring_z_m=sort(ring_z/1000);

Ninj=size(data.meas,1);

img = mk_image(fmdl,opt.S);

% find slice in centre
slice_height=0.5*(ring_z_m(2)-ring_z_m(1))  + ring_z_m(1);

gap=(ring_z_m(2)-ring_z_m(1));

tol=5e-4;

elem_cnts=(fmdl.nodes(fmdl.elems(:,1),:)+ ...
    fmdl.nodes(fmdl.elems(:,2),:)+ ...
    fmdl.nodes(fmdl.elems(:,3),:))./3;

slice_elems= (elem_cnts(:,3) > (slice_height - tol)) & (elem_cnts(:,3) < (slice_height + tol)) ...
    &  (vecnorm(elem_cnts(:,[1 2]),2,2) > opt.inner_radius*2/1000);

%thicker slice to consider CD elemts
target_elems =(elem_cnts(:,3) > (slice_height - tol*2)) & (elem_cnts(:,3) < (slice_height + tol*2));

% smdl=fmdl;
% smdl.elems=smdl.elems(slice_elems,:);
% smdl.boundary = find_boundary(smdl.elems);

srf_nodes=fmdl.elems(find(slice_elems),:);
srf_nodes=srf_nodes(:);

% elements on the surface ring
slice_edges_nodes=intersect(fmdl.boundary(:),srf_nodes);
slice_edges=any(ismember(fmdl.elems,slice_edges_nodes),2);

cd_angles=nan(Ninj,2);
cd_width=nan(Ninj,1);

J_angles=nan(Ninj,2);
J_width=nan(Ninj,1);

J_thres_all=nan(Ninj,1);
cd_thres_all=nan(Ninj,1);





for iInj=1:Ninj

    % convert voltage field into current field and take magnitude
    %     elemcur = calc_elem_current( img, data.volt(:,iInj) );
    %     elemcur_mag=vecnorm(elemcur,2,2);
    elemcur_mag=currentin(:,iInj);

    %     meshio.write(['distanceoutput/currentmag_' num2str(iInj) '.vtu'],fmdl.nodes,fmdl.elems,{elemcur_mag},{'currentmagnitude'});

    % scale for element size
    J=data.J(iInj,:)./(get_elem_volume(fmdl)');
    J=abs(J);

    %     meshio.write(['distanceoutput/J_' num2str(iInj) '.vtu'],fmdl.nodes,fmdl.elems,{J},{'J'});

    % max  in slice - used for calcs of spread
    [maxcd,maxcd_idx]=max(elemcur_mag(target_elems));
    [maxJ,maxJ_idx]=max(J(slice_edges));

    %     cd_thresh = elemcur_mag > 0.99*maxcd;
    %     J_thresh = J > 0.99*maxJ;

    cd_thresh_val=0.5*maxcd;
    elemcur_mag(~target_elems)=0;
    cd_thresh = (elemcur_mag > cd_thresh_val);% & (elem_cnts(:,3) > (0.5*gap+ring_z_m(1))) & (elem_cnts(:,3) < (0.5*gap-ring_z_m(2))));


    % find elements in centre which are above threshold value on the wall
    J_thres_val= 0.99*maxJ;
    %     J(~target_elems)=0;
    J_thresh = J > J_thres_val;

    %     show_fem(mk_image(fmdl,cd_thresh));
    %     show_fem(mk_image(fmdl,J_thresh));

    cd_thres_xy=elem_cnts(cd_thresh,[1 2]);

    [cd_thresh_th, cd_thresh_r]=cart2pol(cd_thres_xy(:,1),cd_thres_xy(:,2));
    %     cd_angle_low=rad2deg(-std(cd_thresh_th)+mean(cd_thresh_th));
    %     cd_angle_high=rad2deg(std(cd_thresh_th)+mean(cd_thresh_th));

    cd_angle_low=rad2deg(quantile(cd_thresh_th,width_thres(1)));
    cd_angle_high=rad2deg(quantile(cd_thresh_th,width_thres(2)));

    J_thres_xy=elem_cnts(J_thresh,[1 2]);

    %      J_thres_xy(vecnorm(J_thres_xy,2,2) < opt.inner_radius*2/1000,:)=[];



    [J_thresh_th, J_thresh_r]=cart2pol(J_thres_xy(:,1),J_thres_xy(:,2));



    %     J_angle_low=-rad2deg(std(J_thresh_th));
    %     J_angle_high=rad2deg(std(J_thresh_th));

    J_angle_low=rad2deg(quantile(J_thresh_th,width_thres(1)));
    J_angle_high=rad2deg(quantile(J_thresh_th,width_thres(2)));


    % try binning method doesnt work as well as J at wall and cd spread
    deg_edges=-180:10:180;

    J_thresh_deg=rad2deg(J_thresh_th);
    J_thresh_deg_bins=discretize(J_thresh_deg,deg_edges);

    J_thresh_r_ave=zeros(size(deg_edges));

    for iBin=1:length(deg_edges)
        J_thresh_r_ave(iBin)=mean(J_thresh_r(J_thresh_deg_bins==iBin));
    end

    half_max=(max(J_thresh_r_ave) -min(J_thresh_r_ave)) *0.25 + min(J_thresh_r_ave);

    J_angle_low_bin=deg_edges(find(J_thresh_r_ave > half_max,1,'first'));
    J_angle_high_bin=deg_edges(find(J_thresh_r_ave > half_max,1,'last'));




    %     figure
    %     polarplot((cd_thresh_th),cd_thresh_r,'.')
    %     hold on
    %
    %     polarplot(deg2rad([0 cd_angle_low]),[0 max(cd_thresh_r)],'-r')
    %     polarplot(deg2rad([0 cd_angle_high]),[0 max(cd_thresh_r)],'-r')
    %     hold off
    %     title('CD');
    % %     polarplot(deg2rad([0 rad2deg(std(cd_thresh_th))]),[0 max(cd_thresh_r)],'-r')
    % %         polarplot(deg2rad([0 -rad2deg(std(cd_thresh_th))]),[0 max(cd_thresh_r)],'-r')
    %
    %
    %     cd_angles(iInj,:)=[cd_angle_low,cd_angle_high];
    %     cd_width(iInj)=cd_angle_high-cd_angle_low;
    %
    %
    %     figure
    %     polarplot((J_thresh_th),J_thresh_r,'.')
    %     hold on
    %             polarplot(deg2rad(deg_edges),J_thresh_r_ave,'-r')
    %
    %     polarplot(deg2rad([0 J_angle_low]),[0 max(J_thresh_r)],'-r')
    %     polarplot(deg2rad([0 J_angle_high]),[0 max(J_thresh_r)],'-r')
    %
    %     polarplot(deg2rad([0 -J_angle_low_bin]),[0 max(J_thresh_r)],'--k')
    %     polarplot(deg2rad([0 -J_angle_high_bin]),[0 max(J_thresh_r)],'--k')
    %
    %
    %     hold off
    %     title('J')



    J_angles(iInj,:)=[J_angle_low,J_angle_high];
    J_width(iInj)=J_angle_high-J_angle_low;

    J_thres_all(iInj)=max(J(slice_edges));
    cd_thres_all(iInj)=max(elemcur_mag(slice_edges));
end

out.cd_angles=cd_angles;
out.cd_width=cd_width;

out.J_angles=J_angles;
out.J_width=J_width;

out.cd_thres=cd_thres_all;
out.J_thres=J_thres_all;
end


%%

function [data] = runfwd(fmdl,protocol,opt)


%%
fmdl.solve=          @fwd_solve_1st_order;
fmdl.jacobian=       @jacobian_adjoint;
fmdl.system_mat=     @system_mat_1st_order;
fmdl.normalize_measurements = 0;

Amp=opt.Amp;
N_elec = size(fmdl.electrode,2);

%% PROTOCOLS 40mm

% PROTOCOL 1
stim = stim_meas_list(protocol,N_elec, Amp);
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