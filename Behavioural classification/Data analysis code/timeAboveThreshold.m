function [this,durationAboveThreshold, locationAbove, locationFalling]= timeAboveThreshold(trajectoryGreen, trajectoryBlue, threshold)

stable = (trajectoryGreen > threshold) & (trajectoryBlue > threshold);                  % detects amount of time spent above a threshold
idx = find(diff([false;stable(:);false]));
idb = idx(1:2:end);                            % extracts times above threshold
ide = idx(2:2:end);                            % extracts times below threshold
idy = (ide-idb)>=300;                          % finds number of times its above threshold for >= 10 frames
occassionsAboveThreshold= nnz(idy)             % number of times above threshold
durationAboveThreshold= (ide(idy)-idb(idy))/30   % durations of times above threshold

this = mean(durationAboveThreshold)/30;

locationAbove= idb(idy)/30
locationFalling= ide(idy)/30

% histogram(durationAboveThreshold, 20)    % plots the histogram of height
% title('Histogram of Time Duration Spent Above Falling Threshold for the 2 Balloon Case');
% xlabel('Duration Spent Above Funnel, frames');
% ylabel('Percentage of Total Time Spent Above Threshold');

clf
hold on
plot(trajectoryBlue, 'b')
ylim([0 3]);
plot(trajectoryGreen, 'g')
plot(locationAbove, 175, '^r')
plot(locationFalling, 175, 'vr')

end