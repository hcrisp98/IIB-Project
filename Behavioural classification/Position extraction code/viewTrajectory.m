vid = VideoReader('B_18_1357.mp4')

frameCount=0
i=1
rect= [0, 200, 500, 900]

frameNo= 1000

while hasFrame(vid)
    % Read a video frame and detect objects in it.
    
    frameCount = frameCount + 1;
    frame = readFrame(vid);      % Extract frame from video
    frame = imrotate(frame,-90);
    frame = imcrop(frame, rect);

    greyscale= rgb2gray(frame);   % Make frame greyscale
    
    r= frame(:,:,1);     % Makes red parts of the frame light and other colours dark
    g= frame(:,:,2);     %   "     green   "
    b= frame(:,:,3);     %   "      blue   "
    
    [blueMask,blueMaskedRGBImage] = createBlueMask(frame);                      % Apply colour thresholds 
	[greenMask,greenMaskedRGBImage] = createGreenMask(frame);
    [redMask,redMaskedRGBImage] = createRedMask(frame);
    
    objectsMask = uint8(redMask & greenMask & blueMask);    % Threshold the object areas
    smallestAcceptableArea = 100;
    objectsMask = uint8(bwareaopen(objectsMask, smallestAcceptableArea));
    
	structuringElement = strel('disk', 4);  % Smooth the borders
	objectsMask = imclose(objectsMask, structuringElement);
	
	objectsMask = uint8(imfill(objectsMask, 'holes'));    % Fill in holes 

	objectsMask = cast(objectsMask, class(redMask));     % Convert objectsMask to the same data type as r

	maskedImageR = objectsMask .* r;    % Mask out the red/green/blue-only portions of the image
	maskedImageG = objectsMask .* g;
	maskedImageB = objectsMask .* b;
    
    red= imsubtract(maskedImageR, greyscale);    % Subtract the greyscale image from r
    red= im2bw(red, 0.18);            % Resultant image is white where red is present and black elsewhere
    
    green= imsubtract(maskedImageG, greyscale);
    green= im2bw(green, 0.18);
    
    blue= imsubtract(maskedImageB, greyscale);
    blue= im2bw(blue, 0.18);
    
    bboxes= regionprops(red, 'BoundingBox');  % Draw a bounding box around the balloon
    for k=1:length(bboxes)
        CurrBB=bboxes(k).BoundingBox;
        rectangle('Position', [CurrBB(1),CurrBB(2),CurrBB(3),CurrBB(4)], 'EdgeColor', 'r', 'LineWidth', 2)
        s = regionprops(red,'Centroid');
        centroids = cat(1,s.Centroid);
            hold on
        plot(centroids(:,1),centroids(:,2), 'r*')
    end
    
    bboxes= regionprops(green, 'BoundingBox');    % Draw a bounding box around the balloon
    for k=1:length(bboxes)
        CurrBB=bboxes(k).BoundingBox;
        rectangle('Position', [CurrBB(1),CurrBB(2),CurrBB(3),CurrBB(4)], 'EdgeColor', 'g', 'LineWidth', 2)
        s = regionprops(green,'Centroid', 'EquivDiameter');
        centroids = cat(1,s.Centroid);
            hold on
        plot(centroids(:,1),centroids(:,2), 'g*')
    end
    
    bboxes= regionprops(blue, 'BoundingBox');    % Draw a bounding box around the balloon
    for k=1:length(bboxes)
        CurrBB=bboxes(k).BoundingBox;
        rectangle('Position', [CurrBB(1),CurrBB(2),CurrBB(3),CurrBB(4)], 'EdgeColor', 'b', 'LineWidth', 2)
        s = regionprops(blue,'Centroid');
        centroids = cat(1,s.Centroid);
            hold on
        plot(centroids(:,1),centroids(:,2), 'b*')
    end

    figure(1)
    imshow(greyscale);
    
    i = i+1
    
    if i==frameNo
        break
    end
end
