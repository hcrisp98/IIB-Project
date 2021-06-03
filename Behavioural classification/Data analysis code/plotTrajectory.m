function []= plotTrajectory(trajectory, balloonNoStr, masses, fanPower, filename);

title1= 'Smoothed Height Trajectories of ';
title5= 'Smoothed Height Trajectory of ';
title4= ' Weighted Balloon, of Mass ';
title2= ' Unequally Weighted Balloons, of Mass ';
title3= ', on Fan Power ';
space= ' ';
balloonNo= str2double(balloonNoStr);

titles= strcat(title1, balloonNoStr, title2, masses, title3, fanPower);

clf
figure(1)
x=1:8999;
x=x/30;
%trajectory=trajectory/187.5;

if balloonNo==1;
    plot(x,trajectory,'r');
    ylim([0 3])
    xlim([0 300])
    titles= strcat(title5, space, balloonNoStr, title4, masses, title3, fanPower);
    titles='Low Power';
    title(titles)
    xlabel('Time (s)')
    ylabel('z (m)')
    saveas(gcf, filename)
elseif balloonNo==2;
    hold on
    plot(x,trajectory(:,3),'r');
    plot(x,trajectory(:,6),'g');
    hold off
    ylim([0 2.5])
    xlim([0 300])
    title(titles)
    xlabel('Time, seconds')
    ylabel('Height Above Fan, meters')
    saveas(gcf, filename)
elseif balloonNo==3;
    hold on
    plot(x,trajectory(5,:),'r');
    plot(x,trajectory(6,:),'g');
    plot(x,trajectory(7,:),'b');
    hold off
    ylim([0 2.5])
    xlim([0 300])
    title(titles)
    xlabel('Time, seconds')
    ylabel('Height Above Fan, meters')
    saveas(gcf, filename)
elseif balloonNo==4;
    hold on
    plot(x,trajectory(:,3),'r');
    plot(x,trajectory(:,6),'g');
    plot(x,trajectory(:,9),'b');
    plot(x,trajectory(:,12),'y');
    hold off
    ylim([0 2])
    xlim([0 300])
    title(titles)
    xlabel('Time, seconds')
    ylabel('Height Above Fan, meters')
    saveas(gcf, filename)
end
    
end