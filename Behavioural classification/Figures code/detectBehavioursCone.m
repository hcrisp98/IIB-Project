

figure(1)
clf
figure(2)
clf
% figure(3)
% clf
drawnow







ZFalling = ZZ.*fallingID;
XFalling = XX.*fallingID;
YFalling = YY.*fallingID;

% ZZ(~isnan(fallingID))=NaN;
% XX(~isnan(fallingID))=NaN;
% YY(~isnan(fallingID))=NaN;

fallPosition = [];
for t = 1:(length(fallingID)-1)
    for balloon=1:cols
        if isnan(fallingID(t,balloon)) && ~isnan(fallingID(t+1,balloon))
            fallPosition(end+1) = ZZ(t,balloon);
        end
    end
end

% ZZ(~isnan(removeID),:)=[];
% XX(~isnan(removeID),:)=[];
% YY(~isnan(removeID),:)=[];
% 
% ZFalling(~isnan(removeID),:)=[];
% XFalling(~isnan(removeID),:)=[];
% YFalling(~isnan(removeID),:)=[];
% 
% ZInteracting(~isnan(removeID),:)=[];
% XInteracting(~isnan(removeID),:)=[];
% YInteracting(~isnan(removeID),:)=[];


[VZZ] = gradient(ZZ);
[VXX] = gradient(XX);
[VYY] = gradient(YY);

Colors = {'r','b','g','m','c','k'};
% %% Center in x-y- plane
figure(1)
clf
tiledlayout(1,2,'TileSpacing','Compact');

nexttile

for balloon=1:cols
    x0 = 0;
    y0 = nanmean(ZZ(:,balloon));
    ra = 2*sqrt(nanvar(XX(:,balloon)));
    rb = 2*sqrt(nanvar(ZZ(:,balloon)));
    hold on
    ellipse(ra,rb,pi,x0,y0,char(Colors(balloon)))
    plot(XX(:,balloon),ZZ(:,balloon),char(Colors(balloon)))
    plot(XFalling(:,balloon),ZFalling(:,balloon),[char(Colors(balloon)),'--'])
end


% 
% plot(XCone,YCone,'k','LineWidth',2);
% plot(-XCone,YCone,'k','LineWidth',2);
% plot([-X0 X0],[Y0 Y0],'k','LineWidth',2);
title('X-Z Plane')
axis equal
grid on
xlim([- 500 500])
ylim([0 2500])
xlabel('x (mm)')
ylabel('z (mm)')
set(gca,'FontSize',18)


nexttile
hold on

for balloon=1:cols
    x0 = 0;
    y0 = nanmean(ZZ(:,balloon));
    ra = 2*sqrt(nanvar(YY(:,balloon)));
    rb = 2*sqrt(nanvar(ZZ(:,balloon)));
    hold on
    ellipse(ra,rb,pi,x0,y0,char(Colors(balloon)))
    plot(YY(:,balloon),ZZ(:,balloon),char(Colors(balloon)))
    plot(YFalling(:,balloon),ZFalling(:,balloon),[char(Colors(balloon)),'--'])
end



% plot(YFalling,ZFalling,'m')
% plot(XCone,YCone,'k','LineWidth',2);
% plot(-XCone,YCone,'k','LineWidth',2);
% plot([-X0 X0],[Y0 Y0],'k','LineWidth',2);
title('Y-Z Plane')
axis equal
grid on
xlim([- 500 500])
ylim([0 2500])
xlabel('y (mm)')
ylabel('z (mm)')
set(gca,'FontSize',18)
% 
% 

figure(2)
clf
% subplot(1,3,1)
t = linspace(0,5*60,length(ZZ(:,1)));

for balloon=1:cols
plot(t,ZZ(:,balloon),char(Colors(balloon)),'LineWidth',1)
hold on
end

plot(t,ZInteracting,'g','LineWidth',3)
plot(t,ZFalling,'m','LineWidth',3)
xlabel('t (s)')
ylabel('z (m)')
set(gca,'FontSize',18)


%Histograms

