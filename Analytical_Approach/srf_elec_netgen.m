axislist=[7/2, 8/2, 9/2, 10/2, 11/2, 12/2, 13/2, 14/2, 15/2, 16/2, 17/2, 18/2, 19/2, 20/2, 21/2, 22/2, 23/2, 26/2, 29/2, 32/2, 34/2];
%axislist=[12/2];
inner_radius=1.5;
k=0

for axis_a = axislist;
   
    height=15;
    % axis_b = axis_a; % circular
    axis_b = axis_a/2; % elliptical

    %number of electrodes in a ring
    n_elec_ring = 4; % 16elec 2pi => 8elec pi, 
                     % 8elec 2pi => 4elec pi, 
                     % 4elec 2pi => 2elec pi
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
    theta = linspace(0, pi, n_elec_ring+1); theta(end) = [];
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
        electrode_geometry{iElec}.keep_material_flag =1; 
        

    end
    
    

    fmdl = ng_mk_geometric_models(body_geometry,electrode_geometry);
    
    fmdl.nodes = fmdl.nodes./1000;
    
    for i=1:n_elec_ring*2
        fmdl.electrode(i).z_contact= 0.01;
    end


    % mesh element size
    figure
    show_fem(fmdl)


    %meshio.write('elliptical11mm_9fr.vtu',fmdl.nodes,fmdl.elems);

    %
    fmdl.solve=          @fwd_solve_1st_order;
    fmdl.jacobian=       @jacobian_adjoint;
    fmdl.system_mat=     @system_mat_1st_order;
    fmdl.normalize_measurements = 0;

    Amp=141e-6;
    N_elec = iElec;

    Protocol = readmatrix('15mm_height_netgen/srf4elecpi.xlsx', 'Range', 'A1:D2') % change accordingly
    stim = stim_meas_list(Protocol,N_elec, Amp);
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
    k = k+1;
    
    
    v_baseline = fwd_solve(img);
    V_matrix(:, k) = v_baseline.meas;
    
    % add noise 
    % sig= sqrt(norm(v_baseline.meas));
    % m= size(v_baseline.meas,1);
    % v_baseline.meas = v_baseline.meas + .01*sig*randn(m,1); %20dB noise
    % v_matrix_noise(:,k) = v_baseline.meas;
end

%%
   
figure
show_fem(fmdl)


