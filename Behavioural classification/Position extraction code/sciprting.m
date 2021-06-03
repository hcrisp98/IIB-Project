% init;

fanMin = 0.15;
fanMax = 0.25;


for i = [0.1505    0.1603    0.1700] % linspace(fanMin,fanMax,5)
    
diskLogger = VideoWriter(['3_',num2str(round(i*1000))], 'MPEG-4');
vid.DiskLogger = diskLogger;
diskLogger.FrameRate = 30;

start(vid);

% writePosition(fan,i)
disp(i)
pause(1)

trigger(vid);
pause(1)
stop(vid);

writePosition(fan,0.131)
pause(10)


end