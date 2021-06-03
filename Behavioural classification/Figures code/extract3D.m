function [T] = extract3D(XA,ZA,XB,ZB,stereoParams)
Z1 = ZA ;
Z2 = ZB ;

X1 = XA;
X2 = XB ;

%Origins
OpA = [448 134];
OpB = [467 137];
% 

T1 = [480-Z1; 480-X1]';
T2 = [480-Z2; 480-X2]';

%% Undistort image points
% T1=undistortPoints(T1,stereoParams.CameraParameters1);
% T2=undistortPoints(T2,stereoParams.CameraParameters2);
% 
% OpA=undistortPoints(OpA,stereoParams.CameraParameters1);
% OpB=undistortPoints(OpB,stereoParams.CameraParameters2);

[val, originidx] = max(T1(:,1));

%% Convert to world points
worldPoints = triangulate(T1,T2,stereoParams);

originPoints = triangulate(OpA,OpB,stereoParams);



I = imread('a49.png');
[I,newOrigin] = undistortImage(I,stereoParams.CameraParameters1);

[imagePoints,boardSize] = detectCheckerboardPoints(I);

squareSize = 59.4;
checkPoints = generateCheckerboardPoints(boardSize, squareSize);

imagePoints = [imagePoints(:,1) + newOrigin(1), ...
              imagePoints(:,2) + newOrigin(2)];
         

[rotationMatrix, translationVector] = extrinsics(imagePoints,checkPoints,stereoParams.CameraParameters1);


worldPoints = (worldPoints-translationVector)*pinv(rotationMatrix);
originPoints = (originPoints-translationVector)*pinv(rotationMatrix);


% allignment = []
% for theta1 = -15:15
%     for theta2 = -15:15
%         %X rotation
%         theta = deg2rad(theta1);
%         worldPointsTemp = worldPointsTemp*([1 0 0; 0 cos(theta) -sin(theta); 0 sin(theta) cos(theta)]);
%         
%         %Z rotation
%         theta = deg2rad(theta2);
%         worldPointsTemp = worldPointsTemp*([cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1]);
%     end
% end



%X rotation
theta = deg2rad(-5);
worldPoints = worldPoints*([1 0 0; 0 cos(theta) -sin(theta); 0 sin(theta) cos(theta)]);

%Z rotation
theta = deg2rad(-5);
worldPoints = worldPoints*([cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1]);


%Origin centering
worldPoints(:,1) = worldPoints(:,1) - originPoints(1);
worldPoints(:,2) = worldPoints(:,2) - originPoints(2);
worldPoints(:,3) = worldPoints(:,3) - originPoints(3);

worldPoints(:,2) = -worldPoints(:,2);

X = worldPoints(:,1);
Y = worldPoints(:,3);
Z = worldPoints(:,2);

Z(Z<0)=0;
% X=X-mean(X);
% Y=Y-mean(Y);

X = smoothdata(X,'gaussian',10);
Y = smoothdata(Y,'gaussian',10);
Z = smoothdata(Z,'gaussian',10);

Vx = gradient(X);
Vy = gradient(Y);
Vz = gradient(Z);

T = [X Y Z];

end

