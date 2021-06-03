function [e] = sim_balloon(x)


if istable(x)
    %Noise params
    nV = x.nV;
    nH = x.nH;
    nS = x.nS;
    
    %Flow params
    V0 = x.V0;
    normalScaling = x.normalScaling;
    hd = x.hd;
    theta =  x.theta;
%     Cd = x.Cd;
    
else
    %Noise params
    nV = x(1);
    nH = x(2);
    nS = x(3);
    
    %Flow params
    V0 = x(4);
    normalScaling = x(5);
    hd = x(6);
    theta = x(7);
%     Cd = x(8);

end


%Known params
rn =  125/2000; %Radius of nozzle in m
Cd = 0.185;
% bm = 2/1000;
% rb = 0.08;
% nV=0;
% nH=0;
% nS=0;

%x1aa
% V0 = 3.62568013617505;
% normalScaling = 0.390633358473745;
% hd = 0.0834089965816395;
% theta = 4.98053318634378;

% %x1gg
% V0= 3.59996313742855;
% normalScaling = 0.268660658215776;
% hd = 0.0749472819282097;
% theta = 2.33845329116580;


%Known params for balloon 0 mass fan 0.18
meanZ = 1.11;
varZ = 0.0942;
varXY = mean([0.0086 0.0029]);
probReal = [98.54 1.46 100];

% %Known params for balloon 0 mass fan 0.22
% meanZ = 1.3838;
% varZ = 0.3330;
% varXY = mean([0.0181 0.0143]);

count = 1;

 for bm = [2 5]/1000
    % Random seed
    seedX = randi(100000);
    seedY = randi(100000);
    seedZ = randi(100000);
    
    try
        simOut = sim("one_balloon",'FastRestart','off','SrcWorkspace'...
            ,'current');
        T = simOut.yout{1}.Values.Data();
        X = T(:,1);
        Y = T(:,2);
        Z = T(:,3);
        
%         %%Position
%         meanZError = abs(mean(Z) - meanZ)/meanZ;
%         varZError = abs(var(Z) - varZ)/varZ;
%         varXYError = abs(((var(X) + var(Y))/2) - varXY)/varXY;
% %         e(count) = 100*(meanZError + varZError + varXYError)/3;
% 
%         %%Behaviours
%         thresholdFalling = 0.5;
% 
%         trajectory= Z;
% 
%         falling= 0;
%         stable= 0;
% 
%         for i=1:40:12000;
%             if trajectory(i) < thresholdFalling;
%                 falling = falling+1;
%             else;
%                 stable = stable+1;
%             end
%         end
% 
%         classRef1 = [50 250];
%         classSim = [falling stable];
        
%         %%Transition prob1
% 
%         nb=1;
%         ID=1;
% 
%         BarVec = [];
%     
%         XX=X*1000;
%         YY=Y*1000;
%         ZZ=Z*1000;
% 
%         detectFalling;
%         detectInteracting;
% 
%         ZFallingMarkov=[];
%         ZInteractingMarkov=[];
%         ZZMarkov = [];
% 
%         for k=2:length(ZFalling)
%             if min(isnan(ZFalling(k,:)))==1
%                 ZZMarkov(end+1,:)=ZZ(k,:);
%                 ZFallingMarkov(end+1,:)=ZFalling(k,:);
%                 ZInteractingMarkov(end+1,:)=ZInteracting(k,:);
%             elseif min(isnan(ZFalling(k,:)))==0 && min(isnan(ZFalling(k-1,:)))==1
%                 ZZMarkov(end+1,:)=ZZ(k,:);
%                 ZFallingMarkov(end+1,:)=ZFalling(k,:);
%                 ZInteractingMarkov(end+1,:)=ZInteracting(k,:); 
%             end 
%         end
%         
%         markovDiagram;
% 
%         for i=1 %:cls
%             G=graphs{i};
%             h=plot(G,'Layout','circle','NodeColor','r','LineWidth',3,'EdgeLabel',G.Edges.Weight);
% 
%         probSim = h.EdgeLabel;
%         probSim = cellfun(@str2num,probSim);
%         end

        % Transition prob2
        thresholdFalling = 0.5;
        trajectory1 = Z;

        falling= 0;
        stable= 0;

        classOrder = []

        for i=1:40:12000;
            if trajectory1(i) < thresholdFalling;
                falling = falling+1;
                classOrder(i) = 1;
            else;
                stable = stable+1;
                classOrder(i) = 2;
            end
        end

        classOrder=nonzeros(classOrder)'

        class= [falling stable]

        % create state transition probability matrix 

        seqCount = zeros(2,2);
        for i=1:2
        for j=1:2
            seqCount(i,j)= sum(strfind(classOrder,[i j])~=0)/(numel(classOrder)-1);
        end
        end

        probSim = bsxfun(@rdivide,seqCount,sum(seqCount,2));

        probReal = [0.684210526315790,0.315789473684211;0.0214285714285714,0.978571428571429];
        
        for i = 1:2;
            for j = 1:2;
                test3(i,j) = (probSim(i,j)-probReal(i,j))^2
            end
        end

        trans = sum(abs(test3), 'all')/4
        
        
        %%Picking objective function
        
%         a= mean(abs(classRef1 - classSim))
%         b= meanZError + varZError + varXYError
%         trans= mean(abs(probReal - probSim))
        
        e(count) = trans;

    catch
        e(count) = NaN;
    end
    
    count = count+1;
 end

e = mean(e);

 end

