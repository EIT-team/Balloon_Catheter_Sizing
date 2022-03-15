
% DOWNLOAD FOLDER FROM https://github.com/fangq/iso2mesh 

%% GMSH - Load the vtu mesh into matlab
% M=meshio.read('15mm_height/TEST_MESH/elliptical15mm_8e.vtu'); % THE MESH IS IN MM
% save('model5', 'M')
% create blank fwd object
% MDL=eidors_obj('fwd_model','BalloonCatheter');

% % specify nodes and triangulation
% MDL.nodes = M.vtx./1000; % the 3d coordinates of the nodes IN METERS
% MDL.elems = M.cells(4).tri; % which nodes create a tetrahedron 


% quality = meshquality(MDL.nodes, MDL.elems);
% mean_quality = mean(quality)



%% NETGEN 
axislist=[12/2, 13/2, 14/2, 15/2, 16/2, 17/2, 18/2, 19/2, 20/2, 21/2, 22/2, 23/2, 26/2, 29/2, 32/2, 34/2];
%axislist=[12/2];
inner_radius=2.65;
k=0

for axis_a = axislist;
    % now with square electrodes USE THIS ON
    % keep the mesh in meters and then divide nodes into mm as netgen gets
    % confused with small coordinates and element sizes

    
    %outer elliptic cylinder
    height=15;
    axis_b = axis_a ;

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
    
    k = k+1;
    number_elements(:,k) = length(fmdl.elems)
    quality = meshquality(fmdl.nodes, fmdl.elems);
    mean_quality(:,k) = mean(quality)
end

%%
number_elements'
quality_mean = mean_quality'
