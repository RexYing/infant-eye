%% Load movie
clear all; close all;

movObj = VideoReader('data/IMG_0004.mov');
vidWidth = movObj.Width;
vidHeight = movObj.Height;
mov = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'), ...
    'colormap', []);

% k = 1;
% while hasFrame(movObj)
%     mov(k).cdata = readFrame(movObj);
%     k = k+1;
% end


%% Play back
% hf = figure;
% set(hf, 'position', [150 150 vidWidth vidHeight]);
% 
% movie(hf, mov, 300, movObj.FrameRate);

% Best frame at 375 (around 12-13 s)

nFrames = 900;
dsFactor = 0.25;

dirOut = 'data/output';

frame = imresize(read(movObj, 1), dsFactor);
[fWidth, fHeight, ~] = size(frame);
% first dimension: image index
stack = zeros(nFrames, fWidth, fHeight, 3);

for i = 2: nFrames
    frame = imresize(read(movObj, i), dsFactor);
    stack(i, :, :, :) = reshape(frame, 1, fWidth, fHeight, 3);
end
save('data/frame_data.mat', 'stack', 'fWidth', 'fHeight', 'nFrames', '-v7.3');

%% Identify relavant images
% color_dist(frame, 'RGB', 'Best frame in RGB space');
% color_dist(eyeregion, 'RGB', 'Eye region in best frame in RGB space');
% color_dist(frame, 'HSV', 'Best frame in HSV space');
% [h, s, v] = color_dist(eyeregion, 'HSV', 'Eye region in best frame in HSV space');
% [r, g, b] = color_dist(eyeregion, 'RGB', 'Eye region in best frame in RGB space');
% figure
% hist(double(r(:)), 80)

%color_dist(oofFrame, 'HSV', 'Best frame in HSV space');

%% Identify high focus using band pass filters
%bwframe = rgb2gray(frame);

% figure
% F = fftshift(fft2(bwframe));
% magnitude = abs(F);
% imagesc(log(1 + magnitude));
% colorbar
% colormap gray
% title('Fourier transform of best frame');

% figure
% F = fftshift(fft2(rgb2gray(eyeregion)));
% magnitude = abs(F);
% imagesc(log(1 + magnitude));
% colorbar
% colormap gray
% title('Fourier transform of eye region');

% out of focus
% figure
% oofFrame = read(movObj, 700); %imshow(oofFrame(504: 925, 370:718))
% imshow(oofFrame);
% F = fftshift(fft2( rgb2gray(oofFrame)));
% magnitude = abs(F);
% imagesc(log(1 + magnitude));
% colorbar
% colormap gray
% title('Fourier transform of out of focus frame');

% figure
% F = fftshift(fft2(rgb2gray(oofFrame(343: 575, 674: 929, :))));
% magnitude = abs(F);
% imagesc(log(1 + magnitude));
% colorbar
% colormap gray
% title('Fourier transform of out of focus eye region');

%% Motion
% frame1 = read(movObj, 376);
% [ resultImg, displacement ] = optical_flow_translation( double(frame), double(frame1), [10, 1000; 10, 1900] );




%% Comparison
% frameIr = read(movObj, 800);
% imshow(frameIr);
% color_dist(frame, 'HSV', 'Best frame in HSV space');
% [h, s, v] = color_dist(eyeregion, 'HSV', 'Eye region in best frame in HSV space');
% 
% frameIr = read(movObj, 600);
% imshow(frameIr);

