function []=phaseSpace(position, filename, balloonNo, fanPower);

title1= 'Phase Space Trajectory of ';
title2= ' Unequally Weighted Balloons, of Mass 1 and 5, on Fan Power ';

titles= strcat(title1, balloonNo, title2, fanPower)
titles= '3g'

clf

%position=position/187.5;
velocity= gradient(position);
velocity= velocity*30;

colour= ['r' 'g' 'b' 'y'];

hold on

for i=1
    plot(position, velocity, colour(1))
    title(titles);
    xlabel('z (m)');
    ylabel('dz/dt (m/s)');
    xlim([0 3])
    ylim([-3 3])
    saveas(gcf, filename)
end

end