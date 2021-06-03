vid = VideoReader('experimental stuff/A_18_1357.mp4');

frameCount=0;
i=1;
rect= [0, 0, 500, 1200]
frameNo= 100;
fps= 30;

redTrajectory = [];
blueTrajectory = [];
greenTrajectory = [];
yellowTrajectory = [];

diameterStoreR = [];
diameterStoreG = [];
diameterStoreB = [];
diameterStoreY = [];

dThreshL = 15;
dThreshH = 40;


while hasFrame(vid)
    % Read a video frame and detect objects in it.
    
    frameCount = frameCount + 1;
    frame = readFrame(vid);                    % Extract frame from video
    frame = imrotate(frame,-90);
    frame = imcrop(frame, rect);
    
    [redMask,redMaskedRGBImage] = createRedMaskA(frame);        % Apply colour thresholds
    [greenMask,greenMaskedRGBImage] = createGreenMaskA(frame);
    [blueMask,blueMaskedRGBImage] = createBlueMaskA(frame);                       
    [yellowMask,yellowMaskedRGBImage] = createYellowMaskA(frame); 
    
    redMask1 = uint8(redMask);    % Threshold the object areas
    greenMask1 = uint8(greenMask);
    blueMask1 = uint8(blueMask);
    yellowMask1 = uint8(yellowMask);
    smallestAcceptableArea = 100;
    redMask1 = uint8(bwareaopen(redMask1, smallestAcceptableArea));
    greenMask1 = uint8(bwareaopen(greenMask1, smallestAcceptableArea));
    blueMask1 = uint8(bwareaopen(blueMask1, smallestAcceptableArea));
    yellowMask1 = uint8(bwareaopen(yellowMask1, smallestAcceptableArea));
    
	structuringElement = strel('disk', 4);                  % Smooth the borders
	redMask1 = imclose(redMask1, structuringElement);
    greenMask1 = imclose(greenMask1, structuringElement);
    blueMask1 = imclose(blueMask1, structuringElement);
	yellowMask1 = imclose(yellowMask1, structuringElement);
    
	redMask1 = uint8(imfill(redMask1, 'holes'));      % Fill in holes
    greenMask1 = uint8(imfill(greenMask1, 'holes')); 
    blueMask1 = uint8(imfill(blueMask1, 'holes')); 
    yellowMask1 = uint8(imfill(yellowMask1, 'holes'));
    
	redMask1 = cast(redMask1, class(redMask));              % Convert objects Mask to the same data type as r
    greenMask1 = cast(greenMask1, class(greenMask));
    blueMask1 = cast(blueMask1, class(blueMask));
    yellowMask1 = cast(yellowMask1, class(yellowMask));

    
    bboxes= regionprops(redMask1, 'BoundingBox');  % Draw a bounding box around the balloon
    for k=1:length(bboxes)
        CurrBB=bboxes(k).BoundingBox;
        rectangle('Position', [CurrBB(1),CurrBB(2),CurrBB(3),CurrBB(4)], 'EdgeColor', 'r', 'LineWidth', 2)
        s = regionprops(redMask1,'Centroid');
        centroids = cat(1,s.Centroid);
            hold on
        plot(centroids(:,1),centroids(:,2), 'r*')
    end
    
    bboxes= regionprops(greenMask1, 'BoundingBox');    % Draw a bounding box around the balloon
    for k=1:length(bboxes)
        CurrBB=bboxes(k).BoundingBox;
        rectangle('Position', [CurrBB(1),CurrBB(2),CurrBB(3),CurrBB(4)], 'EdgeColor', 'g', 'LineWidth', 2)
        s = regionprops(greenMask1,'Centroid', 'EquivDiameter');
        centroids = cat(1,s.Centroid);
            hold on
        plot(centroids(:,1),centroids(:,2), 'g*')
    end
    
    bboxes= regionprops(blueMask1, 'BoundingBox');    % Draw a bounding box around the balloon
    for k=1:length(bboxes)
        CurrBB=bboxes(k).BoundingBox;
        rectangle('Position', [CurrBB(1),CurrBB(2),CurrBB(3),CurrBB(4)], 'EdgeColor', 'b', 'LineWidth', 2)
        s = regionprops(blueMask1,'Centroid');
        centroids = cat(1,s.Centroid);
            hold on
        plot(centroids(:,1),centroids(:,2), 'b*')
    end
    
    bboxes= regionprops(yellowMask1, 'BoundingBox');    % Draw a bounding box around the balloon
    for k=1:length(bboxes)
        CurrBB=bboxes(k).BoundingBox;
        rectangle('Position', [CurrBB(1),CurrBB(2),CurrBB(3),CurrBB(4)], 'EdgeColor', 'y', 'LineWidth', 2)
        s = regionprops(yellowMask1,'Centroid');
        centroids = cat(1,s.Centroid);
            hold on
        plot(centroids(:,1),centroids(:,2), 'y*')
    end
    
    figure(1)
    imshow(frame)
    
    %%
    bboxes = regionprops(redMask1, 'Centroid','EquivDiameter');
    
    if ~isempty(bboxes)

        diameterStoreR(i)= bboxes(1).EquivDiameter;
        
        if (bboxes(1).EquivDiameter > dThreshL) & (bboxes(1).EquivDiameter < dThreshH)
            redTrajectory(i,:) = 720-bboxes(1).Centroid;
        else
            redTrajectory(i,:) = [NaN NaN];
        end
    else
        redTrajectory(i,:) = [NaN NaN];
        
    end
    
    %%
    bboxes = regionprops(greenMask1, 'Centroid','EquivDiameter');
    
    if ~isempty(bboxes)
        
        diameterStoreG(i)= bboxes(1).EquivDiameter;
        
        if (bboxes(1).EquivDiameter > dThreshL) & (bboxes(1).EquivDiameter < dThreshH)
            greenTrajectory(i,:) = 720-bboxes(1).Centroid;
        else
            greenTrajectory(i,:) = [NaN NaN];
        end
    else
        greenTrajectory(i,:) = [NaN NaN];
        
    end
    
    %%
    bboxes = regionprops(blueMask1, 'Centroid','EquivDiameter');
    
    if ~isempty(bboxes)
        
        diameterStoreB(i)= bboxes(1).EquivDiameter;
        
        if (bboxes(1).EquivDiameter > dThreshL) & (bboxes(1).EquivDiameter < dThreshH)
            blueTrajectory(i,:) = 720-bboxes(1).Centroid;
        else
            blueTrajectory(i,:) = [NaN NaN];
        end
    else
        blueTrajectory(i,:) = [NaN NaN];
        
    end
    
        %%
    bboxes = regionprops(yellowMask1, 'Centroid','EquivDiameter');
    
    if ~isempty(bboxes)
        
        diameterStoreY(i)= bboxes(1).EquivDiameter;
        
        if (bboxes(1).EquivDiameter > dThreshL) & (bboxes(1).EquivDiameter < dThreshH)
            yellowTrajectory(i,:) = 720-bboxes(1).Centroid;
        else
            yellowTrajectory(i,:) = [NaN NaN];
        end
    else
        yellowTrajectory(i,:) = [NaN NaN];
        
    end
    
    i=i+1
    
    if i==frameNo
        break
    end
    
