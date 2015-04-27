%% Demonstrate use of postseg

segImg = imread('data/29_training_vessels.png');
% to gray lvl (image is binary)
segImg = segImg(:, :, 1);
mask = imread('data/29_mask.gif');

% load('../Rolando_CODE/WIDE dataset/image_08.mat');
% segImg = I > 0.06;
% mask = zeros(size(segImg)) + 255;

[img, conncomp, vesselSkeleton] = postseg(segImg, mask);
%vesselSkeletonPixel = roundSkel(vesselSkeleton);

%% centerline
figure(1)
% If need to show skeleton without image, the origin of the plot will be 
% different from imshow
imshow(img); 
hold on;
for i = 1: length(vesselSkeleton)
    L = vesselSkeleton{i};
    plot(L(:, 2), L(:, 1), '-', 'Color', rand(1,3));
    %plot(L(:, 2), L(:, 1), 'black.');
end

%% Connected components
figure(2)
numPixels = cellfun(@numel, conncomp.PixelIdxList);
plot(numPixels);
xlabel('Connected components');
ylabel('Number of pixels');

%% Generate graph
figure(1)
hold on
[VesselGraph, V, vesselSkeleton] = extractGraph(vesselSkeleton);
scatter(V(:, 2), V(:, 1)); % x-y wrong order?

