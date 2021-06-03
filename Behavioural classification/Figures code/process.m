
% clear all
% close all

load stereoParams
load systematicData
load smoothedData_B_20_33

% clf
A318=smoothedData_A_18_333;
B318=smoothedData_B_18_333;
A218=smoothedData_A_18_33;
B218=smoothedData_B_18_33;
A118=smoothedData_A_18_3;
B118=smoothedData_B_18_3;

A320=smoothedData_A_20_333;
B320=smoothedData_B_20_333;
A220=smoothedData_A_20_33;
B220=smoothedData_B_20_33;
A120=smoothedData_A_20_3;
B120=smoothedData_B_20_3;


A322=smoothedData_A_22_333;
B322=smoothedData_B_22_333;
A222=smoothedData_A_22_33;
B222=smoothedData_B_22_33;
A122=smoothedData_A_22_3;
B122=smoothedData_B_22_3;

% A318=smoothedData_A_18_000;
% B318=smoothedData_B_18_000;
% A218=smoothedData_A_18_00;
% B218=smoothedData_B_18_00;
% A118=smoothedData_A_18_0;
% B118=smoothedData_B_18_0;
% 
% A320=smoothedData_A_20_000;
% B320=smoothedData_B_20_000;
% A220=smoothedData_A_20_00;
% B220=smoothedData_B_20_00;
% A120=smoothedData_A_20_0;
% B120=smoothedData_B_20_0;
% 
% 
% A322=smoothedData_A_22_000;
% B322=smoothedData_B_22_000;
% A222=smoothedData_A_22_00;
% B222=smoothedData_B_22_00;
% A122=smoothedData_A_22_0;
% B122=smoothedData_B_22_0;

figure(1)
clf

tiledlayout(2,3,'TileSpacing','compact')



figure(2)
clf

tiledlayout(6,1,'TileSpacing','compact')


BarVec = [];

for plt=1:6

    if plt==3
        DataA=A318;
        DataB=B318;
        nb = 3;
        ID = [1 2 3];
    elseif plt==2
        DataA=A218;
        DataB=B218;
        nb = 2;
        ID = [1 2];
    elseif plt==1
        DataA=A118;
        DataB=B118;
        nb = 1;
        ID = 1;        
    elseif plt==6
        DataA=A322;
        DataB=B322;
        nb = 3;
        ID = [1 2 3];
    elseif plt==5
        DataA=A222;
        DataB=B222;
        nb = 2;
        ID = [1 2];
    elseif plt==4
        DataA=A122;
        DataB=B122;
        nb = 1;
        ID = 1;
    end
    
    traj3D
    
    
%     clearvars -except X Y Z VZ VX VY XCone YCone X0 Y0 ConeAngle
    
    
    XX=X;
    YY=Y;
    ZZ=Z;
    
    detectFalling;
    detectInteracting;
    
    ZFallingMarkov=[];
    ZInteractingMarkov=[];
    ZZMarkov = [];
    
    for k=2:length(ZFalling)
        if min(isnan(ZFalling(k,:)))==1
            ZZMarkov(end+1,:)=ZZ(k,:);
            ZFallingMarkov(end+1,:)=ZFalling(k,:);
            ZInteractingMarkov(end+1,:)=ZInteracting(k,:);
        elseif min(isnan(ZFalling(k,:)))==0 && min(isnan(ZFalling(k-1,:)))==1
            ZZMarkov(end+1,:)=ZZ(k,:);
            ZFallingMarkov(end+1,:)=ZFalling(k,:);
            ZInteractingMarkov(end+1,:)=ZInteracting(k,:); 
        end 
    end
    
%     plot(ZInteracting)
    
    markovDiagram;
    
     figure(1)
    nexttile
    