end

%%

% PLOTS RAW AND FILLED IN TRAJECTORIES

% extract just height 
redTrajectory = (redTrajectory(:,2));
redTrajectory= redTrajectory+140
blueTrajectory = (blueTrajectory(:,2));
blueTrajectory= blueTrajectory+140
greenTrajectory = (greenTrajectory(:,2));
greenTrajectory= greenTrajectory+140
yellowTrajectory = (yellowTrajectory(:,2));
yellowTrajectory= yellowTrajectory+140

% Plot original trajectories with missing values
figure(3)
subplot(2,1,1)
hold on
plot(redTrajectory,'r','LineWidth',3)
plot(greenTrajectory,'g','LineWidth',3)
plot(blueTrajectory,'b','LineWidth',3)
plot(yellowTrajectory,'y','LineWidth',3)
drawnow
title('Height Trajectory of 3 Balloons on Fan Power 170')
xlabel('Frame Number')
ylabel('Relative Height Above Fan, pixels')
%ylim([0 800])

%PLot original trajectories with missing values again
subplot(2,1,2)
hold on
plot(redTrajectory,'r','LineWidth',3)
plot(greenTrajectory,'g','LineWidth',3)
plot(blueTrajectory,'b','LineWidth',3)
plot(yellowTrajectory,'y','LineWidth',3)
drawnow
%ylim([0 800])
%xlim([0 500])
title('Smoothed Height Trajectory of 3 Balloons on Fan Power 170')
xlabel('Frame Number')
ylabel('Relative Height Above Fan, pixels')