% 
% inMean = nanmean(ZInteracting(:,1));
% inStd = sqrt(nanvar(ZInteracting(:,1)));
% 
% 
% 
 figure(3)
% hold on
% for balloon=1:cols
%     xvec = 0:20:3000;
%     xvecDist = 0:3000;
%     pd1 = fitdist(ZZ(:,balloon),'kernel');
%     ydist(balloon,:) = pdf(pd1,xvecDist);
%     histogram(ZZ(:,balloon),xvec,'EdgeColor','none','FaceAlpha',0.4,'Normalization','pdf','FaceColor',char(Colors(balloon)))
%     plot(xvecDist,ydist(balloon,:),char(Colors(balloon)),'LineWidth',2)
% end
% 
% areaDist=[];
% for i=1:length(xvecDist)
%     
%     if ydist(1,i) > ydist(2,i) 
%         
%         areaDist(i) = ydist(2,i);
%         
%     else
%         areaDist(i) = ydist(1,i);
%     end
%     
% end
% sum(areaDist)
% 
% ylm = max(max(max(ydist)))*1.25;
% % 
% plot([inMean-inStd inMean-inStd],[0 ylm],'k','LineWidth',2)
% plot([inMean+inStd inMean+inStd],[0 ylm],'k','LineWidth',2)
% 
% ylim([0 ylm])

bv = ones(size(ZFalling));
bv(~isnan(ZInteracting))=2;
bv(~isnan(ZFalling))=3;
tMatrix = zeros([3 3]);

tWindow=40;
BVector=[];
c=1;
for i=(tWindow+1):tWindow:length(bv)
    for j=1:3
        if max(bv((i-tWindow):i,j)==3)==1
            BVector(c,j)=3;
        else
            BVector(c,j)=mode(bv((i-tWindow):i,j));
        end
    end
    c=c+1;
end

for i=2:length(BVector)
    
    for j=3
        
        if BVector(i-1,j)==3
            
                        tMatrix(3,3)=...
                tMatrix(3,3)+1;   
        else
            tMatrix(BVector(i-1,j),BVector(i,j))=...
                tMatrix(BVector(i-1,j),BVector(i,j))+1;
        end
    end
    
end


% figure(3)
% subplot(1,3,2)
% tMatrix = zeros([4 4]);
% 
% tWindow = 30;
% for t = (tWindow+1):length(ZInteracting)
% 
%     
%     %%Old behaviour
%     if max(~isnan(ZInteracting((t-tWindow),:)))
%         bo = sum(~isnan(ZInteracting((t-tWindow),:)))-1;
%     elseif max(~isnan(ZFalling((t-tWindow),:)))
%         bo = 4;
%     else
%         bo = 3;
%     end
%     
%     %%Current behaviour
%     if max(~isnan(ZInteracting((t),:)))
%         bc = sum(~isnan(ZInteracting((t),:)))-1;
%     elseif max(~isnan(ZFalling((t),:)))
%         bc = 4;
%     else
%         bc = 3;
%     end
%     
%     if bo == 4 || max(max(~isnan(ZFalling((t-tWindow):t,:))))
%         bc = 4;
%     end
%     
%     
%     
%     tMatrix(bo,bc) = tMatrix(bo,bc)+1;
% 
% end

tMatrix( ~any(tMatrix,2), : ) = [];
tMatrix(:, ~any(tMatrix,1) ) = [];

mc = dtmc(tMatrix);
% 
% if length(tMatrix)==4
%     stateNames = ["I 1" "I 2" "Stable" "Falling"];
% elseif length(tMatrix)==3
%     stateNames = ["Interaction" "Stable" "Falling"];
% else
%         stateNames = ["Stable" "Falling"];
% end

stateNames = ["Stable" "Interaction" "Falling"];

mc.StateNames = stateNames;

h=graphplot(mc, 'LabelEdges', true,'ColorEdges',false);
h.LineWidth = 3;
h.MarkerSize = 15;
h.ArrowSize = 20;
h.EdgeFontSize = 18;
h.NodeFontSize = 18;
h.EdgeAlpha = 1;
% dynamicTimeWarping;
