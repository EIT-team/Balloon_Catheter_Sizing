%% Select folder with wanted models 
folder = '15mm_height/9fr/';
fil = fullfile(folder, 'elliptical*.vtu');
d=dir(fil);
name2 = 'point9FR_reconstr_img-k=%3.1f-a2=%3.1f.jpg'; 
name_fig = 'point9FR_reconstr_img-k=%3.1f-a2=%3.1f.fig'; 
counter = 0;
%% Loop through models and hyperparameters to obtain slices matrix

for k = 1:numel(d)
    filename = fullfile(folder, d(k).name)
    M=meshio.read(filename); % THE MESH IS IN MM
    save('model1', 'M')
    % model_name = ' Elliptical Model D_{major axis} = 6mm 9FR'
    model_name = ' Elliptical Model D = 6mm 9FR '

    % create eidors structure
    MDL=eidors_obj('fwd_model','BalloonCatheter');
    MDL.nodes = M.vtx./1000; % the 3d coordinates of the nodes IN METERS
    MDL.elems = M.cells(4).tri; % which nodes create a tetrahedron 
    [srf, idx] = find_boundary(M.cells(4).tri);
    MDL.boundary = srf;
    gnd_pos=[0,-0.01,0];
    gnd_dist=sqrt(sum((MDL.nodes - gnd_pos).^2,2));
    [~, gnd_node] = min(gnd_dist);
    MDL.gnd_node = gnd_node;

    % Define electrodes z direction
    elecRingZ=[0.0025, 0.0125];
    phi_offset = 0; 
    radius_centre = 0.0015;
    nElecRing = 8; % number of electrodes in each ring

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

    % figure;
    % show_fem(MDL);
    % hold on;
    % plot3(elec_pos(:,1),elec_pos(:,2),elec_pos(:,3), '.','Markersize',50); 
    % hold off

    % create electrode structure
    z_contact=1e-3;
    elec_radius = .008;
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
        position_electrodes = M.vtx(MDL.electrode(i).nodes, :);
    end

    figure
    show_fem(MDL)
    title(strcat('Mesh', model_name, ' with two rings, each of 8 electrodes'));
    xlabel('x (m)')
    ylabel('y (m)')
    zlabel('z (m)')
    set(gca,'FontSize',16)

    % Forward model
    MDL.solve=          @fwd_solve_1st_order;
    MDL.jacobian=       @jacobian_adjoint;
    MDL.system_mat=     @system_mat_1st_order;
    MDL.normalize_measurements = 0;

    Amp=141e-6; % Current amplitude in Amps this is the most you can inject below 1 kHz, but we are not really limited to that
    N_elec=size(elec_pos,1);

    UniquePairs = nchoosek(1:N_elec,2);
    nPairs=size(UniquePairs,1);

    Protocol=[];
    for iInj=1:nPairs

        Protocol=[Protocol; repmat(UniquePairs(iInj,:),[nPairs,1]) UniquePairs];

    end

    % Protocol = [3 25, 4 26]
    % Protocol = readmatrix('sp_mp.xlsx', 'Range', 'A1:D462') % A1:D462 
    Protocol = readmatrix('sp_mp1920.xlsx', 'Range', 'A1:D1920'); % A1:D462 
    stim = stim_meas_list(Protocol, N_elec, Amp);
    MDL.stimulation=stim;

    MDL = remove_unused_nodes(MDL);
    % MDL=remove_unused_nodes(MDL);
    if valid_fwd_model(MDL)
        disp('Forward model is ok! Yay!');
    end

    % Conductivity and voltage measurements
    S=1.6;
    Inj_number = 1;

    % img = mk_image(MDL,S);
    img = mk_image(MDL,S);

    img.fwd_solve.get_all_meas = 1;
    v_baseline = fwd_solve(img)


    img_v = rmfield(img, 'elem_data');
    img_v.node_data = v_baseline.volt;
    figure
    img_v.calc_colours.cb_shrink_move = [.3,.8,-0.02];
    show_slices(img_v)
    title('Protocols')

    % Fine model as forward model

    fine_model=meshio.read('15mm_height/9fr/circular20mm.vtu'); 
    save('model_infinite', 'fine_model');
    fine_mdl=eidors_obj('fwd_model','balloonx3b');
    fine_mdl.nodes = fine_model.vtx./1000; % the 3d coordinates of the nodes IN METERS
    fine_mdl.elems = fine_model.cells(4).tri; % which nodescreate a tetrahedron 
    [srf3, idx3] = find_boundary(fine_model.cells(4).tri);
    fine_mdl.boundary = srf3;
    gnd_pos=[0,-0.01,0];
    gnd_dist=sqrt(sum((fine_mdl.nodes - gnd_pos).^2,2));
    [~, gnd_node] = min(gnd_dist);
    fine_mdl.gnd_node = gnd_node;

    for iElec = 1:size(elec_pos,1)

        %assign conductivity to structure
        electrodes3(iElec).z_contact= z_contact;

        % find surface nodes within electrode radius
        edist3 = sqrt(sum((fine_mdl.nodes - elec_pos(iElec,:)).^2,2));
        [~,enode3] = min(edist3);

        electrodes3(iElec).nodes = enode3;
    end

    fine_mdl.electrode =     electrodes3;

    % forward model
    fine_mdl.solve=          @fwd_solve_1st_order;
    fine_mdl.jacobian=       @jacobian_adjoint;
    fine_mdl.system_mat=     @system_mat_1st_order;
    fine_mdl.normalize_measurements = 0;

    % Convert protocol file to EIDORS stim patterns

    Amp=141e-6; % Current amplitude in Amps this is the most you can inject below 1 kHz, but we are not really limited to that

    N_elec=size(elec_pos,1);

    UniquePairs = nchoosek(1:N_elec,2);
    nPairs=size(UniquePairs,1);

    Protocol=[];
    for iInj=1:nPairs

    Protocol=[Protocol; repmat(UniquePairs(iInj,:),[nPairs,1]) UniquePairs];

    end

    % Protocol = readmatrix('sp_mp.xlsx', 'Range', 'A1:D462') % A1:D462 
    Protocol = readmatrix('sp_mp1920.xlsx', 'Range', 'A1:D1920');
    stim = stim_meas_list(Protocol, N_elec, Amp);
    fine_mdl.stimulation=stim;

    fine_mdl=remove_unused_nodes(fine_mdl);

    figure
    show_fem(fine_mdl, 3)
    title('Fine model circular 20mm diameter', 'Fontsize', 20)
 

    %Create coarse model with less elements
    coarse_model =meshio.read('15mm_height/9fr/coarsemodel20mmcir.vtu'); 
    save('model_infinite', 'coarse_model'); 
    coarse_mdl=eidors_obj('fwd_model','Balloon');
    coarse_mdl.nodes = coarse_model.vtx./1000; % the 3d coordinates of the nodes IN METERS
    coarse_mdl.elems = coarse_model.cells(4).tri; % which nodes create a tetrahedron 
    [srf, idx] = find_boundary(coarse_model.cells(4).tri);
    coarse_mdl.boundary = srf;
    gnd_pos=[0,-0.01,0];
    gnd_dist=sqrt(sum((coarse_mdl.nodes - gnd_pos).^2,2));
    [~, gnd_node] = min(gnd_dist);
    coarse_mdl.gnd_node = gnd_node;
    figure
    show_fem(coarse_mdl)
    title('Coarse model circular 20mm diameter', 'Fontsize', 20)

    % Reconstruction absolute
    % special parameter for this model absolute

    % less elements for MDL_2
    inv_mdl.name = 'Eit reconstruction';
    inv_mdl= eidors_obj('inv_model', inv_mdl);
    inv_mdl.solve = @inv_solve_gn; %Default Gauss Newton solvers 
    inv_mdl.reconst_type = 'absolute'; 
    inv_mdl.fwd_model = fine_mdl; % MDL_3 mesh with no electrodes and less dense 
    inv_mdl.inv_solve_gn.max_iterations = 10 ; %Number of iterations
    inv_mdl.RtR_prior=@prior_noser;  
    inv_mdl.parameters.term_tolerance= 1e-5;

    %inv_mdl.hyperparameter.value = 0.1; % check 0.1 to 0.01 ...
    % MDL_2.inv_solve_gn.elem_working = 'log_conductivity';
    inv_mdl.jacobian_bkgnd.value= 0.05; % check
    inv_mdl.fwd_model.coarse2fine = ...
           mk_coarse_fine_mapping(fine_mdl, coarse_mdl);

    alpha2list=  [1:0.25:1.5];

    for alpha2= alpha2list
        new_name = extractBefore(d(k).name, '.vtu');
        inv_mdl.hyperparameter.value =   10^-alpha2;
        img4  = inv_solve(inv_mdl, v_baseline);
        figs = figure;
        title_base = 'reconstr_img-k=%s-a2=%3.1f';
        my_title = sprintf(title_base,new_name, alpha2);
        subplot(1,2,1)
        title(my_title) 
        out_img= show_slices(img4, [inf,inf,0.0025]);
        title('ring of electrodes at 2.5mm', ...
        'Fontsize', 25);

        subplot(1,2,2)
        out_img2 = show_slices(img4, [inf,inf,0.0125]);
        title('ring of electrodes at 12.5mm', ...
        'Fontsize', 25);
    
        %savefig(figs, sprintf(name_fig, k, alpha2))

        out_img_final = imresize(out_img, [128 128]);
        %imwrite(out_img_final, colormap, sprintf(name2,k,alpha2) );

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


        % GET ELEMENTS AND FIND DIMENSIONS

        % Threshold 
        elem = img4.elem_data;
        elem_thresholded = zeros(size(elem));
        max_elem = max(elem);
        Threshold = 1/2 * max_elem
        threshold_name = ' 1/2 max element'
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
            radius_vals = radius_val(radius_val < 0.008);

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
        counter=counter+1;
        dimensions_sectors_max_matrix(:,counter)=dimensions_sectors_max'
        dimensions_sectors_angle_matrix(:,counter)=angle_max_rad'
    end 
    
    