%Fill and smooth trajectories, then plot over to see filled in parts
smoothMethod = 'makima';

redFilled=(fillmissing(redTrajectory,smoothMethod,'EndValues','none'));
redFilled1703 = smoothdata(redFilled, 'loess');
plot(redFilled1703,'r')

blueFilled=(fillmissing(blueTrajectory,smoothMethod,'EndValues','none'));
blueFilled1703 = smoothdata(blueFilled, 'loess');
plot(blueFilled1703,'b')

greenFilled=(fillmissing(greenTrajectory,smoothMethod,'EndValues','none'));
greenFilled1703 = smoothdata(greenFilled, 'loess');
plot(greenFilled1703,'g')

yellowFilled=(fillmissing(yellowTrajectory,smoothMethod,'EndValues','none'));
yellowFilled1703 = smoothdata(yellowFilled, 'loess');
plot(yellowFilled1703,'y')

hold off

% %%
% 
% % PLOTS HISTOGRAM OF Z POSITION OF BALLOON
% filled1312= [greenFilled1312 blueFilled1312];
% filled1412= [greenFilled1412 blueFilled1412];
% filled1512= [greenFilled1512 blueFilled1512];
% filled1602= [greenFilled1602 blueFilled1602];
% filled1702= [greenFilled1702 blueFilled1702];
% 
% hold on
% histogram(filled1312, 50, 'Normalization', 'probability')            
% title('Histogram of Time Spent at each Relative Height above the Fan for the 2 Balloon Case');
% xlabel('Relative Height Above Fan, pixels');
% ylabel('Normalised Time Spent at Height, %');
% 
% histogram(filled1412, 50, 'Normalization', 'probability') 
% histogram(filled1512, 50, 'Normalization', 'probability') 
% histogram(filled1602, 50, 'Normalization', 'probability') 
% histogram(filled1702, 50, 'Normalization', 'probability') 
% 
% hold off
% %%
% 
% % PLOTS THE TIMES OF ONSET OF BALLOON FALLING
% 
% x = [1:9984]';                           
% y = greenFilled1312;                         
% t = atan2d(diff(y),diff(x));            % angle of each line
% dt = wrapTo180(diff(t));                % angle between lines
% ix = find(dt>5);                        % find angle
% 
% N = size(ix,1);                         % only keep one point per fall
% keepPoint = false(N,1);
% lastPoint = 1;
% keepPoint(lastPoint) = true;            % keep the first point
% for k=2:N
%   if ix(k) - ix(lastPoint) > 50         % only considers points with an interval > 50
%       keepPoint(k) = true;               
%       lastPoint = k;                    % make this the last row kept
%   end
% end
% fallLocation = ix(keepPoint,:)
% 
% figure(7)
% plot(x(fallLocation),y(fallLocation),'or')              % plot the fall location
% line(x,y)   
% hold on 
% plot(xlim, 50*[1 1], 'r');                                    % plot the data
% 
% 
% %%
% 
% % FINDS THE TIMES SPENT ABOVE THRESHOLD
% 
% stableG = redFilled > 50;                      % detects amount of time spent above a threshold
% stableB
% idx = find(diff([false;stable(:);false]));
% idb = idx(1:2:end);                            % extracts times above threshold
% ide = idx(2:2:end);                            % extracts times below threshold
% idy = (ide-idb)>=10;                           % finds number of times its above threshold for >= 10 frames
% occassionsAboveThreshold= nnz(idy)             % number of times above threshold
% durationAboveThreshold= ide(idy)-idb(idy)      % durations of times above threshold
% 
% 
% hold off
