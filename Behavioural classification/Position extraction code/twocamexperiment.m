diskLogger = VideoWriter('C:\Users\BIRL\Desktop\balloon\experimental stuff\A_18_1357.mp4', 'MPEG-4');
vid.DiskLogger = diskLogger;

diskLogger = VideoWriter('C:\Users\BIRL\Desktop\balloon\experimental stuff\B_18_1357.mp4', 'MPEG-4');
vid1.DiskLogger = diskLogger;


start(vid)
start(vid1)

writePosition(fan,0.18)
pause(10)

tic

trigger(vid)
trigger(vid1)

tfinish= 300

while toc<tfinish
    toc
end

writePosition(fan,0)

stop(vid)
stop(vid1)