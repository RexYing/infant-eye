%load test-bw-img
load test-bw-img
sub = nonvesselSub(img);

% load original image
origImg = imread('data/29_training_with_mask.png');
[Gmag,Gdir] = imgradient(rgb2gray(origImg));

%% Vessel thickness
% dependency: postseg_demo or test-bw-img.mat

NS = KDTreeSearcher(sub, 'Distance', 'euclidean');
nVessels = length(vesselSkeleton);
thickness = zeros(nVessels, 1);
for i = 1: nVessels
    [ t, idx ] = calcVesselThickness(vesselSkeleton{i}, NS);
    thickness(i) = mean(t);
end

%% Tortuosity

tort = cellfun(@tortuosityAOC, vesselSkeleton);

%% Fractal dimensions
boxCountingFractalDim = hausDim(img);

%% Visualize
%visualizeVessels(img, vesselSkeleton([1, 3]), 1);
[v, idx1] = max(thickness);
fprintf('Max tort: %d \n', v);
[v, idx2] = min(thickness);
fprintf('Min tort: %d \n', v);
visualizeVessels(img, vesselSkeleton([idx1, idx2]), 1);

%% Histogram
figure(2);
hist(thickness, 40);
xlabel('thickness');
figure(3);
hist(tort, 40);
xlabel('tortuosity');
