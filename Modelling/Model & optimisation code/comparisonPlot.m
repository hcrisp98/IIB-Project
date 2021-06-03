%OLD

mdlName='singleBalloon'

% Optimised parameters
mb = 1/1000; %Balloon mass in kg
rb = 0.16; %Balloon radius in m
rn = a(1); %Nozzle diameter in m
theta = a(2); %Nozzle angle in degrees
V0 = a(3); %Outlet velocity in m/s
Cd = a(4); %Drag coefficient
CdH = Cd;
iz = a(5); %Initial z in m
hd = a(6);
nV = a(7);
nVV = a(8);
nS = 1;
meanV = a(9);

open(mdlName)
simOut = sim(mdlName,'FastRestart','off','SrcWorkspace','current');
z = simOut.z.Data

clf
figure(1)
ax=1:8999;
ax=ax/30;
trajectory=smoothedData_B_18_0(5,:);
%trajectory=trajectory/187.5;

plot(ax(1:500),trajectory(1:500),'r');
hold on
ylim([0 3.5])
xlim([0 16])
title('Comparison of real-world and simulated trajectories')
xlabel('Time, seconds')
ylabel('Height Above Fan, meters')
plot(ax(1:500),z(1:500),'b');
hold off

% %NEW
% mdlName='singleBalloon'
% 
% % Optimised parameters
% mb = 0.001; %Balloon mass in kg
% rb = 0.08; %Balloon radius in m
% rn = a(1); %Nozzle diameter in m
% theta = a(2); %Nozzle angle in degrees
% V0 = a(3); %Outlet velocity in m/s
% Cd = a(4); %Drag coefficient
% CdH = Cd;
% iz = 1; %Initial z in m
% hd = a(5);
% nV = a(6);
% nVV = a(7);
% nS = 1;
% meanV = a(8);
% 
% open(mdlName)
% simOut = sim(mdlName,'FastRestart','off','SrcWorkspace','current');
% z = simOut.z.Data
% 
% clf
% figure(1)
% ax=1:8999;
% ax=ax/30;
% trajectory=smoothedData_B_18_0(5,:);
% %trajectory=trajectory/187.5;
% 
% plot(ax(1:500),trajectory(1:500),'r');
% hold on
% ylim([0 3.5])
% xlim([0 16])
% title('Comparison of real-world and simulated trajectories')
% xlabel('Time, seconds')
% ylabel('Height Above Fan, meters')
% plot(ax(1:500),z(1:500),'b');
% hold off