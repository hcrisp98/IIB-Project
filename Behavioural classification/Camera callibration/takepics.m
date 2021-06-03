% start(vid)
% start(vid1)
close all
preview(vid)
preview(vid1)

for i=1:100
    trigger(vid);
    trigger(vid1);
    
    im1=getdata(vid);
    im2=getdata(vid1);
    
    imwrite(im1,['a',num2str(i),'.png']);
    imwrite(im2,['b',num2str(i),'.png']);
    disp('wait')
    pause
    clc
    
end
    