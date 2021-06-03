idx = 5;
yl = 0.05;

% idx = 1;
% yl = 0.25;

ftsize=20;

tiledlayout(3,3,'TileSpacing','Compact');

%%
nexttile
data = smoothedData_A_22_00;
data = processData(data,idx);

cla
pd = fitdist(data(1,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

hold on

pd = fitdist(data(2,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

legend('0 g','0 g')

set(gca,'xticklabel',{[]})
set(gca,'FontSize',ftsize) 



ylabel({['No. Balloons = ',num2str(2)],'Prob. Density'},'FontSize',20)

%%
nexttile
data = smoothedData_A_22_33
data = processData(data,idx);

cla
pd = fitdist(data(1,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

hold on

pd = fitdist(data(2,:)','kernel');

if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);
legend('3 g','3 g')

set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})
set(gca,'FontSize',ftsize) 

%%
nexttile
data = smoothedData_A_22_13
data = processData(data,idx);

cla
pd = fitdist(data(1,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

hold on

pd = fitdist(data(2,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);
set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})
set(gca,'FontSize',ftsize) 

legend('1 g','3 g')

%%
nexttile
data = smoothedData_A_22_000;
data = processData(data,idx);

cla
pd = fitdist(data(1,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

hold on

pd = fitdist(data(2,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

pd = fitdist(data(3,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

legend('0 g','0 g','0 g')

set(gca,'xticklabel',{[]})
set(gca,'FontSize',ftsize) 

ylabel({['No. Balloons = ',num2str(3)],'Prob. Density'},'FontSize',20)


%%
nexttile
data = smoothedData_A_22_333;
data = processData(data,idx);

cla
pd = fitdist(data(1,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

hold on

pd = fitdist(data(2,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

pd = fitdist(data(3,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

legend('3 g','3 g','3 g')

set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})
set(gca,'FontSize',ftsize) 

%%
nexttile
data = smoothedData_A_22_135;
data = processData(data,idx);

cla
pd = fitdist(data(1,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

hold on

pd = fitdist(data(2,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

pd = fitdist(data(3,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

legend('1 g','3 g','5 g')

set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})
set(gca,'FontSize',ftsize) 

%%
nexttile
data = smoothedData_A_22_0000;
data = processData(data,idx);

cla
pd = fitdist(data(1,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

hold on

pd = fitdist(data(2,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

pd = fitdist(data(3,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

pd = fitdist(data(4,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);
if idx == 5; xlabel('z (pixels)'); else xlabel('x (pixels)'); end

legend('0 g','0 g','0 g','0 g')


set(gca,'FontSize',ftsize) 

ylabel({['No. Balloons = ',num2str(4)],'Prob. Density'},'FontSize',20)


%%
nexttile
data = smoothedData_A_22_3333;
data = processData(data,idx);

cla
pd = fitdist(data(1,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

hold on

pd = fitdist(data(2,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

pd = fitdist(data(3,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

pd = fitdist(data(4,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);
set(gca,'yticklabel',{[]})
if idx == 5; xlabel('z (pixels)'); else xlabel('x (pixels)'); end

legend('3 g','3 g','3 g','3 g')

set(gca,'FontSize',ftsize) 
%%
nexttile
data = smoothedData_A_22_1357;
data = processData(data,idx);

cla
pd = fitdist(data(1,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

hold on

pd = fitdist(data(2,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

pd = fitdist(data(3,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);

pd = fitdist(data(4,:)','kernel');
if idx == 5; x=0:1:300; else x = -75:1:75; end
y = pdf(pd,x);
plot(x,y,'lineWidth',2); ylim([0 yl]);
set(gca,'yticklabel',{[]})
if idx == 5; xlabel('z (pixels)'); else xlabel('x (pixels)'); end
set(gca,'FontSize',ftsize) 

legend('1 g','3 g','5 g', '7 g')


function data = processData(data,idx)

data = data(idx:(idx+3),:);
if idx == 5
data = data-50;
data = data(:,min(data)>50);
else
    
   for i=1:4
   data(i,:) = data(i,:)-mean(mean(data(i,:)));
   end
end



end