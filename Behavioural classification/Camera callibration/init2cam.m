imaqreset
vid = videoinput('winvideo', 1, 'MJPG_480x270');
src = getselectedsource(vid);
triggerconfig(vid, 'manual');
vid.FramesPerTrigger = 1;
vid.TriggerRepeat = Inf;


vid1 = videoinput('winvideo', 3, 'MJPG_480x270');
src = getselectedsource(vid1);
triggerconfig(vid1, 'manual');
vid1.FramesPerTrigger = 1;
vid1.TriggerRepeat = Inf;


close all
preview(vid)
preview(vid1)