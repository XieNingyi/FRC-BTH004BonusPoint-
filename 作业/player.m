faceDetector = vision.CascadeObjectDetector('FrontalFaceCART');

% pointTracker = vision.PointTracker('MaxBidirectionalError', 2);
% numPts = 0;

videoFileReader = vision.VideoFileReader('D:\u\�����Ƶ\1.mp4');
videoInfo    = info(videoFileReader);
videoPlayer  = vision.VideoPlayer('Position',[300 100 videoInfo.VideoSize+30]);
while ~isDone(videoFileReader)
%     videoFrame = step(videoFileReader);
%     videoFrameGray = rgb2gray(videoFrame);
%     %��ÿһ֡�ϼ�����������ұ��
%     if numPts < 10
%         bbox = faceDetector.step(videoFrameGray);
%         videoOut = insertObjectAnnotation(videoFrame,'rectangle',bbox,'Face');
%         if ~isempty(bbox)
%              %����������ʶ�������㣬ָ������������ֵ����Сֵ,һ��Ϊ1 
%             points = detectMinEigenFeatures(videoFrameGray, 'ROI', bbox(1, :));
%             
%             %�ó�ʼ����ܵĵ��λ�ó�ʼ���ټ�
%             xyPoints = points.Location;
%             
%             numPts = size(xyPoints,1);
%             
%             release(pointTracker);
%             initialize(pointTracker, xyPoints, videoFrameGray);
%             
%             %���Ƶ�����֮ǰ�ĵ�����ڵĿ��֮����м���ת��
%             oldPoints = xyPoints;
%             
%             %�����ת��Ϊһϵ�е�4����[x1 y1 x2 y2 x3 y3 x4 y4] ����ʹ��ʶ�����������תҲ�ܹ������� 
%             bboxPoints = bbox2points(bbox(1, :));
%             
%             %reshape��ʾ���µ��������������������ά��
%             bboxPolygon = reshape(bboxPoints', 1, []); 
%             
%             % �ڱ�����������Χ����߽��
%             videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygon, 'LineWidth', 3);
%             
%             % ��ʾ��׷��ĵ㣬��ͼ�����Ƶ�в����Ƿ���
%             videoFrame = insertMarker(videoFrame, xyPoints, '+', 'Color', 'white');
%         end
%     else
%         %������ټ���ע����һЩ����ܶ�ʧ
%         %xyPoints��xx * 2���飬xx��ʾ��������Ŀ��xyPoints�����������ĵ�����
%         %isFound��xx * 1���飬��ʾ�������Ƿ���track ok��ok��1������Ϊ0
%         [xyPoints, isFound] = step(pointTracker, videoFrameGray);
%         visiblePoints = xyPoints(isFound, :);
%         oldInliers = oldPoints(isFound, :);
%         
%         numPts = size(visiblePoints, 1);       
%         
%         if numPts >= 10
%             %��֮ǰ�ĵ���µĵ�֮����м���ת���������߽��� 
%             [xform, oldInliers, visiblePoints] = estimateGeometricTransform(...
%                 oldInliers, visiblePoints, 'similarity', 'MaxDistance', 4);            
%             
%             %���б߽���ת��
%             bboxPoints = transformPointsForward(xform, bboxPoints);
%             
%             %reshape��ʾ���µ��������������������ά��
%             bboxPolygon = reshape(bboxPoints', 1, []); 
%             
%              % �ڱ�׷���������Χ����߽��
%             videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygon, 'LineWidth', 3);
%             
%              % ��ʾ��׷��ĵ㣬��ͼ�����Ƶ�в�����
%             videoFrame = insertMarker(videoFrame, visiblePoints, '+', 'Color', 'green');
%             
%             %���õ�
%             oldPoints = visiblePoints;
%             %���ø���㣬�ܶ���ڸ��ٹ����ж�ʧ�����ڵ�����¼��
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
