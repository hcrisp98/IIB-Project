
trajectory= lifecycles_18_13;

s=0
m=0
l=0

for i=1:length(trajectory)
    if length(trajectory{i, 1})>30
        l=l+1;
    elseif length(trajectory{i,1})>10
        m=m+1;
    else
        s=s+1;
    end
end   
    
lifecycles18 = [s; m; l];

trajectory= lifecycles_20_13;

s=0
m=0
l=0

for i=1:length(trajectory)
    if length(trajectory{i, 1})>30
        l=l+1;
    elseif length(trajectory{i,1})>10
        m=m+1;
    else
        s=s+1;
    end
end   
    
lifecycles20 = [s; m; l];

trajectory= lifecycles_22_13;

s=0
m=0
l=0

for i=1:length(trajectory)
    if length(trajectory{i, 1})>30
        l=l+1;
    elseif length(trajectory{i,1})>10
        m=m+1;
    else
        s=s+1;
    end
end   
    
lifecycles22 = [s; m; l];

lifecycles = [lifecycles18 lifecycles20 lifecycles22]
fanPower= [0.18 0.20 0.22];

b= bar(fanPower, lifecycles', 'stacked');
title('Lifecycle length classification');
xlabel('Fan Power');
ylabel('Number of lifecycles');
legend('Short', 'Medium', 'Long');
ylim([0 50]);