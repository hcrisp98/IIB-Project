    frame = readFrame(vid);                    % Extract frame from video

    [redMask,redMaskedRGBImage] = createRedMask(frame);        % Apply colour thresholds
    [greenMask,greenMaskedRGBImage] = createGreenMask(frame);
    [blueMask,blueMaskedRGBImage] = createBlueMask(frame);                       

    
    redMask1 = uint8(redMask);    % Threshold the object areas
    greenMask1 = uint8(greenMask);
    blueMask1 = uint8(blueMask);
    smallestAcceptableArea = 100;
    redMask1 = uint8(bwareaopen(redMask1, smallestAcceptableArea));
    greenMask1 = uint8(bwareaopen(greenMask1, smallestAcceptableArea));
    blueMask1 = uint8(bwareaopen(blueMask1, smallestAcceptableArea));
    
	structuringElement = strel('disk', 4);                  % Smooth the borders
	redMask1 = imclose(redMask1, structuringElement);
    greenMask1 = imclose(greenMask1, structuringElement);
    blueMask1 = imclose(blueMask1, structuringElement);
	
	redMask1 = uint8(imfill(redMask1, 'holes'));      % Fill in holes
    greenMask1 = uint8(imfill(greenMask1, 'holes')); 
    blueMask1 = uint8(imfill(blueMask1, 'holes')); 

	redMask1 = cast(redMask1, class(redMask));              % Convert objects Mask to the same data type as r
    greenMask1 = cast(greenMask1, class(greenMask));
    blueMask1 = cast(blueMask1, class(blueMask));

    
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

