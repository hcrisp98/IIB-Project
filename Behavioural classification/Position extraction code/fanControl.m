
a=arduino()

clear fan
fan = servo(a, 'D3', 'MinPulseDuration',1000*10^-6, 'MaxPulseDuration', 2000*10^-6);

writePosition(fan,0)

disp('turn on power then hit enter ')
pause



writePosition(fan,0)

% 
% for i=linspace(0.13,0.3,20)
% writePosition(fan,i)
% pause(0.3)
% i
% end
% 
% writePosition(fan,0)
% pause(0.7)
% writePosition(fan,0.15)