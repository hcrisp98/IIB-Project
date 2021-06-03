figure(1)
clf

% tiledlayout(2,1,'TileSpacing','compact')

nexttile
load Step30
plot(tdata-10,trajectory,'LineWidth',2)
load Step50
hold on
plot(tdata-10,trajectory,'LineWidth',2)

set(gca,'FontSize',20)
xlabel('Time (s)')
ylabel('Height (mm)')

xlim([0 20])


figure (2)

nexttile
load Step30
trajectory=trajectory(round(length(trajectory)/2:end))
plot(trajectory,gradient(trajectory)/mean(diff(tdata)),'LineWidth',2)
load Step50
trajectory=trajectory(round(length(trajectory)/2:end))
hold on
plot(trajectory,gradient(trajectory)/mean(diff(tdata)),'LineWidth',2)

legend({'Low power','High power'})



set(gca,'FontSize',20)
xlabel('Height (mm)')
ylabel('Velocity (mm/s)')

% 
% 
% load stereoParams
% load systematicData
% load smoothedData_B_20_33
% nb = 1;
% ID = 1;
% 
% 
% A118=smoothedData_A_18_0;
% B118=smoothedData_B_18_0;
% 
% A122=smoothedData_A_22_0;
% B122=smoothedData_B_22_0;
% 
% DataA=A118;
% DataB=B118;
% 
% traj3D
% 
% nexttile
% plot((1:length(Z))*0.0240-100,Z,'LineWidth',2);
% xlim([0 100])
% 
% 
% DataA=A122;
% DataB=B122;
% 
% traj3D
% 
% hold on
% plot((1:length(Z))*0.0240-100,Z,'LineWidth',2);
% xlim([0 100])
% 
% set(gca,'FontSize',20)
% xlabel('Time (s)')
% ylabel('Height (mm)')
% 
% 
% A118=smoothedData_A_18_3;
% B118=smoothedData_B_18_3;
% 
% A122=smoothedData_A_22_3;
% B122=smoothedData_B_22_3;
% 
% 
% DataA=A118;
% DataB=B118;
% 
% traj3D
% 
% nexttile
% plot((1:length(Z))*0.0240,Z,'LineWidth',2);
% xlim([0 100])
% 
% 
% DataA=A122;
% DataB=B122;
% 
% traj3D
% 
% hold on
% plot((1:length(Z))*0.0240,Z,'LineWidth',2);
% xlim([0 100])
% 
% set(gca,'FontSize',20)
% xlabel('Time (s)')
% ylabel('Height (mm)')