end

%% Generate HTML frame to view $Id: TV_hyperparams04.m 2639 2011-07-12 07:39:06Z bgrychtol $
fid= fopen('NEW_Hyper9FR-params-point.html','w');

a=sprintf('%calpha;',38); % alpha
m=sprintf('%cminus;',38); % alpha
r='Model Diameter major axis '; % alpha
s=sprintf('%c',60); % less than 
e=sprintf('%c',62); % greater than
tr= [s,'TR',e]; etr= [s,'/TR',e];
th= [s,'TH',e]; eth= [s,'/TH',e];
td= [s,'TD',e]; etd= [s,'/TD',e];
sub=[s,'SUB',e];esub=[s,'/SUB',e];
sup=[s,'SUP',e];esup=[s,'/SUP',e];

fprintf(fid,[s,'TABLE',e,tr,th]);
for alpha2=  [0:0.25:3];
   fprintf(fid,[th,a,sub,'1',esub,'=10',sup,m,'%3.1f',esup],alpha2);
end
fprintf(fid,'\n');

%j = [2, 3, 4, 5];
for  k = 1:numel(d)
   name = extractBefore(d(k).name, '.vtu')
   fprintf(fid,['\n',tr,'\n',th,r, ...
                name, esup,'\n'],k);
   for alpha2= [0:0.25:3];
      fprintf(fid,[td,s,'img src="%s"',e,'\n'], sprintf(name2, k, alpha2));
   end
end

fprintf(fid,['\n',s,'/TABLE',e,'\n']);
fclose(fid);