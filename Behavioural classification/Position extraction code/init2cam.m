imaqreset
vid = videoinput('winvideo', 1, 'MJPG_480x270');
src = getselectedsource(vid);
triggerconfig(vid, 'manual');
vid.FramesPerTrigger = Inf;
vid.TriggerRepeat = Inf;
vid.LoggingMode = 'disk&memory';

vid1 = videoinput('winvideo', 3, 'MJPG_480x270');
src = getselectedsource(vid1);
triggerconfig(vid1, 'manual');
vid1.FramesPerTrigger = Inf;
vid1.TriggerRepeat = Inf;
vid1.LoggingMode = 'disk&memory';


close all
preview(vid)
preview(vid1)