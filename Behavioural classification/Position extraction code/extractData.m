function [rawData, smoothedData]= extractData(video)

    vid = VideoReader(video);

    frameCount=0;
    i=1;
    frameSize= [270 480];
    rect= [0 0 frameSize];
    frameNo= 9000;
    fps= 30;
    smoothMethod= 'makima';

    dThresh = 15;

    while hasFrame(vid)
        % Read a video frame and detect objects in it.
        frameCount = frameCount + 1;
        frame = readFrame(vid);                    % Extract frame from video
        frame = imrotate(frame,-90);
        frame = imcrop(frame, rect);

        %imshow(frame);

        [rawDataX(1:4,i), rawDataY(1:4,i)]=findCentroids(frame, dThresh, frameSize);
       

        i=i+1

        if i==frameNo
            break
        end
    end

    for i=1:4
        B(i,:)=(fillmissing(rawDataX(i,:),smoothMethod,'EndValues','none'));
        C(i,:)=(fillmissing(rawDataY(i,:),smoothMethod,'EndValues','none'));
        smoothedDataX(i,:)= smoothdata(B(i,:), 'rloess', 50);
        smoothedDataY(i,:)= smoothdata(C(i,:), 'rloess', 50);
    end
    
    rawData= [rawDataX; rawDataY];
    smoothedData= [smoothedDataX; smoothedDataY];
   
%     clf
%     subplot(1, 2, 1)
%     plot(rawData(1,:), 'r')
%     hold on
%     plot(rawData(2,:), 'g')
%     plot(rawData(3,:), 'b')
%     plot(rawData(4,:), 'y')
%     subplot(1, 2, 2)
%     plot(smoothedData(1,:), 'r')
%     hold on
%     plot(smoothedData(2,:), 'g')
%     plot(smoothedData(3,:), 'b')
%     plot(smoothedData(4,:), 'y')
%     ylim([0, 500])
    
end
