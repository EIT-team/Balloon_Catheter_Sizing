% Make square mesh $Id: square_mesh01.m 2663 2011-07-12 18:40:31Z aadler $

% Create square mesh model
imdl= mk_common_model('c2s',16);
s_mdl= rmfield(imdl.fwd_model,{'electrode','stimulation'});

% assign one parameter to each square
e= size(s_mdl.elems,1);
params= ceil(( 1:e )/2);
s_mdl.coarse2fine = sparse(1:e,params,1,e,max(params));

show_fem(s_mdl)

% Show parameter numbers
   numeros= reshape(sprintf('%3d',params),3,e)';
   xc=mean(reshape(s_mdl.nodes(s_mdl.elems,1),e,3),2);
   yc=mean(reshape(s_mdl.nodes(s_mdl.elems,2),e,3),2);
   text(xc,yc,numeros,'FontSize',7, ...
            'HorizontalAlignment','center');

% print_convert square_mesh01a.png '-density 75'

% Mesh Correspondance $Id: square_mesh02.m 1535 2008-07-26 15:36:27Z aadler $

% Create grid based on mesh points
nn= 16; nl= 1:nn+1;
h0pts= s_mdl.nodes([nl,(nl-1)*(nn+1)+1],:);
h1pts= s_mdl.nodes([nl + nn*(nn+1),nl*(nn+1)],:);

z_depth= .1*ones(2*(nn+1),1);
% Add the third dimension
v00pts= [h0pts, -z_depth]; v01pts= [h0pts, +z_depth];
v10pts= [h1pts, -z_depth]; v11pts= [h1pts, +z_depth];

xpts= [v00pts(:,1),v01pts(:,1),v11pts(:,1),v10pts(:,1),v00pts(:,1)]';
ypts= [v00pts(:,2),v01pts(:,2),v11pts(:,2),v10pts(:,2),v00pts(:,2)]';
zpts= [v00pts(:,3),v01pts(:,3),v11pts(:,3),v10pts(:,3),v00pts(:,3)]';
subplot(121)
plot3(xpts,ypts,zpts,'b');

axis([-1.1,+1.1,-1.1,+1.1,-0.4,+0.4]);
view(-47,28); axis square

% Dual models $Id: square_mesh03.m 2663 2011-07-12 18:40:31Z aadler $

f_mdl = mk_library_model('cylinder_16x1el_coarse');

subplot(122)
show_fem(f_mdl);  % fine model
crop_model(gca, inline('x-z<-8','x','y','z'))

% Map coarse model geometry
zofs=1/3;
hold on
plot3(xpts*15,ypts*15,(zpts+zofs)*15,'b');
hold off

axis(15*[-1.1,+1.1,-1.1,+1.1,zofs-0.4,zofs+0.4]);
view(-47,28); axis square

% print_convert square_mesh03a.png '-density 100'

% Simulate Moving Ball $Id: square_mesh04.m 2663 2011-07-12 18:40:31Z aadler $

n_sims= 20;
f_mdl = mk_library_model('cylinder_16x1el_vfine');
f_mdl.stimulation = mk_stim_patterns(16,1,'{ad}','{ad}',{},1);
[vh,vi,xyzr_pt]= simulate_3d_movement( n_sims, f_mdl);

clf;
show_fem(f_mdl)
crop_model(gca, inline('x-z<-8','x','y','z'))

hold on
[xs,ys,zs]=sphere(10);
for i=1:n_sims
   xp=xyzr_pt(1,i); yp=xyzr_pt(2,i);
   zp=xyzr_pt(3,i); rp=xyzr_pt(4,i);
   hh=surf(rp*xs+xp, rp*ys+yp, rp*zs+zp);
   set(hh,'EdgeColor',[.4,0,.4],'FaceColor',[.2,0,.2]);
end
zofs=1/3;
plot3(xpts*15,ypts*15,(zpts+zofs)*15,'b');
hold off

axis equal
view(-23,44)
print_convert square_mesh04a.png '-density 75'
view(-12,4)
% print_convert square_mesh04b.png '-density 75'

% 2D solver $Id: square_mesh05.m 4839 2015-03-30 07:44:50Z aadler $

% Create a new inverse model, and set
% reconstruction model and fwd_model
imdl= mk_common_model('c2c2',16); im_fm= imdl.fwd_model;
imdl.rec_model= s_mdl;
imdl.fwd_model= f_mdl;
imdl.fwd_model.stimulation= im_fm.stimulation;
imdl.fwd_model.meas_select= im_fm.meas_select;

s_mdl.mk_coarse_fine_mapping.f2c_offset = [0,0,5];
s_mdl.mk_coarse_fine_mapping.f2c_project = (1/15)*speye(3);
s_mdl.mk_coarse_fine_mapping.z_depth = 0.1;
c2f= mk_coarse_fine_mapping( f_mdl, s_mdl);
imdl.fwd_model.coarse2fine = c2f;
imdl.RtR_prior = @prior_gaussian_HPF;
imdl.solve = @inv_solve_diff_GN_one_step;
imdl.hyperparameter.value= 0.03;

imgs= inv_solve(imdl, vh, vi);
% 2D solver $Id: square_mesh06.m 4839 2015-03-30 07:44:50Z aadler $

% Create a classic 2D inverse model
imdl= mk_common_model('c2c2',16);
imdl.RtR_prior = @prior_gaussian_HPF;
imdl.solve = @inv_solve_diff_GN_one_step;
imdl.hyperparameter.value= 0.1;

imgc= inv_solve(imdl, vh, vi);

% Show on the mesh
subplot(121); show_fem(imgs); axis equal; axis tight;
subplot(122); show_fem(imgc); axis equal; axis tight;
% print_convert square_mesh06a.png

% Show on a grid 
subplot(121); show_slices(imgs)
subplot(122); show_slices(imgc)
% print_convert square_mesh06b.png

