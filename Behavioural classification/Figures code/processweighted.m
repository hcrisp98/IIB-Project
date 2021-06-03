
% clear all
% close all

load stereoParams
load systematicData
load smoothedData_B_20_33

% clf
A318=smoothedData_A_18_135;
B318=smoothedData_B_18_135;

A218=smoothedData_A_20_135;
B218=smoothedData_B_20_135;

A118=smoothedData_A_22_135;
B118=smoothedData_B_22_135;


A322=smoothedData_A_22_333;
B322=smoothedData_B_22_333;
A222=smoothedData_A_22_33;
B222=smoothedData_B_22_33;
A122=smoothedData_A_22_3;
B122=smoothedData_B_22_3;


figure(1)
clf
tiledlayout(2,3,'TileSpacing','compact')



figure(2)
clf

tiledlayout(1,2,'TileSpacing','compact')

for plt=1:2

    if plt==1
        DataA=A318;
        DataB=B318;
        nb = 3;
        ID = [1 2 3];
%     elseif plt==2
%         DataA=A218;
%         DataB=B218;
%         nb = 3;
        ID = [1 2 3];
    elseif plt==2
        DataA=A118;
        DataB=B118;
        nb = 3;
        ID = [1 2 3];
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
    
    if 1
        markovDiagramweighted;
        
        
        figure(1)
        
        
        masses = [4 6 8];
        for i=1:cls
            nexttile
            G=graphs{i};
            h=plot(G,'Layout','circle','NodeColor','r','LineWidth',3,'EdgeLabel',G.Edges.Weight);
            h.EdgeCData=str2num(char(h.EdgeLabel));
            h.ArrowSize=20;
            h.EdgeAlpha=0.75;
            h.NodeFontSize=22;
            h.EdgeFontSize=25;
            h.EdgeFontWeight='bold';
            h.MarkerSize=10;
            h.EdgeLabel( ~or(TT{i}==4, SS{i}==TT{i}) )={''};
            colormap cool % select color palette
            xlim([-2.5 2.5])
            ylim([-2.5 2.5])
            
            if plt<2
            title(['Balloon mass = ',num2str(masses(i)),'g'],'FontSize',35,'FontWeight','normal')
            end
            
            if i==1
                if plt ==1
                    ylabel('Low Power','FontSize',35)
                else
                    ylabel('High Power','FontSize',35)
                end
            end
            
        end
    end
%     set(gca,'FontSize',20)
    
       
% 
%     
%     if plt==1
%         ylabel('Low power','FontSize',20)
%     elseif plt ==4
%         ylabel('High power','FontSize',20)
%     end
    
    figure(2)
    nexttile
     
    plotTrajectories
    
    
    if plt == 1
        title('Low power','FontSize',15,'FontWeight','normal')
    else
         title('High power','FontSize',15,'FontWeight','normal')
    end
    
    if plt==1
        
        
        ylabel({'z (mm)'},'FontSize',20)
        
        yticks([-650 -450 -250  0  500  1000 1500  2000  2500])
        yticklabels({'Balloon 3','Balloon 2','Balloon 1' ,'0' ,'500' ,'1000', '1500', '2000', '2500'})
        
        
    elseif plt ==4
        ylabel({'High power','z (mm)'},'FontSize',20)
        
  yticks([-650 -450 -250  0  500  1000 1500  2000  2500])
        yticklabels({'Balloon 3','Balloon 2','Balloon 1' ,'0' ,'500' ,'1000', '1500', '2000', '2500'})
        
        
    else
        yticks()
        yticklabels({''})
    end
    set(gca,'FontSize',20)
   
end


   
    y=[-200 -200 -375 -375]*100000;
    x = [1 2 2 1] * 10000;
    
    p1=patch(x,y,'k','FaceColor','k','EdgeColor','k',...
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
c.FontSize = 25;
c.Label.FontSize = 25;