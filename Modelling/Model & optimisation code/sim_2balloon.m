function [e] = sim_2balloon(x, T_18_00)


if istable(x)
    %Noise params
    nV = x.nV;
    nH = x.nH;
    nS = x.nS;
    
%     %Flow params
%     V0 = x.V0;
%     normalScaling = x.normalScaling;
%     hd = x.hd;
%     theta =  x.theta;
%     
%     %Contact params
%     d = x.d;
%     k = x.k;
%     tw = x.tw;
%     
%     %Coupling params
%     dCoupling = x.dCoupling;
%     kCoupling = x.kCoupling;
%     springDamping = x.springDamping;
%     pdfMean = x.pdfMean;
%     pdfVar = x.pdfVar;
    
    
else
    %Noise params
    nV = x(1);
    nH = x(2);
    nS = x(3);
    
%     %Flow params
%     V0 = x(1);
%     normalScaling = x(2);
%     hd = x(3);
%     theta =  x(4);
%     
%     %Contact modelling
%     k = x(5);
%     d = x(6);
%     tw = x(7);
%     
%     %Coupling params
%     dCoupling = x(8);
%     kCoupling = x(9);
%     springDamping = x(10);
%     pdfMean = x(11);
%     pdfVar = x(12);

end

%Known params
rb = 80/1000;
rb1 = 80/1000;
mb = 2/1000; %Balloon mass in kg
rn =  125/2000; %Radius of nozzle in m
Cd = 0.185;
% normalScaling = 1;

% V0 = 2.9899;
% normalScaling = 0.38079;
% hd = 0.099456;
% theta = 4.9952;
% k = 12309862.5942605;
% d = 0.221283756559489;
% tw = 0.000119527056266891;

%x2aa
V0 = 1.01295922370842;
normalScaling = 0.259830816053086;
hd = 0.0541296919352610;
theta = 4.93687905947484;
k = 5073686.06273245;
d = 1059.74472396226;
tw = 5.22077192972005e-05;
dCoupling = 153.936897572354;
kCoupling = 8310635.55156443;
springDamping = 0.663640164526807;
pdfMean = 0.521762432755393;
pdfVar = 0.179878989504282;

% %x2ll
% V0 = 3.36875761100831;
% normalScaling = 0.904807700290963;
% hd = 0.0643752050618990;
% theta = 3.73374253429196;
% k = 12673290.9890862;
% d = 1417.08342471355;
% tw = 0.000109114270758278;
% dCoupling = 6288.27031972899;
% kCoupling = 9698911.22872435;
% springDamping = 0.721458194347795;
% pdfMean = 0.590198314980439;
% pdfVar = 0.224877982104222;

%x2oo
% V0 = 2.17844001601351
% normalScaling = 0.253624172692903;
% hd = 0.0972354235912046;
% theta = 3.22973994674177;
% k = 7723912.77088601;
% d = 701.049471073722;
% tw = 0.000147222868758348;
% dCoupling = 8240.55251180632;
% kCoupling = 6649832.85386951;
% springDamping = 0.590059409657951;
% pdfMean = 0.331906391398763;
% pdfVar = 0.109372553418757;

% nH = 0;
% nV = 0;
% nS = 0;



b1z = T_18_00(:,3);
b1x = T_18_00(:,1);
b1y = T_18_00(:,2);
b2z = T_18_00(:,6);
b2x = T_18_00(:,4);
b2y = T_18_00(:,5);

% reference data from real world experiments
meanZ = [mean(b1z) mean(b2z)];
varZ = [var(b1z) var(b2z)];
varXY = [(var(b1x)+var(b1y))/2 (var(b2x)+var(b2y))/2];

% classRef = [66 58 176];
% classRef = classRef/300;
% 
% classRef = [0.6594 0.0676 0.2730];
% classRef = [0.1217 0.0600 0.8183];

count = 1;

for bm = [2 5]/1000
    % Random seed
    seedX = randi(100000);
    seedY = randi(100000);
    seedZ = randi(100000);
    seedX1 = randi(100000);
    seedY1 = randi(100000);
    seedZ1 = randi(100000);
    
    try
        simOut = sim("two_balloons_empirical",'FastRestart','off','SrcWorkspace'...
            ,'current');
        T = simOut.yout{1}.Values.Data();
        X = T(:,1);
        Y = T(:,2);
        Z = T(:,3);
        
        T1 = simOut.yout{2}.Values.Data();
        X1 = T1(:,1);
        Y1 = T1(:,2);
        Z1 = T1(:,3);
        
%         %comparing individual balloons
%         ZMError = abs(mean(Z) - meanZ(1))/meanZ(1);
%         Z1MError = abs(mean(Z1) - meanZ(2))/meanZ(2);
%         ZVError = abs(var(Z) - varZ(1))/varZ(1);
%         Z1VError = abs(var(Z1) - varZ(2))/varZ(2);
%         XYVError = abs(((var(X) + var(Y))/2) -varXY(1))/varXY(1);
%         XY1VError = abs(((var(X1) + var(Y1))/2) -varXY(2))/varXY(2);
%         
%         meanZError = (ZMError+Z1MError)/2;
%         varZError = (ZVError+Z1VError)/2;
%         varXYError = (XYVError+XY1VError)/2;
% 
%         e(count) = 100*(meanZError + varZError + varXYError)/3;
%         
%         %comparing balloon averages
%         meanZsim = [mean(Z) mean(Z1)];
%         varZsim = [var(Z) var(Z1)];
%         varXYsim = [(var(X)+var(Y))/2 (var(X1)+var(Y1))/2];
%         ZMError = abs(mean(meanZ) - mean(meanZsim))/mean(meanZ);
%         ZVError = abs(mean(varZ) - mean(varZsim))/mean(varZ);
%         XYVError = abs(mean(varXY) - mean(varXYsim))/mean(varXY);
        
