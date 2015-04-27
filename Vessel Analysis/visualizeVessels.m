function [ ] = visualizeVessels( img, vesselSkeleton, figNum )
%VISUALIZEVESSEL Drawbinary vessel classification image and vessel
%centerline
%   

if ~exist('figNum', 'var')
    figNum = 1;
end
figure(figNum)
% If need to show skeleton without image, the origin of the plot will be 
% different from imshow
imshow(img); 
hold on;
for i = 1: length(vesselSkeleton)
    L = vesselSkeleton{i};
    plot(L(:, 2), L(:, 1), '.', 'Color', rand(1,3));
    %plot(L(:, 2), L(:, 1), 'black.');
end
hold off;
end

