%% Model netgen
axislist=[10/2];
inner_radius=2.35;
k=0

for axis_a = axislist;
    %outer elliptic cylinder
    height=15;
    axis_b = axis_a/2;

    model_name = strcat(' Elliptical Model 14FR r_{major axis} = ', axis_a) 

    %number of electrodes in a ring
    n_elec_ring = 8;
    % ring heights
    ring_z =[2.5 12.5];

    elec_width =0.1;
    elec_height=0.3;

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
    theta = linspace(0, 2*pi, n_elec_ring+1); theta(end) = [];
    theta=repmat(theta,[1,nRing]);
    theta_degrees = rad2deg(theta);


    elec_z=[];
    for iRing=1:nRing
       elec_z=[elec_z, repmat(ring_z(iRing),[1,n_elec_ring])]; 
    end
    % elec_z=ring_z(1);


    for iElec = 1:n_elec_ring*nRing

        % find electrode centre
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
        d=inner_radius*0.2; % 0.5 for 16FR

        % bottom left
        bl = c - (d/2)* dirn + (w/2)*dirnp - [0,0,h/2];
        % top right (for ref)
        tr = c + (d/2)* dirn - (w/2)*dirnp + [0,0,h/2];

        %ploting for sanity check
    %     plot3(c(1),c(2),c(3),'o')
    %     plot3(bl(1),bl(2),bl(3),'o')
    %     plot3(tr(1),tr(2),tr(3),'x')


        %cannot use orthobrick as it always aligned to x/y/z, so instead we
        %need to use parallelepipd(!). defined by one vertex and three
        %vectors

        electrode_geometry{iElec}.parallelepiped.vertex   = bl;
        electrode_geometry{iElec}.parallelepiped.vector_a = dirn*(d);
        electrode_geometry{iElec}.parallelepiped.vector_b = -dirnp*(w);
        electrode_geometry{iElec}.parallelepiped.vector_c = [0,0,1]*h; %


        electrode_geometry{iElec}.max_edge_length = elec_edge_size;
        electrode_geometry{iElec}.keep_material_flag =0;
        
    end


    MDL = ng_mk_geometric_models(body_geometry,electrode_geometry);
    MDL.nodes = MDL.nodes./1000;


    %% show mesh
    figure
    show_fem(MDL)

    %% Protocol = readmatrix('sp_mp.xlsx', 'Range', 'A1:D462') % A1:D462 

    MDL.solve=          @fwd_solve_1st_order;
    MDL.jacobian=       @jacobian_adjoint;
    MDL.system_mat=     @system_mat_1st_order;
    MDL.normalize_measurements = 0;

    Amp=141e-6;
    N_elec = iElec;
    Protocol = readmatrix('sp_mp1920.xlsx', 'Range', 'A1:D1920'); % A1:D462 
    stim = stim_meas_list(Protocol, N_elec, Amp);
    MDL.stimulation=stim;

    MDL = remove_unused_nodes(MDL);
    % MDL=remove_unused_nodes(MDL);
    if valid_fwd_model(MDL)
        disp('Forward model is ok! Yay!');
    end


    figure
    show_fem(MDL)
    % _{major axis}
    title('Balloon Mesh Elliptical Model D_{major axis} = 6mm with two rings of 8 electrodes');
    xlabel('x(m)')
    ylabel('y(m)')
    zlabel('z(m)')
    set(gca, 'Fontsize', 22)

    % Conductivity and voltage measurements
    S=1.6;
    Inj_number = 1;

    S_deflated = 0.16; % balloon deflate
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


    img_v = rmfield(img, 'elem_data');
    img_v.node_data = v_baseline.volt;
    figure
    img_v.calc_colours.cb_shrink_move = [.3,.8,-0.02];
    show_slices(img_v)
    title('Protocols')

    % Fine model as forward model
    %outer elliptic cylinder
    height=15;
    axis_a = 20/2;
    axis_b = 20/2;

    %number of electrodes in a ring
    n_elec_ring = 8;
    % ring heights
    ring_z =[2.5 12.5];

    elec_width =0.1;
    elec_height=0.3;

    %mesh element size
    body_geometry.max_edge_length = 0.75;
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
    theta = linspace(0, 2*pi, n_elec_ring+1); theta(end) = [];
    theta=repmat(theta,[1,nRing]);
    theta_degrees = rad2deg(theta);


    elec_z=[];
    for iRing=1:nRing
       elec_z=[elec_z, repmat(ring_z(iRing),[1,n_elec_ring])]; 
    end
    % elec_z=ring_z(1);


    for iElec = 1:n_elec_ring*nRing

        % find electrode centre
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
        d=inner_radius*0.2;

        % bottom left
        bl = c - (d/2)* dirn + (w/2)*dirnp - [0,0,h/2];
        % top right (for ref)
        tr = c + (d/2)* dirn - (w/2)*dirnp + [0,0,h/2];

        %ploting for sanity check
    %     plot3(c(1),c(2),c(3),'o')
    %     plot3(bl(1),bl(2),bl(3),'o')
    %     plot3(tr(1),tr(2),tr(3),'x')


        %cannot use orthobrick as it always aligned to x/y/z, so instead we
        %need to use parallelepipd(!). defined by one vertex and three
        %vectors

        electrode_geometry{iElec}.parallelepiped.vertex   = bl;
        electrode_geometry{iElec}.parallelepiped.vector_a = dirn*(d);
        electrode_geometry{iElec}.parallelepiped.vector_b = -dirnp*(w);
        electrode_geometry{iElec}.parallelepiped.vector_c = [0,0,1]*h; %


        electrode_geometry{iElec}.max_edge_length = elec_edge_size;
        electrode_geometry{iElec}.keep_material_flag =0;

    end


    fine_mdl = ng_mk_geometric_models(body_geometry,electrode_geometry);
    fine_mdl.nodes = fine_mdl.nodes./1000;


    fine_mdl.solve=          @fwd_solve_1st_order;
    fine_mdl.jacobian=       @jacobian_adjoint;
    fine_mdl.system_mat=     @system_mat_1st_order;
    fine_mdl.normalize_measurements = 0;

    Amp=141e-6;
    N_elec = iElec;
    Protocol = readmatrix('sp_mp1920.xlsx', 'Range', 'A1:D1920'); % A1:D462 
    stim = stim_meas_list(Protocol, N_elec, Amp);
    fine_mdl.stimulation=stim;

    fine_mdl = remove_unused_nodes(fine_mdl);
    % MDL=remove_unused_nodes(MDL);
    if valid_fwd_model(fine_mdl)
        disp('Fine fwd model is ok! Yay!');
    end

    figure
    show_fem(fine_mdl)
    % Create coarse model with less elements
    %outer elliptic cylinder
    height=15;
    axis_a = 20/2;
    axis_b = 20/2;

    model_name = ' Elliptical Model D_{major axis} = 12mm 9FR' 


    %mesh element size
    body_geometry.max_edge_length = 5;

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

    coarse_mdl = ng_mk_geometric_models(body_geometry);
    coarse_mdl.nodes = coarse_mdl.nodes./1000;

    % body_geometry.max_edge_length = 1;

    figure
    show_fem(coarse_mdl)


    % Reconstruction absolute
    % special parameter for this model absolute

    % less elements for MDL_2
    inv_mdl.name = 'Eit reconstruction';
    inv_mdl= eidors_obj('inv_model', inv_mdl);
    inv_mdl.solve = @inv_solve_gn; %Default Gauss Newton solvers @inv_solve_diff_GN_one_step;
    inv_mdl.reconst_type = 'absolute'; 
    inv_mdl.fwd_model = fine_mdl; % MDL_3 mesh with no electrodes and less dense 
    inv_mdl.inv_solve_gn.max_iterations = 10 ; %Number of iterations
    inv_mdl.RtR_prior=@prior_noser;  
    inv_mdl.parameters.term_tolerance= 1e-5;

    inv_mdl.hyperparameter.value = 10^(-1); % check 0.1 to 0.01 ...
    % MDL_2.inv_solve_gn.elem_working = 'log_conductivity';
    inv_mdl.jacobian_bkgnd.value= 1; % check
    inv_mdl.fwd_model.coarse2fine = ...
           mk_coarse_fine_mapping(fine_mdl, coarse_mdl);

    img4  = inv_solve(inv_mdl, v_baseline);   

    % slices
    figure
    fig2 = show_slices(img4, [inf,inf,0.0125])
    title('EIT absolute reconstruction slice ring of electrodes at 12.5mm', ...
    'Fontsize', 25);
    figure
    fig3 = show_slices(img4, [inf,inf,0.0025])
    title('EIT absolute reconstruction slice second ring of electrodes at 2.5mm', ...
    'Fontsize', 25);


    % reconstruction figure

    figure
    clf; 
    axes('position',[.1,.1,.65,.8]);
    fig1 = show_fem(img4,[1,1]); axis off; axis image % check threshold 
    title(strcat('EIT 3D absolute reconstruction', model_name, ' in fine model 20mm - Hyperparameter = 0'));
    set(gca,'FontSize',18)
    axes('position',[.8,.05,.15,.8]);
    hold on
    show_slices(img4, [inf,inf,0.0125]);
    title('ring of electrodes 12.5mm', 'Fontsize', 16);
    axes('position',[.8,.4,.15,.8]);
    hold on
    show_slices(img4, [inf,inf,0.0025]);
    title('ring of electrodes 2.5mm', 'Fontsize', 16);
    hold off
    % saveas(fig1,'reconstruction_3Dabs.fig');

    % 
    % figure
    % fig2 = show_slices(img4, [inf,inf,0.0125]);
    % title('EIT absolute reconstruction slice ring of electrodes at 12.5mm', ...
    % 'Fontsize', 25);
    % figure
    % fig3 = show_slices(img4, [inf,inf,0.0025]);
    % title('EIT absolute reconstruction slice second ring of electrodes at 2.5mm', ...
    % 'Fontsize', 25);

    % % 
    % % img.elem_data = ones(size(img4.elem_data))
    % meshio.write('eit_3D_abs_reconst.vtu',coarse_mdl.nodes, coarse_mdl.elems, {img4.elem_data},{'elem_data'});


    %% GET ELEMENTS AND FIND DIMENSIONS

    % Threshold 
    elem = img4.elem_data;
    elem_thresholded = zeros(size(elem));
    max_elem = max(elem);
    Threshold = 1/3 * max_elem
    threshold_name = ' 1/3 max element'
    index = find(elem>Threshold); % elem superior


    for i=length(elem)
        elem_thresholded(index) = elem(elem>Threshold);
    end

    img4.elem_data = elem_thresholded;
    figure
    show_fem(img4)
    eidors_colourbar(img4)
    title(strcat('EIT 3D absolute reconstruction', model_name, ' with threshold ', num2str(threshold_name)));
    xlabel('x (m)')
    ylabel('y (m)')
    zlabel('z (m)')
    set(gca,'FontSize',16)

    % Centers of elements (centroids of tetra coordinates)
    elems_tetras_b = coarse_mdl.elems(index, :);
    nodes_coord_b = coarse_mdl.nodes;

    for i=1:length(elems_tetras_b)
            index_nodes_coord_b = elems_tetras_b(i, :);
            nodes_b=nodes_coord_b(index_nodes_coord_b,:);
            cell_coord_b{i}=nodes_b;
            for m=1:4
                centroid_coord_b = mean(nodes_b);
                centroids_b{i} = centroid_coord_b;
            end
    end

    centroids_mat_b = cell2mat(centroids_b);
    centroids_mat_reshape_b = reshape(centroids_mat_b,3, []);
    x = centroids_mat_reshape_b(1, :);
    y = centroids_mat_reshape_b(2, :);
    z = centroids_mat_reshape_b(3, :);

    % figure
    % scatter3(x,y,z)

    % Get sum of elements for each sector
    x_polar = atan(y./x);
    x_polar_new = myatan(y,x); % interval 0 and 2pi instead of -pi/2 and pi/2
    radius = sqrt(x.^2 + y.^2);

    figure
    polarscatter(x_polar_new, radius)
    title(strcat('Polar scatter plot of elements obtained from 3D absolute reconstruction', model_name,...
        ' with threshold ', num2str(threshold_name)), 'fontsize', 16)

    set(gca,'FontSize',16)
    % Divide into sectors and get max elements to find radius
    angle_degrees = x_polar.*(180/pi);
    angle_degrees_new = x_polar_new.*(180/pi);
    angle_degrees_elems = transpose(angle_degrees_new);
    n_sectors = 12;
    angle_of_one_sector = 360/n_sectors;
    angle_sector_2 = zeros(n_sectors, 1);
    angle_sector_1 = zeros(n_sectors, 1);
    angle_sector_2(1) = angle_of_one_sector;
    index_interval = {};

    for i=1:n_sectors-1
        angle_sector_1(i+1) = angle_sector_2(i);
        angle_sector_2(i+1) = angle_sector_2(i) + angle_of_one_sector;
    end

    for i=1:n_sectors
        index_interval{i} = find(angle_sector_1(i) <= angle_degrees_elems & ...
                angle_degrees_elems <= angle_sector_2(i));

        sum_elements_in_sector(i) = sum(angle_sector_1(i) <= angle_degrees_elems & ...
                angle_degrees_elems <= angle_sector_2(i));
    end

    figure
    plot(angle_sector_2, sum_elements_in_sector, 'Linewidth', 2)
    xlabel('Sector angle in degrees', 'Fontsize', 16)
    ylabel(strcat('Number of elements with threshold', num2str(threshold_name)), 'Fontsize', 16)
    title(strcat('Number of elements from 3D absolute reconstruction', model_name, ' against sector angle'), 'Fontsize', 16)
    set(gca,'FontSize',18)
    % All radius values in each sector
    dimensions_sectors = zeros(n_sectors, 1);
    for i_sectors=1:n_sectors
        radius_val = radius(index_interval{i_sectors});
        radius_vals = radius_val(radius_val < 0.009);

        if  isempty(radius_vals) == 0
            max_rad = max(radius_vals);
            dimensions_sectors_max(i_sectors) = max_rad;

            angle = angle_degrees_new(index_interval{i_sectors})';
            index_max_rad = find(radius_val == max_rad)
            if length(index_max_rad) > 1
                angle_max_rad(i_sectors) = angle(index_max_rad(1));
            else
                angle_max_rad(i_sectors) = angle(index_max_rad);
            end

        end

    end
    k=k+1;
    dimensions_sectors_max_matrix(:,k)=dimensions_sectors_max'
    dimensions_sectors_angle_matrix(:,k)=angle_max_rad'
    
end