%       e(count) = 100*(ZMError + ZVError + XYVError)/3;
%         
%         %behaviours
%         thresholdFalling = 0.5;
%         thresholdInteracting = 2*rb;
% 
%         trajectorya= Z;
%         trajectoryb= Z1;
% 
%         falling= 0;
%         interacting= 0;
%         stable= 0;
%         
%         for i=1:40:12000;
%             if trajectorya(i) < thresholdFalling || trajectoryb(i) < thresholdFalling;
%                 falling = falling+1;
%             elseif abs(trajectorya(i)-trajectoryb(i))<thresholdInteracting;
%                 interacting = interacting+1;
%             else;
%                 stable = stable+1;
%             end
%         end
% 
%         classSim = [falling interacting stable];
%         
%         %new behaviours
%         thresholdFalling = 0.5;
%         thresholdInteracting = 1.1*2*rb;
% 
%         falling= 0;
%         interacting= 0;
%         stable= 0;
% 
%         %balloon1
%         for i=1:40:12000;
%             if Z(i) < thresholdFalling;
%                 falling = falling+1;
%             elseif (((X(i)-X1(i))^2+(Y(i)-Y1(i))^2+(Z(i)-Z1(i))^2)^(1/2))<thresholdInteracting;
%                 interacting = interacting+1;
%             else;
%                 stable = stable+1;
%             end
%         end
%         
%         %balloon2
%         for i=1:40:12000;
%             if Z1(i) < thresholdFalling;
%                 falling = falling+1;
%             elseif (((X(i)-X1(i))^2+(Y(i)-Y1(i))^2+(Z(i)-Z1(i))^2)^(1/2))<thresholdInteracting;
%                 interacting = interacting+1;
%             else;
%                 stable = stable+1;
%             end
%         end
% 
%         classSim = [falling interacting stable];
%         classSim = classSim/sum(classSim);
        
        %transition probs


        thresholdFalling = 0.5;
        thresholdInteracting = 1.1*2*rb;

        falling= 0;
        interacting= 0;
        stable= 0;

        classOrder = [];
        classOrder1 = [];

        %balloon1
        for i=1:40:12000;
            if Z(i) < thresholdFalling;
                falling = falling+1;
                classOrder(i) = 1;
            elseif (((X(i)-X1(i))^2+(Y(i)-Y1(i))^2+(Z(i)-Z1(i))^2)^(1/2))<thresholdInteracting;;
                interacting = interacting+1;
                classOrder(i) = 2;
            else;
                stable = stable+1;
                classOrder(i) = 3;
            end
        end

        %balloon2
        for i=1:40:12000;
            if Z1(i) < thresholdFalling;
                falling = falling+1;
                classOrder1(i) = 1;
            elseif (((X(i)-X1(i))^2+(Y(i)-Y1(i))^2+(Z(i)-Z1(i))^2)^(1/2))<thresholdInteracting;;
                interacting = interacting+1;
                classOrder1(i) = 2;
            else;
                stable = stable+1;
                classOrder1(i) = 3;
            end
        end

        classOrder=nonzeros(classOrder)';
        classOrder1=nonzeros(classOrder1)';

        class= [falling interacting stable];

        % create state transition probability matrix 

        seqCount = zeros(3,3);
        for i=1:3
        for j=1:3
            seqCount(i,j)= sum(strfind(classOrder,[i j])~=0)/(numel(classOrder)-1);
        end
        end

        seqCount1 = zeros(3,3);
        for i=1:3
        for j=1:3
            seqCount1(i,j)= sum(strfind(classOrder1,[i j])~=0)/(numel(classOrder1)-1);
        end
        end

        transitionMatrix = bsxfun(@rdivide,seqCount,sum(seqCount,2));
        transitionMatrix1 = bsxfun(@rdivide,seqCount1,sum(seqCount1,2));

        probSim = (transitionMatrix+transitionMatrix1)/2;
        probReal = [0.606060606060606,0.053613053613054,0.340326340326340;0.027777777777778,0.111111111111111,0.861111111111111;0.057101439616102,0.057101439616102,0.885797120767795];

        for i = 1:3;
            for j = 1:3;
                test3(i,j) = (probSim(i,j)-probReal(i,j))^2
            end
        end

        trans = sum(abs(test3), 'all')/9;
        

%        a= mean(abs(classRef - classSim))
%        b= ZMError + ZVError + XYVError
%        c= meanZError + varZError + varXYError
    
        
        e(count) = trans;
        
    catch
       e(count) = NaN;
       
    end
    
    count = count+1;
end

e = mean(e);

end

