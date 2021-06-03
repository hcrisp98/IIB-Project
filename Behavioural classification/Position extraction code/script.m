start(vid)

images={};
dt=[];
locations=[];
t=[];
pwm=[];


i=1;
pwmval=0.22;
writePosition(fan,pwmval)
pause(5)

tic
alive = 1;
tfinish = 300;

while alive && toc<tfinish
    
    
%    pwmval =  0.1+(toc/tfinish*(0.3-0.1)) %;
%    pwmval =  0.135+ ((sin(toc/1.5)+1)/2)*0.05;
    writePosition(fan,pwmval)
    trigger(vid)
    images{i}=getdata(vid);
    t(i)=toc;
    locations(:,:,i) = findCentroids(images{i},15);
    pwm(i)=pwmval;
    
    %     height = -locations(:,1,i)+459;
    % if min(height)<40
    %     alive = 0;
    % end
%     
    imshow(images{i})
    hold on
    scatter(locations(1,1,i),locations(1,2,i),'r','filled')
    scatter(locations(2,1,i),locations(2,2,i),'g','filled')
    scatter(locations(3,1,i),locations(3,2,i),'b','filled')
    scatter(locations(4,1,i),locations(4,2,i),'y','filled')
    scatter(locations(5,1,i),locations(5,2,i),'m','filled')
    drawnow
    
    i=i+1;
    
end


writePosition(fan,0)

stop(vid)


% 
% pRed = smoothdata(fillmissing(-squeeze(locations(1,1,:))+459,'spline'),'gaussian',5); %, -squeeze(locations(1,2,:))+459]);
% pGreen = smoothdata(fillmissing(-squeeze(locations(2,1,:))+459,'spline'),'gaussian',5);
% pBlue = smoothdata(fillmissing(-squeeze(locations(3,1,:))+459,'spline'),'gaussian',5);
% pYellow = smoothdata(fillmissing(-squeeze(locations(4,1,:))+459,'spline'),'gaussian',5);
% pOrange = smoothdata(fillmissing(-squeeze(locations(5,1,:))+459,'spline'),'gaussian',5);
% 
% colours= [pRed pGreen pBlue pYellow pOrange] 
% 
% subplot(1,2,1)
% hold on
% plot(t,pRed,'r')
% plot(t,pGreen,'r')
% plot(t,pBlue,'b')
% plot(t,pYellow,'g')
% plot(t,pOrange,'c')
% ylabel('Relative Height above Fan, pixels')
% xlabel('Time, seconds')
% title('Trajectories for 4 Balloons at Fan Power 0.22 for masses 2, 3, 4 and 5')
% ylim([0 250])
% 
% subplot(1,2,2)
% hold on
% plot(pRed,gradient(pRed),'r')
% plot(pGreen,gradient(pGreen),'r')
% plot(pBlue,gradient(pBlue),'b')
% plot(pYellow,gradient(pYellow), 'g')
% plot(pOrange,gradient(pOrange),'c')
% xlabel('Relative Height above Fan, pixels')
% ylabel('Velocity, pixels per second')
% title('Phase Space Diagram for 4 Balloons of masses 2, 3, 4 and 5')
% xlim([0 250])
% ylim([-100 100])