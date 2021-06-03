bvplot = ones(size(ZFalling))*2;
bvplot(~isnan(ZInteracting))=1;
if length(ZInteracting(1,:))==3
    bvplot(~isnan(sum(ZInteracting,2)),:)=3;
end
bvplot(~isnan(ZFalling))=4;

bvplot(and(bvplot==1,bvplot==3))

tWindow=30;
BVector=[];
c=1;

[rws,cls]=size(bvplot);

for i=(tWindow+1):tWindow:rws
    for j=1:cls
        if max(bvplot((i-tWindow):i,j)==4)==1
            BVector(c,j)=4;
        else
            BVector(c,j)=mode(bvplot((i-tWindow):i,j));
        end
    end
    
    if max(BVector(c,:)==3)>0
    BVector(c,BVector(c,:)==1)=3;
    end
    
   if max(BVector(c,:)==4)>0
    BVector(c,BVector(c,:)==3)=1;
    end
    
    
    c=c+1;
end

bvplot=BVector;

% bvplot(sum(bvplot==4,2)>0,:)=4;

spacing = 0.024*length(ZZ)/length(bvplot);


YYY = [-200 -200 -375 -375; -400 -400 -575 -575; -600 -600 -775 -775];


for ii=1:length(bvplot)
    
    
    for jj=1:cls
        i=(ii-1)*spacing;
        y=YYY(jj,:);
        if bvplot(ii,jj)==3
            x = [i i+spacing i+spacing i];
            hold on
            patch(x,y,'k','FaceColor','k','EdgeColor','k',...
                'FaceAlpha',1,'EdgeAlpha',0.5)
        elseif bvplot(ii,jj)==1
            x = [i i+spacing i+spacing i];
            hold on
            patch(x,y,'blue','FaceColor','blue','EdgeColor','blue',...
                'FaceAlpha',1,'EdgeAlpha',0.5)
        elseif bvplot(ii,jj)==4
            x = [i i+spacing i+spacing i];
            hold on
            patch(x,y,'red','FaceColor','red','EdgeColor','red',...
                'FaceAlpha',1,'EdgeAlpha',0.5)
        else
            x = [i i+spacing i+spacing i];
            hold on
            patch(x,y,'green','FaceColor','green','EdgeColor','green',...
                'FaceAlpha',1,'EdgeAlpha',0.5)
        end
    end
    
end



% for ii=1:length(bvplot)
%     
%     i=(ii-1)*spacing;
%     y = [-100 -100 -500 -500];
%     if sum(bvplot(ii,:)==3)>0
%         x = [i i+spacing i+spacing i];
%         hold on
%         patch(x,y,'cyan','FaceColor','cyan','EdgeColor','cyan',...
%             'FaceAlpha',1,'EdgeAlpha',0.5)
%     elseif sum(bvplot(ii,:)==1)>0
%         x = [i i+spacing i+spacing i];
%         hold on
%         patch(x,y,'blue','FaceColor','blue','EdgeColor','blue',...
%             'FaceAlpha',1,'EdgeAlpha',0.5)
%     elseif sum(bvplot(ii,:)==4)>0
%         x = [i i+spacing i+spacing i];
%         hold on
%         patch(x,y,'red','FaceColor','red','EdgeColor','red',...
%             'FaceAlpha',1,'EdgeAlpha',0.5)
%     else
%         x = [i i+spacing i+spacing i];
%         hold on
%         patch(x,y,'green','FaceColor','green','EdgeColor','green',...
%             'FaceAlpha',1,'EdgeAlpha',0.5)
%     end
%     
%     
% end

% plot(linspace(0,300,length(ZZ)),ZZ)
plot((1:length(ZZ))*0.0240,ZZ,'LineWidth',2);
% 
% yticks([-350 -250 -150 0 250 500 750 1000 1250 1500 1750 2000])
% yticklabels({'Interacting 2','Interacting 1', 'Falling' ,'0' ,'250' ,'500' ,'750' ,'1000' ,'1250', '1500', '1750', '2000'})


box on
ylim([-800 2500])
xlim([0 240])
