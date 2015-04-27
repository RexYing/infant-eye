I=im2double(rgb2gray(imread('images/vessels2d.png')));
Ibin=I<0.5;

%% Skeleton
S=skeleton(Ibin);
% Display the skeleton
figure, imshow(Ibin); hold on;
for i=1:length(S)
L=S{i};
plot(L(:,2),L(:,1),'-','Color',rand(1,3));
end

%% Shortest path
tic
% Load a maze image
I1=im2double(imread('images/maze.gif'));
% Convert the image to a speed map
SpeedImage=I1*1000+0.001;
% Set the source to end of the maze
SourcePoint=[800;803];
% Calculate the distance map (distance to source)
DistanceMap= msfm(SpeedImage, SourcePoint); 
% Show the distance map
figure, imshow(DistanceMap,[0 3400])
% Trace shortestline from StartPoint to SourcePoint
StartPoint=[9;14];
ShortestLine=shortestpath(DistanceMap,StartPoint,SourcePoint);
% Plot the shortest route
hold on, plot(ShortestLine(:,2),ShortestLine(:,1),'r')
toc

%% on retinal images
tic
% Load a maze image
load test-bw-img
% Convert the image to a speed map
SpeedImage = img * 10 + 0.001;
% Set the source for distance map
SourcePoint = [94; 332];
% Calculate the distance map (distance to source)
DistanceMap = msfm(SpeedImage, SourcePoint); 
% Show the distance map
figure, imagesc(DistanceMap)
% Trace shortestline from StartPoint to SourcePoint
StartPoint = [93; 282];
ShortestLine=shortestpath(DistanceMap, StartPoint, SourcePoint);
% Plot the shortest route
hold on, plot(ShortestLine(:,2), ShortestLine(:,1),'r')
toc