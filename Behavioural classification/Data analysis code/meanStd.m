% PLOTS MEAN AND VARIANCE FOR HEIGHT AND VELOCITY

fanPower = [131 141 151 160 170];
zPosition2G = [greenFilled1312 greenFilled1412 greenFilled1512 greenFilled1602 greenFilled1702];
%zPosition1 = [greenFilled1311 greenFilled1411 greenFilled1511 greenFilled1601 greenFilled1701];
zPosition2B = [blueFilled1312 blueFilled1412 blueFilled1512 blueFilled1602 blueFilled1702];
meanHeight2G = mean(zPosition2G);
meanHeight2B = mean(zPosition2B);
%meanHeight1 = mean(zPosition1);
stdHeight2G = std(zPosition2G);
stdHeight2B = std(zPosition2B);
%stdHeight1 = std(zPosition1);

velocity2G = gradient(zPosition2G);
velocity2B = gradient(zPosition2B);
%velocity1 = gradient(zPosition1);
meanVelocity2G = mean(velocity2G);
meanVelocity2B = mean(velocity2B);
%meanVelocity1 = mean(velocity1);
stdVelocity2G = std(velocity2G);
stdVelocity2B = std(velocity2B);
%stdVelocity1 = std(velocity1);

hold on
grid on
errorbar(fanPower,meanVelocity2G,stdVelocity2G, 'g');
%errorbar(fanPower,meanVelocity2B,stdVelocity2B, 'b');
hold off

xlim([120 180]);
ylim([-250 250]);
title('Mean Balloon Velocity vs Fan Power for the 1 Balloon Case');
xlabel('Fan Power');
ylabel('Mean Velocity, pixels per frame');