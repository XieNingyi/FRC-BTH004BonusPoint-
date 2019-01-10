faceDetector = vision.CascadeObjectDetector('FrontalFaceCART');

% pointTracker = vision.PointTracker('MaxBidirectionalError', 2);
% numPts = 0;

videoFileReader = vision.VideoFileReader('D:\u\审核视频\1.mp4');
videoInfo    = info(videoFileReader);
videoPlayer  = vision.VideoPlayer('Position',[300 100 videoInfo.VideoSize+30]);
while ~isDone(videoFileReader)
%     videoFrame = step(videoFileReader);
%     videoFrameGray = rgb2gray(videoFrame);
%     %在每一帧上检测人脸，并且标记
%     if numPts < 10
%         bbox = faceDetector.step(videoFrameGray);
%         videoOut = insertObjectAnnotation(videoFrame,'rectangle',bbox,'Face');
%         if ~isempty(bbox)
%              %在脸部区域识别特征点，指定被保留特征值的最小值,一般为1 
%             points = detectMinEigenFeatures(videoFrameGray, 'ROI', bbox(1, :));
%             
%             %用初始化框架的点的位置初始化踪迹
%             xyPoints = points.Location;
%             
%             numPts = size(xyPoints,1);
%             
%             release(pointTracker);
%             initialize(pointTracker, xyPoints, videoFrameGray);
%             
%             %复制点用于之前的点和现在的框架之间进行几何转换
%             oldPoints = xyPoints;
%             
%             %将框架转化为一系列的4个点[x1 y1 x2 y2 x3 y3 x4 y4] ，即使被识别的脸发生旋转也能够被看到 
%             bboxPoints = bbox2points(bbox(1, :));
%             
%             %reshape表示重新调整矩阵的行数、列数、维数
%             bboxPolygon = reshape(bboxPoints', 1, []); 
%             
%             % 在被检测的脸的周围插入边界框
%             videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygon, 'LineWidth', 3);
%             
%             % 显示被追随的点，在图像或视频中插入标记符号
%             videoFrame = insertMarker(videoFrame, xyPoints, '+', 'Color', 'white');
%         end
%     else
%         %检测点的踪迹，注意有一些点可能丢失
%         %xyPoints是xx * 2数组，xx表示特征点数目，xyPoints是所有特征的的坐标
%         %isFound是xx * 1数组，表示特征点是否有track ok。ok是1，否则为0
%         [xyPoints, isFound] = step(pointTracker, videoFrameGray);
%         visiblePoints = xyPoints(isFound, :);
%         oldInliers = oldPoints(isFound, :);
%         
%         numPts = size(visiblePoints, 1);       
%         
%         if numPts >= 10
%             %在之前的点和新的点之间进行几何转换并建立边界线 
%             [xform, oldInliers, visiblePoints] = estimateGeometricTransform(...
%                 oldInliers, visiblePoints, 'similarity', 'MaxDistance', 4);            
%             
%             %运行边界点的转换
%             bboxPoints = transformPointsForward(xform, bboxPoints);
%             
%             %reshape表示重新调整矩阵的行数、列数、维数
%             bboxPolygon = reshape(bboxPoints', 1, []); 
%             
%              % 在被追随的物体周围插入边界框
%             videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygon, 'LineWidth', 3);
%             
%              % 显示被追随的点，在图像或视频中插入标记
%             videoFrame = insertMarker(videoFrame, visiblePoints, '+', 'Color', 'green');
%             
%             %重置点
%             oldPoints = visiblePoints;
%             %设置跟随点，很多点在跟踪过程中丢失后，用于点的重新检测
%             setPoints(pointTracker, oldPoints);
%         end
%     end
%     step(videoPlayer, videoFrame);
    
    videoFrame = step(videoFileReader);     
    bbox = step(faceDetector, videoFrame);
    videoOut = insertObjectAnnotation(videoFrame,'rectangle',bbox,'Face');    
    step(videoPlayer, videoOut); %imshow(videoOut)
end
release(videoFileReader);
release(videoPlayer);
release(pointTracker);
release(faceDetector);
