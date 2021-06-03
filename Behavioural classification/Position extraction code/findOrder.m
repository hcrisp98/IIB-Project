function [ordered]= findOrder(trajectory, balloonNo, masses, fanPower, filename)

colours= [trajectory(5,:); trajectory(6,:); trajectory(7,:); trajectory(8,:)];

correctOrder = colours(1,:) > colours(2,:) & colours(2,:) > colours(3,:) & colours(3,:) > colours(4,:);

% detects amount of time in stable config
idx = find(diff([false;correctOrder(:);false]));
ida = idx(1:2:end);                            % extracts times in correct order
idb = idx(2:2:end);                            % extracts times in wrong order
dur = idb-ida;                                % duration of times in correct order
freqOrdered= nnz(dur);                          % number of times in correct order
fracTotalTime= sum(dur)/length(colours)*100;

ordered= [fracTotalTime; freqOrdered; dur];


trajectory= trajectory/187.5;
x= 1:8999;
x= x/30;

title1= 'Smoothed Height Trajectories of ';
title2= ' Unequally Weighted Balloons, of Mass ';
title3= ', on Fan Power ';
title4= ', Indicating Locations of Self-Organisation';
titles= strcat(title1, balloonNo, title2, masses, title3, fanPower, title4);

clf 
figure(1)
ylim([0 2.5])
xlim([0 300])
title(titles)
xlabel('Time, seconds')
ylabel('Height Above Fan, meters')

hold on

plot(x, trajectory(5,:), 'r:')
plot(x, trajectory(6,:), 'g:')
plot(x, trajectory(7,:), 'b:')
plot(x, trajectory(8,:), 'y:')

for i=1:length(ida)
    plot(x(ida(i):ida(i)+dur(i)-1), trajectory(5,ida(i):ida(i)+dur(i)-1), 'r')
    plot(x(ida(i):ida(i)+dur(i)-1), trajectory(6,ida(i):ida(i)+dur(i)-1), 'g')
    plot(x(ida(i):ida(i)+dur(i)-1), trajectory(7,ida(i):ida(i)+dur(i)-1), 'b')
    plot(x(ida(i):ida(i)+dur(i)-1), trajectory(8,ida(i):ida(i)+dur(i)-1), 'y')
end

hold off

saveas(gcf, filename);

