%Balloon params
rb = 80/1000; %Balloon radius in m
rb1 = 80/1000;
mb = 2/1000; %Balloon mass in kg

%Initial conditions
%iz = 0.3; %Initial z in m

%Flow parameters
rn =  125/2000; %Radius of nozzle in m
Cd = 0.185;
CdH = Cd;
theta = 3.5;
V0 = 3.7;
normalScaling = 1;

%Damping
hd = 0.1;

%Noise
nH = 1*10;
nV = 0.05*10;
nS = 0.025;

%Contact modelling
k = 1e7;
d = 1000;
tw = 1e-4;

%Seeds
seedX = randi(100000);
seedY = randi(100000);
seedZ = randi(100000);
seedX1 = randi(100000);
seedY1 = randi(100000);
seedZ1 = randi(100000);

%Coupling
kCoupling = 1e7;
dCoupling = 10000;
springDamping = 0.9;
pdfMean = 0.5;
pdfVar = 0.4;

