close all
bestFrames = [371: 375, 377, 378, 379];

eyeRangeX = 331: 602;
eyeRangeY = 642: 945;
w = length(eyeRangeX);
h = length(eyeRangeY);

figure
stack = zeros(length(bestFrames), w, h, 3);
for i = 1: length(bestFrames)
    frame1 = read(movObj, bestFrames(i));
    mask = crop(frame1);
    eyeregion = frame1(eyeRangeX, eyeRangeY, :);
    
    subplot(4, 4, 2 * i - 1);
    imshow(mask(eyeRangeX, eyeRangeY, :));
    subplot(4, 4, 2 * i);
    eyemask = uint8(repmat(mask(eyeRangeX, eyeRangeY, :), 1, 1, 3));
    
    eyeregion = eyeregion .* eyemask;
    imshow(eyeregion);
    stack(i, :, :, :) = reshape(eyeregion, 1, w, h, 3);
    imwrite(eyeregion, sprintf('frames/%d.tif', i));
end

%% snake
% I = mask(eyeRangeX, eyeRangeY, :);
%  % Show the image and select some points with the mouse (at least 4)
%  %figure, imshow(I); [y,x] = getpts;
% %   y=[123 222 212 125];
% %   x=[97 98 196 194];
%   y=[38 276 278 33];
%   x=[41 32 246 245];
%  % Make an array with the clicked coordinates
%   P=[x(:) y(:)];
%  % Start Snake Process
%   Options=struct;
%   Options.Verbose=true;
%   Options.Iterations=300;
%   [O,J]=Snake2D(I,P,Options);
%  % Show the result
%   Irgb(:,:,1)=I;
%   Irgb(:,:,2)=I;
%   Irgb(:,:,3)=J;
%   figure, imshow(Irgb,[]); 
%   hold on; 
%   plot([O(:,2);O(1,2)],[O(:,1);O(1,1)]);

%% registration of filtered image
opt = option_defaults_fa;
load('sparsefusion/Dictionary/D_100000_256_8.mat');
overlap = 6;
epsilon=0.1;
level=4;

[optimizer,metric] = imregconfig('monomodal');
optimizer.MaximumIterations = 300;
optimizer.MaximumStepLength = optimizer.MaximumStepLength / 3;

base = squeeze(stack(1, :, :, :));
base = filter_image(uint8(base), opt);
%base = filter_image(base(:, :, 1), opt);
figure
colormap gray;
imagesc(base);

filteredStack = zeros(size(stack));

for i = 2: length(bestFrames)
    frame = squeeze(stack(i, :, :, :));
    frame = filter_image(uint8(frame), opt);
    %frame = filter_image(frame(:, :, 1), opt);
    
    registered = imregister(frame, base, 'affine', optimizer, metric);
    imagesc(registered);
    drawnow; %pause(0.5);
    
    imgf = lp_sr_fuse(base,registered,level,3,3,D,overlap,epsilon);
    base = imgf;
    imagesc(imgf);
    drawnow; %pause(0.5);
    
%     nonrigidSplineReg(frame(:, :, 1), base(:, :, 1));
    
%     imshowpair(frame(:, :, 1), base(:, :, 1));
%     figure
%     imshowpair(registered(:, :, 1), base(:, :, 1));
end
imwrite(imgf, sprintf('frames/fused.tif', i));

segOpt = dijkstra_seg_defaults;
mask = double(squeeze(eyemask(:, :, 1)));
%[G, K, imgf2] = filter_image(imgf(:, :,1), opt);
%Dj_f = dijk_seg(G);

G = filter_image(uint8(mat2gray(imgf)*255), option_defaults);
Dj_f = dijkstra_segmentation(G, segOpt);
imwrite(Dj_f, 'segmented_image_good_frames');
