clear all

a=arduino();

clear fan
fan = servo(a, 'D3', 'MinPulseDuration',1000*10^-6, 'MaxPulseDuration', 2000*10^-6);

writePosition(fan,0)

disp('turn on power then hit enter ')
pause

writePosition(fan,0)