%     h = heatmap(tMatrix);
%     
%     if plt>3
%         h.XLabel = {'Target'};
%         h.XData = {'Stable','Interaction 1','Interaction 2','Falling'};
%     else
%         h.XDisplayLabels = {'',' ','   ','    '};
%     end
%     
%     if plt ==1 ||  plt==4 || plt==7
%         h.YLabel = {'Source'};
%         h.YData = {'Stable','Interaction 1','Interaction 2','Falling'};
%     else
%         h.YDisplayLabels = {'',' ','  ','   '};
%     end
%     
%     colormap winter
%     set(gca,'FontSize',15)
%     colorbar off
%     drawnow
   
    for i=1 %:cls
        G=graphs{i};
        h=plot(G,'Layout','circle','NodeColor','r','LineWidth',3,'EdgeLabel',G.Edges.Weight);
        h.EdgeCData=str2num(char(h.EdgeLabel));
        h.ArrowSize=20;
        h.EdgeAlpha=0.75;
        h.NodeFontSize=20;
        h.EdgeFontSize=15;
        h.MarkerSize=10;
        h.EdgeLabel( ~or(target==4, source==target) )={''};
        colormap cool % select color palette
        xlim([-2.5 2.5])
        ylim([-2.5 2.5])
        axis square
    end
    
    set(gca,'FontSize',20)
    
    if plt < 4
        title(['No. Balloons = ',num2str(plt)],'FontSize',20,'FontWeight','normal')
    end
    
    if plt==1
        ylabel('Low power','FontSize',20)
    elseif plt ==4
        ylabel('High power','FontSize',20)
    end
    
    figure(2)
    nexttile
    
    
    
    plotTrajectories
    title(['No. Balloons = ',num2str(plt)],'FontSize',15,'FontWeight','normal')

    
    if plt<4
        
        ylabel({'Lower power','z (mm)'},'FontSize',17)
        yticks([-650 -450 -250  0  500  1000 1500  2000  2500])
        yticklabels({'Balloon 3','Balloon 2','Balloon 1' ,'0' ,'500' ,'1000', '1500', '2000', '2500'})
        
        
    else
        
        ylabel({'High power','z (mm)'},'FontSize',17)
        
        yticks([-650 -450 -250  0  500  1000 1500  2000  2500])
        yticklabels({'Balloon 3','Balloon 2','Balloon 1' ,'0' ,'500' ,'1000', '1500', '2000', '2500'})
        
    end

   
    if plt==6
        
    else
        
        xticklabels({''})
    end
    
    barCalc;
    
    BarVec(plt,:)=[stable interact1 interact2 falling]; 
    
end



   
    y=[-200 -200 -375 -375]*100000;
    x = [1 2 2 1] * 10000;
    
    p1=patch(x,y,'cyan','FaceColor','yellow','EdgeColor','yello',...
        'FaceAlpha',1,'EdgeAlpha',0.5);
    
    p2=patch(x,y,'blue','FaceColor','blue','EdgeColor','blue',...
        'FaceAlpha',1,'EdgeAlpha',0.5);
    
    p3=patch(x,y,'red','FaceColor','red','EdgeColor','red',...
        'FaceAlpha',1,'EdgeAlpha',0.5);
    
    p4=patch(x,y,'green','FaceColor','green','EdgeColor','green',...
        'FaceAlpha',1,'EdgeAlpha',0.5);
    
  legend([p4 p2 p1 p3],{'Stable','Interact 1','Interact 2','Falling'},...
      'Orientation','horizontal','Location','north')



figure(1)
c = colorbar;
c.Label.String = 'Transition probability (%)';



figure(3)

Y = BarVec;

bar(Y,'stacked')
legend({'Stable','Interact 1','Interact 2','falling'},...
     'Orientation','horizontal','Location','north')


xticks([1 2 3 4 5 6])
xticklabels({'1 Balloon','2 Balloons','3 Balloons',...
    '1 Balloon','2 Balloons','3 Balloons'})

ylabel('Proportion spent in each behavior')
xlabel({'','','System configuration'})
set(gca,'FontSize',18)

