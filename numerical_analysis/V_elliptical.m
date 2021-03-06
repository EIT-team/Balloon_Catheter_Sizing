%run('\eidors-v3.10-ng\eidors\startup.m')
eidors_cache( 'clear_all' );

%% fixed options

opt.max_edge_length = 0.5;
opt.elec_edge_size =0.05;

opt.height=40;
opt.inner_radius=2.6501; %14fr

opt.axis_a = 14/2;
opt.axis_b = 7/2;

%number of electrodes in a ring
opt.n_elec_ring = 8;

%how much of the ring do the electrodes take up i.e pi means 8 elecs in
%quatre of ring
opt.value_change_pos = pi;

opt.Amp=141e-6;
opt.S=1.6;

%width, height
elec_geom=[0.1 0.3];

% ring heights
ring_z =[5 15 25 35];

Protocol1 = [1 9, 2 10];
Protocol2 = [2 10, 3 11];
Protocol3 = [3 11, 4 12];
Protocol4 = [4 12, 5 13];

ProtocolLine=[Protocol1;Protocol2;Protocol3;Protocol4];

%repeat protocol across each ring to reduce jitter
Protocol=[ProtocolLine; ProtocolLine+8;ProtocolLine+16];

% flags to decide whether to load existing data or recaculate
DoFwd=0;
DoMesh=0;


major_axis=12:1:30; %diameters
ratios=0.5:0.05:1;


minor_axis_all=[];
major_axis_all=[];

for iRatio=1:length(ratios)
    minor_axis_all=[minor_axis_all major_axis*ratios(iRatio)];
    major_axis_all=[major_axis_all major_axis];
end

%%

if DoMesh

    for iMesh=1:length(major_axis_all) %204 seems infinite loop?

        try

            disp('####################################################');
            disp(['                Mesh ' num2str(iMesh) '            ']);
            disp('####################################################');



            opt.axis_a = major_axis_all(iMesh)/2+0.001; %radius
            opt.axis_b = minor_axis_all(iMesh)/2;


            fmdl=makemesh(ring_z,elec_geom,opt);

            show_fem(fmdl,[0,1.025])
            drawnow

            mdls(iMesh)=fmdl;

        catch
            disp('mesh didnt work');

        end


    end

    save(['ellipticaloutput/mesh'],'mdls','major_axis_all','minor_axis_all','-v7.3');

else

    load(['ellipticaloutput/mesh']);

end


%%

if DoFwd

    for iMesh=1:length(major_axis_all)

        data(iMesh)=runfwd(mdls(iMesh),Protocol,opt);

    end

    save(['ellipticaloutput/data'],'data');

else

    load(['ellipticaloutput/data']);

    % mesh element size
    figure
    h=show_fem(mdls(1),[0,1.025]);
    h.EdgeColor='none';
end

%%

Vall=zeros(size(data,2),size(data(1).meas,1));
Vm=zeros(size(data,2),size(ProtocolLine,1));

equiv_idx=[1 size(ProtocolLine,1)+1 2*size(ProtocolLine,1)+1];
% equiv_idx=[size(ProtocolLine,1)+1 ];

for iMesh=1:length(major_axis_all)
    Vall(iMesh,:)=data(iMesh).meas;
    Vm(iMesh,1)=mean(Vall(iMesh,equiv_idx));
    Vm(iMesh,2)=mean(Vall(iMesh,equiv_idx+1));
    Vm(iMesh,3)=mean(Vall(iMesh,equiv_idx+2));
    Vm(iMesh,4)=mean(Vall(iMesh,equiv_idx+3));
    % Vm(iMesh,5)=mean(Vall(iMesh,equiv_idx+4));

end


% plot(Vm*1000)

%% size change for circle models only

Vcirc=reshape(Vm(:,1),[length(major_axis),length(ratios)]);

% only want the first channel
Vcirc=Vcirc(:,1);

Vcirc_diff=diff(Vcirc);

snr_limit_db=60;
snr_limit=10^(snr_limit_db/20); % coeff
% consider detectable meaning SNR > 5?

detect_ratio=10;

Vcirc_limit=Vcirc/snr_limit*1000;


figure
yyaxis left
plot(major_axis,Vcirc*1000)

xlabel('Major Diameter (mm)')
ylabel('Voltage (mV)')

yyaxis right
hold on
plot(major_axis(2:end),abs(Vcirc_diff*1000))
ylabel('Voltage Difference (mV)')
h1=plot(major_axis,detect_ratio*Vcirc_limit,'--');
hold off
legend(h1(end),'dV limit')
%legend
grid minor

set(gcf,'Units','centimeters')
set(gcf,'Position',[ 1 1 10 4])
saveas(gcf,'figs/ellip_circV.fig')



%% difference between min and max

Vdiff=Vm(:,end)-Vm(:,1);

Vdiff=reshape(Vdiff,[length(major_axis),length(ratios)]);

c=colormap('summer');
cidx=int32(linspace(1,256,length(ratios)));
c=c(cidx,:)';

figure
hold on
for iRatio=1:length(ratios)
    plot(major_axis,Vdiff(:,iRatio)*1000,'color',c(:,iRatio))
end
% set(gca, 'YScale', 'log')
xlabel('Major Diameter (mm)')
ylabel('Voltage DIfference (mV)')
legend(string(num2cell(ratios)))

%% minimum detectable ratio

snr_limit_db=60;

snr_limit=10^(snr_limit_db/20); % coeff

Vlimit=Vm(:,4)/snr_limit; % take biggest channel
Vlimit=reshape(Vlimit,[length(major_axis),length(ratios)]);

detect_ratio=10;

Vdiff_thresh=Vdiff > (Vlimit *detect_ratio) ;

% V

for iDiam = 1:size(Vdiff_thresh,1)
    Max_ratio(iDiam) = max(Vdiff_thresh(iDiam,:).*ratios);
end

%
p=polyfit(major_axis,Max_ratio,2);
max_ratio_fit=polyval(p,major_axis);




figure
hold on
plot(major_axis,Max_ratio,'x');
plot(major_axis,max_ratio_fit)
hold off
grid minor
ylim([0.5 1])
xlabel('Major Diameter (mm)')
% ylabel('Minimum detectable ellipticity')
ylabel('f_{min}')


set(gcf,'Units','centimeters')
set(gcf,'Position',[ 1 1 10 4])
set(gca,'YTick',0.5:0.1:1)
saveas(gcf,'figs/ellip_min.fig')
%%

c=colormap('summer');
cidx=int32(linspace(1,256,length(ratios)));
c=c(cidx,:)';

idx_end=8;

figure
% title('Ellipcitiy ratio vs noise')
hold on

for iRatio=1:idx_end
    plot(major_axis,Vdiff(:,iRatio)*1000,'color',c(:,iRatio))
end

h=plot(major_axis,10*Vlimit(:,1)*1000,'--');
hold off
legend(h(end),'dV limit')
set(gca, 'YScale', 'log')
xlabel('Major Diameter (mm)')
ylabel('Voltage DIfference (mV)')
% legend(legstr)
grid on

set(gcf,'Units','centimeters')
set(gcf,'Position',[ 1 1 10 4])
saveas(gcf,'figs/ellip_noiseV.fig')
%%

save(['ellipticaloutput/data_processed'],'major_axis','Vcirc','Vcirc_diff','Vcirc_limit','Vlimit','Vm','snr_limit','snr_limit_db','Vminor','Vmajor');

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
%  data.J= calc_jacobian(img);

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