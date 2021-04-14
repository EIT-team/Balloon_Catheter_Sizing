%% Analytical Approach

% We aim at evaluating voltages obtained when inject current from
% electrodes placed longitudinally on aorta of different sizes

% Parameters:
% V voltage, I current, resistivity, N number of electrodes
%
% Aorta: r_aorta radius of circular aorta, D_aorta diameter of circular aorta
% A_aorta area of aorta, D1_aorta D2_aorta for elliptical aorta, L_aorta aorta length 
%
% Catheter: r_catheter and A_catheter catheter area and radius


% Use of Ohm's law

resistivity = 1/1.6; % resistivity of aorta - considering saline 0.9%
L_balloon = 0.04; % aorta Lenght 40mm
r_catheter = 1.5 * 10^-3; %3mm diameter catheter Edwards 9Fr 
I = 141 * 10^-6; % current 141 microA 
V = [];
i = 1;
D_balloon = [17, 23, 26, 29, 31]; % current standard aorta stent diameters

% 4 models circular cross-section aorta (1 pair of electrodes)
for r_balloon = D_balloon .* 10^(-3)/2
    R = (resistivity * L_balloon)/ (pi * (r_balloon.^2 - r_catheter.^2));
    V(i) = I * R * 4 ; % Ohm's Law  
    i = i + 1;
end

V_circular= V

% 4 models elliptical cross-section aorta (1 pair of electrodes)
% D_aorta_2 = [26, 29, 32, 34];
% n = 1;
% for r_aorta2 = D_aorta_2 .* 10^(-3)/2
%     R_2 = (resistivity * L_aorta)/ (pi * (r_aorta2.^2 - r_catheter.^2));
%     V_2(n) = I * R_2; % Ohm's Law  
%     n = n + 1;
% end
% 
% disp('V_circular2=')
% disp(V_2)

% 4 models elliptical cross-section aorta (1 pair of electrodes)

D_1 = [26, 29, 32, 34];
D_2 = [20.3, 23.31, 26.3, 28.23];

m = 1;
for r_balloon3 = D_1 .* 10^(-3)/2  
        R_3 = (resistivity * L_balloon)/ (pi * (r_balloon3.^2 - r_catheter.^2));
        V_circle1(m) = I * R_3 * 4; % Ohm's Law  
        V_circle1(m) = V_circle1(m);
        m = m + 1;
end

V_sector_1 = V_circle1

m = 1;
for r_aorta3 = D_2 .* 10^(-3)/2  
        R_3 = (resistivity * L_balloon)/ (pi * (r_aorta3.^2 - r_catheter.^2));
        V_circle2(m) = I * R_3 * 4; % Ohm's Law  
        V_circle2(m) = V_circle2(m);
        m = m + 1;
end

V_sector_2 = V_circle2

