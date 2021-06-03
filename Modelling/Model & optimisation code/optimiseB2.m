tic

close all
warning('off','all')

%Define cost function
costFcn = @(x)sim_2balloon(x, T_18_00);

% %Define bounds of variables
% nVB = [0 10]; %Noise vertical
% nHB = [0 10]; %Noise Horizontal
% nSB = [0.01 0.1]; %Sample time of noise
% V0B = [1 4]; %Outlet velocity
% normalScalingB = [0.25 1]; %Flow scaling
% hdB = [0.05 0.1]; %
% thetaB = [1 5];
% kB = [0.5e7 1.5e7];
% dB = [1 1000];
% twB = [0.5e-4 1.5e-4];
% dCouplingB = [1 10000];
% kCouplingB = [0.5e7 1.5e7];
% springDampingB = [0.5 0.99];
% pdfMeanB = [0.1 0.5];
% pdfVarB = [0.1 0.9];

%Define bounds of variables
nVB = [0 1]; %Noise vertical
nHB = [0 10]; %Noise Horizontal
nSB = [0.01 0.03]; %Sample time of noise
V0B = [1 4]; %Outlet velocity
normalScalingB = [0.25 1]; %Flow scaling
hdB = [0.05 0.1]; %
thetaB = [0.5 5];
kB = [0.5e7 1.5e7];
dB = [500 1500];
twB = [0.5e-4 1.5e-4];
dCouplingB = [1 10000];
kCouplingB = [0.5e7 1.5e7];
springDampingB = [0.5 0.99];
pdfMeanB = [0.1 0.6];
pdfVarB = [0.1 0.9];


%Create
nV = optimizableVariable('nV',nVB);
nH = optimizableVariable('nH',nHB);
nS = optimizableVariable('nS',nSB);
% V0 = optimizableVariable('V0',V0B);
% normalScaling = optimizableVariable('normalScaling',normalScalingB);
% hd = optimizableVariable('hd',hdB);
% theta  = optimizableVariable('theta',thetaB);
% k = optimizableVariable('k',kB);
% d = optimizableVariable('d',dB);
% tw = optimizableVariable('tw',twB);
% dCoupling = optimizableVariable('dCoupling',dCouplingB);
% kCoupling = optimizableVariable('kCoupling',kCouplingB);
% springDamping = optimizableVariable('springDamping',springDampingB);
% pdfMean = optimizableVariable('pdfMean',pdfMeanB);
% pdfVar = optimizableVariable('pdfVar',pdfVarB);

results = bayesopt(costFcn,[nV, nH, nS]...
    ,'MaxObjectiveEvaluations',100,'AcquisitionFunctionName',...
    'expected-improvement','UseParallel',1,'IsObjectiveDeterministic' ,0,'NumSeedPoints',50);
% results = bayesopt(costFcn,[nV, nH, nS,k,d,tw,dCoupling,kCoupling,springDamping,pdfMean,pdfVar]...
%     ,'MaxObjectiveEvaluations',100,'AcquisitionFunctionName',...
%     'expected-improvement','UseParallel',1,'IsObjectiveDeterministic',0,'NumSeedPoints',50);

%  V0,normalScaling,hd,theta,k,d,tw,dCoupling,kCoupling,springDamping,pdfMean,pdfVa
%% Simulate result

x=results.XAtMinObjective;


%Noise params
nV = x2nn.nV;
nH = x2nn.nH;
nS = x2nn.nS;
% 
% nV = 0;
% nH = 0;
% nS = 0;

%Flow params
V0 = x2ll.V0;
normalScaling = x2ll.normalScaling;
hd = x2ll.hd;
theta = x2ll.theta;

%Contact params
d = x2ll.d;
k = x2ll.k;
tw = x2ll.tw;

%Coupling params
dCoupling = x2ll.dCoupling;
kCoupling = x2ll.kCoupling;
springDamping = x2ll.springDamping;
pdfMean = x2ll.pdfMean;
pdfVar = x2ll.pdfVar;

% normalScaling = 1;

% Random seed
seedX = randi(100000);
seedY = randi(100000);
seedZ = randi(100000);
seedX1 = randi(100000);
seedY1 = randi(100000);
seedZ1 = randi(100000);

%Known params
rn =  125/2000; %Radius of nozzle in m
Cd = 0.185;
bm = 2/1000;
rb = 80/1000;

simOut = sim("two_balloons_empirical");
T = simOut.yout{1}.Values.Data();
X = T(:,1);
Y = T(:,2);
Z = T(:,3);
D = T(:,4);
F = T(:,5);

T1 = simOut.yout{2}.Values.Data();
X1 = T1(:,1);
Y1 = T1(:,2);
Z1 = T1(:,3);
D1 = T1(:,4);
F1 = T1(:,5);

% x2ii = x;
% data2ii = [X Y Z D F X1 Y1 Z1 D1 F1];
% Z=smoothdata(Z,'gaussian',50);
% plot(Z)
% hold on
% 
% Z=smoothdata(Z1,'gaussian',50);
% plot(Z)
% hold on
% 
% plot(T_18_00(:,3))
% hold on
% plot(T_18_00(:,6))

% legend

runtime = toc
