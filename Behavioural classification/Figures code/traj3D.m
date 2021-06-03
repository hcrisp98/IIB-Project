
X=[];
Y=[];
Z=[];

L = min([length(DataA(1,:)),length(DataB(1,:))]);
idt = 1:L;

c=1;
for id=ID
     
    
    ZA = DataA(id+4,idt) ;
    ZB = DataB(id+4,idt) ;
    
    XA = DataA(id,idt) ;
    XB = DataB(id,idt) ;
    
    XA = fillmissing(XA,'previous');
    ZA = fillmissing(ZA,'previous');
    XB = fillmissing(XB,'previous');
    ZB = fillmissing(ZB,'previous');
    
    if id==1
        
        [r,idx,idy] = dtw(ZA,ZB);
        L = min([length(idx),length(idy)]);
        idx = idx(1:L);
        idy = idy(1:L);
    end
    
    T=extract3D(XA(idx),ZA(idx),XB(idy),ZB(idy),stereoParams);
    
    X(:,c)=T(:,1);
    Y(:,c)=T(:,2);
    Z(:,c)=T(:,3);
    
    c=c+1;
end


allignment = [];
for theta1 = -15:15
    for theta2 = -15:15
        
        means = [];
        for balloon=1:length(X(1,:))
            
            worldPoints = [X(:,balloon), Y(:,balloon), Z(:,balloon)];
            
            %X-Z plane, rotation about Y
            theta = deg2rad(theta1);
            worldPoints = worldPoints*([1 0 0; 0 cos(theta) -sin(theta); 0 sin(theta) cos(theta)]);
            
            %Y-Z playe, rotation about X
            theta = deg2rad(theta2);
            worldPoints = worldPoints*([cos(theta) 0 sin(theta); 0 1 0; -sin(theta) 0 cos(theta)]);
            
            means =  var(worldPoints(:,1)) + var(worldPoints(:,2));% mean(worldPoints(:,1)+worldPoints(:,2));
        end
        
        allignment(end+1,:) = [theta1 theta2 mean(means)];
        
    end
end

[val,loc] = min(allignment(:,3));
theta1 = allignment(loc,1);
theta2 = allignment(loc,2);

VX=[];
VY=[];
VZ=[];

for balloon=1:length(X(1,:))
    
    worldPoints = [X(:,balloon), Y(:,balloon), Z(:,balloon)];
    
    %X-Z plane, rotation about Y
    theta = deg2rad(theta1);
    worldPoints = worldPoints*([1 0 0; 0 cos(theta) -sin(theta); 0 sin(theta) cos(theta)]);
    
    %Y-Z playe, rotation about X
    theta = deg2rad(theta2);
    worldPoints = worldPoints*([cos(theta) 0 sin(theta); 0 1 0; -sin(theta) 0 cos(theta)]);
    
    X(:,balloon) = worldPoints(:,1);
    Y(:,balloon) = worldPoints(:,2);
    Z(:,balloon) = worldPoints(:,3);
    
    VX(:,balloon) = gradient(worldPoints(:,1));
    VY(:,balloon) = gradient(worldPoints(:,2));
    VZ(:,balloon) = gradient(worldPoints(:,3));
    
end

X=X-mean(X);
Y=Y-mean(Y);
Y=Y*1.2;

originPoints = [0 0 0];

%Cone
%Old 
Y0=205;
X0=100;
ConeAngle = deg2rad(75);

% Y0=50;
% X0=100;
% ConeAngle = deg2rad(45);

XCone=(0:1000);
YCone=XCone*tan(ConeAngle) + Y0;
XCone = XCone+X0;