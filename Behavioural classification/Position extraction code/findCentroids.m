function [locationsX, locationsY] = findCentroids(frame,dthresh,frameSize)

    [redMask,redMaskedRGBImage] = createRMask2033(frame);        % Apply colour thresholds
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
	%yellowMask1 = imclose(yellowMask1, structuringElement);
    
	redMask1 = uint8(imfill(redMask1, 'holes'));      % Fill in holes
    greenMask1 = uint8(imfill(greenMask1, 'holes')); 
    blueMask1 = uint8(imfill(blueMask1, 'holes')); 
    yellowMask1 = uint8(imfill(yellowMask1, 'holes')); 
    
	redMask1 = cast(redMask1, class(redMask));              % Convert objects Mask to the same data type as r
    greenMask1 = cast(greenMask1, class(greenMask));
    blueMask1 = cast(blueMask1, class(blueMask));
    yellowMask1 = cast(yellowMask1, class(yellowMask));
    
    %%
    bboxes = regionprops(redMask1, 'Centroid','EquivDiameter');
    
    if ~isempty(bboxes) && bboxes(1).EquivDiameter > dthresh
        redTrajectory =  frameSize(2)-bboxes(1).Centroid;
    else
        redTrajectory = [NaN NaN];
    end
    
    %%
    bboxes = regionprops(greenMask1, 'Centroid','EquivDiameter');
    
    if ~isempty(bboxes) && bboxes(1).EquivDiameter > dthresh
        greenTrajectory = frameSize(2)-bboxes(1).Centroid;
    else
        greenTrajectory = [NaN NaN];
    end
    
    %%
    bboxes = regionprops(blueMask1, 'Centroid','EquivDiameter');
    
    if ~isempty(bboxes) && bboxes(1).EquivDiameter > dthresh
        blueTrajectory = frameSize(2)-bboxes(1).Centroid;
    else
        blueTrajectory = [NaN NaN];
    end
    
        %%
    bboxes = regionprops(yellowMask1, 'Centroid','EquivDiameter');
    
    if ~isempty(bboxes) && bboxes(1).EquivDiameter > dthresh
        yellowTrajectory = frameSize(2)-bboxes(1).Centroid;
    else
        yellowTrajectory = [NaN NaN];
    end
    
    %%
    locationsX = [redTrajectory(1);greenTrajectory(1);blueTrajectory(1);yellowTrajectory(1)];
    locationsY = [redTrajectory(2);greenTrajectory(2);blueTrajectory(2);yellowTrajectory(2)];
    
    locations= [locationsX;locationsY];
    
end

