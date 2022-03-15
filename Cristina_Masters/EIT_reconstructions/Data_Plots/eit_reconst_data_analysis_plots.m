
%% catheter 9fr

% Model 6mm
% Real model
figure
sgtitle ('3D absolute reconstruction comparison true to measured radii - catheter 9fr ', 'fontsize', 16)

subplot(2, 3, 1)
b1 = (3.5*10^(-3))/2;
a1 = (6*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius1 = (a1.*b1)./sqrt(a1.^2.*(sin(theta)).^2 + b1.^2*cos(theta).^2);

polarplot(theta, radius1, 'linewidth', 3)
hold on

% catheter
b = (3*10^(-3))/2;
a = (3*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);
polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on

num=readmatrix('reconstruction2.xlsx', 'sheet', '9fr', 'Range', 'A2:L13');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot elliptical model r_{major axis} = 3mm')

% Model 8mm
% Real model
subplot(2, 3, 2)
b2 = (4*10^(-3))/2;
a2 = (8*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius2 = (a2.*b2)./sqrt(a2.^2.*(sin(theta)).^2 + b2.^2*cos(theta).^2);

polarplot(theta, radius2, 'linewidth', 3)
hold on

% catheter
b = (3*10^(-3))/2;
a = (3*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on

% excel
num=readmatrix('reconstruction2.xlsx', 'sheet', '9fr', 'Range', 'A16:L27');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot elliptical model r_{major axis} = 4mm')


% Model 9mm
% real model
subplot(2, 3, 3)
b3 = (4.5*10^(-3))/2;
a3 = (9*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius3 = (a3.*b3)./sqrt(a3.^2.*(sin(theta)).^2 + b3.^2*cos(theta).^2);

polarplot(theta, radius3, 'linewidth', 3)
hold on

% catheter
b = (3*10^(-3))/2;
a = (3*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on

% excel
num=readmatrix('reconstruction2.xlsx', 'sheet', '9fr', 'Range', 'A30:L41');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot elliptical model r_{major axis} = 4.5mm')

% Model 10mm
% real model
subplot(2, 3, 4)
b4 = (5*10^(-3))/2;
a4 = (10*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius4 = (a4.*b4)./sqrt(a4.^2.*(sin(theta)).^2 + b4.^2*cos(theta).^2);

polarplot(theta, radius4, 'linewidth', 3)
hold on

% catheter
b = (3*10^(-3))/2;
a = (3*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on

% excel
num=readmatrix('reconstruction2.xlsx', 'sheet', '9fr', 'Range', 'A45:L56');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot elliptical model r_{major axis} = 5mm')

% Model 12mm
% real model
subplot(2, 3, 5)
b5 = (6*10^(-3))/2;
a5 = (12*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius5 = (a5.*b5)./sqrt(a5.^2.*(sin(theta)).^2 + b5.^2*cos(theta).^2);

polarplot(theta, radius5, 'linewidth', 3)
hold on

% catheter
b = (3*10^(-3))/2;
a = (3*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on

% excel
num=readmatrix('reconstruction2.xlsx', 'sheet', '9fr', 'Range', 'A59:L70');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot elliptical model r_{major axis} = 6mm')

% Model 15mm
% real model
subplot(2, 3, 6)
b6 = (7.5*10^(-3))/2;
a6 = (15*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius6 = (a6.*b6)./sqrt(a6.^2.*(sin(theta)).^2 + b6.^2*cos(theta).^2);

polarplot(theta, radius6, 'linewidth', 3)
hold on

% catheter
b = (3*10^(-3))/2;
a = (3*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on

% excel
num=readmatrix('reconstruction2.xlsx', 'sheet', '9fr', 'Range', 'A73:L84');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2)

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot elliptical model r_{major axis} = 7.5mm')

% add a bit space to the figure
fig = gcf;
fig.Position(3) = fig.Position(3) + 250;
% add legend
Lgnd = legend('true radius', 'catheter 9fr (D=3mm)', 'threshold 1/3', 'threshold 1/2', 'threshold 2/3')
Lgnd.Position(1) = -0.04;
Lgnd.Position(2) = 0.45;

set(gca, 'fontsize', 15)

%% catheter 14fr

% Model 10mm
%real model
figure
sgtitle ('3D absolute reconstruction comparison true to measured radii - catheter 14fr ', 'fontsize', 16)
subplot(2, 3, 1)
b = (5.2*10^(-3))/2;
a = (10*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 3)
hold on
% catheter
b = (4.7*10^(-3))/2;
a = (4.7*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on

num=readmatrix('reconstruction2.xlsx', 'sheet', '14fr', 'Range', 'A2:L13');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot elliptical model r_{major axis} =  5mm')

% Model 11mm
subplot(2, 3, 2)
b2 = (5.5*10^(-3))/2;
a2 = (11*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a2.*b2)./sqrt(a2.^2.*(sin(theta)).^2 + b2.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 3)
hold on

% catheter
b = (4.7*10^(-3))/2;
a = (4.7*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on


num=readmatrix('reconstruction2.xlsx', 'sheet', '14fr', 'Range', 'A16:L27');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot elliptical model r_{major axis} =  5.5mm')


% Model 12mm
subplot(2, 3, 3)
b2 = (6*10^(-3))/2;
a2 = (12*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a2.*b2)./sqrt(a2.^2.*(sin(theta)).^2 + b2.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 3)
hold on

% catheter
b = (4.7*10^(-3))/2;
a = (4.7*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on


num=readmatrix('reconstruction2.xlsx', 'sheet', '14fr', 'Range', 'A29:L40');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot elliptical model r_{major axis} = 6mm')

% Model 14mm
subplot(2, 3, 4)
b2 = (7*10^(-3))/2;
a2 = (14*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a2.*b2)./sqrt(a2.^2.*(sin(theta)).^2 + b2.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 3)
hold on

% catheter
b = (4.7*10^(-3))/2;
a = (4.7*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on


num=readmatrix('reconstruction2.xlsx', 'sheet', '14fr', 'Range', 'A43:L54');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot elliptical model r_{major axis} = 7mm')

% Model 15mm
subplot(2, 3, 5)
b2 = (7.5*10^(-3))/2;
a2 = (15*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a2.*b2)./sqrt(a2.^2.*(sin(theta)).^2 + b2.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 3)
hold on

% catheter
b = (4.7*10^(-3))/2;
a = (4.7*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on

num=readmatrix('reconstruction2.xlsx', 'sheet', '14fr', 'Range', 'A57:L68');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot elliptical model r_{major axis} = 7.5mm')

% Model 17mm
subplot(2, 3, 6)
b2 = (8.5*10^(-3))/2;
a2 = (17*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a2.*b2)./sqrt(a2.^2.*(sin(theta)).^2 + b2.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 3)
hold on

% catheter
b = (4.7*10^(-3))/2;
a = (4.7*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on


num=readmatrix('reconstruction2.xlsx', 'sheet', '14fr', 'Range', 'A70:L81');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2)

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot elliptical model r_{major axis} = 8.5mm')

% add a bit space to the figure
fig = gcf;
fig.Position(3) = fig.Position(3) + 250;
% add legend
Lgnd = legend('true radius', 'catheter 14fr (D=4.7mm)', 'threshold 1/3', 'threshold 1/2', 'threshold 2/3')
Lgnd.Position(1) = -0.04;
Lgnd.Position(2) = 0.45;

set(gca, 'fontsize', 15)


%% catheter 16fr

% Model 10mm
figure
sgtitle ('3D absolute reconstruction comparison true to measured radii - catheter 16fr ', 'fontsize', 16)
subplot(2, 3, 1)
b = (5.8*10^(-3))/2;
a = (10*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 3)
hold on

b = (5.3*10^(-3))/2;
a = (5.3*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on

num=readmatrix('reconstruction2.xlsx', 'sheet', '16fr', 'Range', 'A2:L13');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot elliptical model r_{major axis} = 5mm')

% Model 12mm
subplot(2, 3, 2)
b2 = (6*10^(-3))/2;
a2 = (12*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a2.*b2)./sqrt(a2.^2.*(sin(theta)).^2 + b2.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 3)
hold on

b = (5.3*10^(-3))/2;
a = (5.3*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on

num=readmatrix('reconstruction2.xlsx', 'sheet', '16fr', 'Range', 'A16:L27');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot elliptical model r_{major axis} = 6mm')


% Model 14mm
subplot(2, 3, 3)
b2 = (7*10^(-3))/2;
a2 = (14*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a2.*b2)./sqrt(a2.^2.*(sin(theta)).^2 + b2.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 3)
hold on

b = (5.3*10^(-3))/2;
a = (5.3*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on

num=readmatrix('reconstruction2.xlsx', 'sheet', '16fr', 'Range', 'A29:L40');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot elliptical model r_{major axis} = 7mm')

% Model 15mm
subplot(2, 3, 4)
b2 = (7.5*10^(-3))/2;
a2 = (15*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a2.*b2)./sqrt(a2.^2.*(sin(theta)).^2 + b2.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 3)
hold on

b = (5.3*10^(-3))/2;
a = (5.3*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on

num=readmatrix('reconstruction2.xlsx', 'sheet', '16fr', 'Range', 'A45:L56');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot elliptical model r_{major axis} = 7.5mm')

% Model 17mm
subplot(2, 3, 5)
b2 = (8.5*10^(-3))/2;
a2 = (17*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a2.*b2)./sqrt(a2.^2.*(sin(theta)).^2 + b2.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 3)
hold on

b = (5.3*10^(-3))/2;
a = (5.3*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on


num=readmatrix('reconstruction2.xlsx', 'sheet', '16fr', 'Range', 'A43:L54');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot elliptical model r_{major axis} = 8.5mm')


% add a bit space to the figure
fig = gcf;
fig.Position(3) = fig.Position(3) + 250;
% add legend
Lgnd = legend('true radius', 'catheter 16fr D=5.3mm', 'threshold 1/3', 'threshold 1/2', 'threshold 2/3')
Lgnd.Position(1) = 0.7;
Lgnd.Position(2) = 0.1;

set(gca, 'fontsize', 15)
rticks(0:0.002:0.01)


%% CIRCULAR

%% catheter 9fr

% Model 6mm
% Real model
figure
sgtitle ('3D absolute reconstruction comparison true to measured radii - catheter 9fr ', 'fontsize', 16)

subplot(2, 3, 1)
b1 = (6*10^(-3))/2;
a1 = (6*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius1 = (a1.*b1)./sqrt(a1.^2.*(sin(theta)).^2 + b1.^2*cos(theta).^2);

polarplot(theta, radius1, 'linewidth', 3)
hold on

% catheter
b = (3*10^(-3))/2;
a = (3*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);
polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on

num=readmatrix('reconstruction2CIR.xlsx', 'sheet', '9fr', 'Range', 'A2:L13');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
%rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot circular model r = 3mm')

% Model 8mm
% Real model
subplot(2, 3, 2)
b2 = (8*10^(-3))/2;
a2 = (8*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius2 = (a2.*b2)./sqrt(a2.^2.*(sin(theta)).^2 + b2.^2*cos(theta).^2);

polarplot(theta, radius2, 'linewidth', 3)
hold on

% catheter
b = (3*10^(-3))/2;
a = (3*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on

% excel
num=readmatrix('reconstruction2CIR.xlsx', 'sheet', '9fr', 'Range', 'A16:L27');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot circular model r = 4mm')


% Model 9mm
% real model
subplot(2, 3, 3)
b3 = (9*10^(-3))/2;
a3 = (9*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius3 = (a3.*b3)./sqrt(a3.^2.*(sin(theta)).^2 + b3.^2*cos(theta).^2);

polarplot(theta, radius3, 'linewidth', 3)
hold on

% catheter
b = (3*10^(-3))/2;
a = (3*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on

% excel
num=readmatrix('reconstruction2CIR.xlsx', 'sheet', '9fr', 'Range', 'A30:L41');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot circular model r = 4.5mm')

% Model 10mm
% real model
subplot(2, 3, 4)
b4 = (10*10^(-3))/2;
a4 = (10*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius4 = (a4.*b4)./sqrt(a4.^2.*(sin(theta)).^2 + b4.^2*cos(theta).^2);

polarplot(theta, radius4, 'linewidth', 3)
hold on

% catheter
b = (3*10^(-3))/2;
a = (3*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on

% excel
num=readmatrix('reconstruction2CIR.xlsx', 'sheet', '9fr', 'Range', 'A45:L56');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot circular model r = 5mm')

% Model 12mm
% real model
subplot(2, 3, 5)
b5 = (12*10^(-3))/2;
a5 = (12*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius5 = (a5.*b5)./sqrt(a5.^2.*(sin(theta)).^2 + b5.^2*cos(theta).^2);

polarplot(theta, radius5, 'linewidth', 3)
hold on

% catheter
b = (3*10^(-3))/2;
a = (3*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on

% excel
num=readmatrix('reconstruction2CIR.xlsx', 'sheet', '9fr', 'Range', 'A59:L70');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2);

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot circular model r = 6mm')

% Model 15mm
% real model
subplot(2, 3, 6)
b6 = (15*10^(-3))/2;
a6 = (15*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius6 = (a6.*b6)./sqrt(a6.^2.*(sin(theta)).^2 + b6.^2*cos(theta).^2);

polarplot(theta, radius6, 'linewidth', 3)
hold on

% catheter
b = (3*10^(-3))/2;
a = (3*10^(-3))/2;
theta = 0 : 0.01 : 2*pi;
radius = (a.*b)./sqrt(a.^2.*(sin(theta)).^2 + b.^2*cos(theta).^2);

polarplot(theta, radius, 'linewidth', 2, 'Color', 'r')
hold on

% excel
num=readmatrix('reconstruction2CIR.xlsx', 'sheet', '9fr', 'Range', 'A73:L84');
angle_t1=num(:,1);
angle1 = deg2rad(angle_t1);
radius_t1=num(:,2)

polarscatter(angle1, radius_t1,'filled', 'SizeData', 100)
hold on

angle_t2=num(:,5);
angle2 = deg2rad(angle_t2);
radius_t2=num(:,6);

polarscatter(angle2, radius_t2, 'filled', 'SizeData', 100)
hold on

angle_t3=num(:,9);
angle3 = deg2rad(angle_t3);
radius_t3=num(:,10);

polarscatter(angle3, radius_t3, 'filled', 'SizeData', 100)

set(gca, 'fontsize', 15)
hold on
ax = gca;
ax.RAxis.Exponent = 0;
rtickformat('%g m')
rlim([0 0.01])
rticklabels({'r = 0 mm','r = 2 mm','r = 4 mm', 'r = 6 mm', 'r = 8 mm', 'r = 10mm'})
thetatickformat('degrees')
title('polar plot circular model r = 7.5mm')

% add a bit space to the figure
fig = gcf;
fig.Position(3) = fig.Position(3) + 250;
% add legend
Lgnd = legend('true radius', 'catheter 9fr (D=3mm)', 'threshold 1/3', 'threshold 1/2', 'threshold 2/3')
Lgnd.Position(1) = -0.04;
Lgnd.Position(2) = 0.45;

set(gca, 'fontsize', 15)
