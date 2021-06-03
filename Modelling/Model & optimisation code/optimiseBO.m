tic
close all
warning('off','all')

%Define cost function
costFcn = @(x)sim_balloon(x);

%Define bounds of variables
nVB = [0 0.3]; %Noise vertical
nHB = [0 0.3]; %Noise Horizontal
nSB = [0.05 0.1]; %Sample time of noise
V0B = [1 4]; %Outlet velocity
normalScalingB = [0.25 1]; %Flow scaling
hdB = [0.05 0.1]; %
thetaB = [0.5 5];
% CdB = [0.1 0.3];

%Create
nV = optimizableVariable('nV',nVB);
nH = optimizableVariable('nH',nHB);
nS = optimizableVariable('nS',nSB);
V0 = optimizableVariable('V0',V0B);
normalScaling = optimizableVariable('normalScaling',normalScalingB);
hd = optimizableVariable('hd',hdB);
theta  = optimizableVariable('theta',thetaB);

% Cd = optimizableVariable('Cd',CdB); 

% lb = [nVB(1) nHB(1) nSB(1) V0B(1) normalScalingB(1) hdB(1) thetaB(1) CdB(1)];
% ub = [nVB(2) nHB(2) nSB(2) V0B(2) normalScalingB(2) hdB(2) thetaB(2) CdB(2)];
% 
% opts.MaxGenerations =  20;
% opts.PopulationSize =  20;
% opts.UseParallel = true;
% 
% ga(costFcn,length(ub),[],[],[],[],lb,ub,[],[],opts);
% 


results = bayesopt(costFcn,[nV, nH, nS, V0, normalScaling, hd, theta]...
    ,'MaxObjectiveEvaluations',100,'AcquisitionFunctionName',...
    'expected-improvement','UseParallel',1,'IsObjectiveDeterministic' ,0,'NumSeedPoints',50);

%% Simulate result

x=results.XAtMinObjective;

%Noise params
nV = x.nV;
nH = x.nH;
nS = x.nS;
% nV = 0;
% nH = 0;
% nS = 0;

%Flow params
V0 = x.V0;
normalScaling = x.normalScaling;
hd = x.hd;
theta = x.theta;

% Random seed
seedX = randi(100000);
seedY = randi(100000);
seedZ = randi(100000);

%Known params
rn =  125/2000; %Radius of nozzle in m
Cd = 0.185;
bm = 2/1000;
rb = 0.08;

%validating
% bm = 8/1000;
% V0 = 1.2222*V0;

simOut = sim("one_balloon");
% T = simOut.yout{1}.Values.Data();
% X = T(:,1);
% Y = T(:,2);
% Z = T(:,3);
% F = T(:,4);
% data1_18_3 = [X Y Z F];
% % x1= x;
% %Z=smoothdata(Z,'gaussian',50);
% plot(Z)
% hold on
% load Zref
% plot(Z)
% legend
runtime = toc

subplot(3,1,1);
plot(T_22_3(:,1));
ylabel('x (m)');
set(gca, 'XTickLabel',[]);
ylim([-1 1]);
title('Comparison of Optimised Model with Real-World Data');
hold on;
plot(data1_18_3(1:9000,1));
hold off;

subplot(3,1,2);
plot(T_22_3(:,2));
ylabel('y (m)');
set(gca, 'XTickLabel',[]);
ylim([-1 1]);
hold on;
plot(data1_18_3(1:9000,2));
hold off;

subplot(3,1,3);
plot(T_22_3(:,3));
ylabel('z (m)');
xticks([0 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000]);
xticklabels({'0', ' ', ' ', '100', ' ', ' ', '200', ' ', ' ', '300'});
xlabel('Seconds');
legend
ylim([0 3]);
hold on;
plot(data1_18_3(1:9000,3));
hold off;
