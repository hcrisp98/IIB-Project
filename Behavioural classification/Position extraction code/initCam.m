% imaqreset
% vid = videoinput('winvideo', 1, 'MJPG_1280x720');
% src = getselectedsource(vid);
% 
% 
% src.BacklightCompensation = 'off';
% src.FocusMode = 'manual';
% src.WhiteBalanceMode = 'manual';
% vid.LoggingMode = 'disk';
% % src.Exposure = -5;
% src.FrameRate = '60.0002';
% 
% diskLogger = VideoWriter('C:\Users\BIRL\Desktop\balloon\movie1.mp4', 'MPEG-4');
% vid.DiskLogger = diskLogger;
% 
% triggerconfig(vid, 'manual');
% vid.FramesPerTrigger = Inf;
% 
% 
% disp('init done')
% 

imaqreset
vid = videoinput('winvideo', 1, 'MJPG_480x270');
src = getselectedsource(vid);
triggerconfig(vid, 'manual');
vid.FramesPerTrigger = 1;
vid.TriggerRepeat = Inf;
