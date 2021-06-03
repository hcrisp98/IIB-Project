clear all

a=arduino()

clear fan
fan = servo(a, 'D3', 'MinPulseDuration',1000*10^-6, 'MaxPulseDuration', 2000*10^-6);

writePosition(fan,0)

disp('turn on power then hit enter ')
pause



writePosition(fan,0)

imaqreset
vid = videoinput('winvideo', 1, 'MJPG_1280x720');
src = getselectedsource(vid);


src.BacklightCompensation = 'off';
src.FocusMode = 'manual';
src.WhiteBalanceMode = 'manual';
vid.LoggingMode = 'disk';
src.Exposure = -4;
src.FrameRate = '60.0002';

diskLogger = VideoWriter('C:\Users\BIRL\Desktop\balloon\movie1.mp4', 'MPEG-4');
vid.DiskLogger = diskLogger;

triggerconfig(vid, 'manual');
vid.FramesPerTrigger = Inf;


disp('init done')
