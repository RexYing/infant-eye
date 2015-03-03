%% Load movie

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

frame = read(movObj, 375);
imshow(frame);
eyeregion = frame(343: 575, 674: 929, :);
figure
imshow(eyeregion);

%% Identify relavant images
% color_dist(frame, 'RGB', 'Best frame in RGB space');
% color_dist(eyeregion, 'RGB', 'Eye region in best frame in RGB space');
color_dist(frame, 'HSV', 'Best frame in HSV space');
[h, s, v] = color_dist(eyeregion, 'HSV', 'Eye region in best frame in HSV space');
[r, g, b] = color_dist(eyeregion, 'RGB', 'Eye region in best frame in RGB space');
figure
hist(double(r(:)), 80)

%color_dist(oofFrame, 'HSV', 'Best frame in HSV space');

%% Identify high focus using band pass filters
bwframe = rgb2gray(frame);

% figure
% F = fftshift(fft2(bwframe));
% magnitude = abs(F);
% imagesc(log(1 + magnitude));
% colorbar
% colormap gray
% title('Fourier transform of best frame');

figure
F = fftshift(fft2(rgb2gray(eyeregion)));
magnitude = abs(F);
imagesc(log(1 + magnitude));
colorbar
colormap gray
title('Fourier transform of eye region');

% out of focus
% figure
oofFrame = read(movObj, 700); %imshow(oofFrame(504: 925, 370:718))
% imshow(oofFrame);
% F = fftshift(fft2( rgb2gray(oofFrame)));
% magnitude = abs(F);
% imagesc(log(1 + magnitude));
% colorbar
% colormap gray
% title('Fourier transform of out of focus frame');

figure
F = fftshift(fft2(rgb2gray(oofFrame(343: 575, 674: 929, :))));
magnitude = abs(F);
imagesc(log(1 + magnitude));
colorbar
colormap gray
title('Fourier transform of out of focus eye region');

%% Motion
% frame1 = read(movObj, 376);
% [ resultImg, displacement ] = optical_flow_translation( double(frame), double(frame1), [10, 1000; 10, 1900] );


%% Filter
f1 = fspecial('gaussian', 10, 4);
f2 = fspecial('laplacian');
%img = double(rgb2gray(frame));
img = double(rgb2gray(eyeregion));
response = imfilter(imfilter(img, f1), f2);
imshow(response);

bw = response > 0.1;
bwskel = bwmorph(bw,'skel',5);
figure
colormap gray
imagesc(bwskel);
%%
img = 255 - img;
img = double(imread('Fundus_photograph_of_normal_left_eye.tif'));
gaborArray = gaborFilterBank(1, 5,8,39,39);
featureVector = gaborFeatures(img,gaborArray,1,1);
response = abs(conv2(img,gaborArray{1,1},'same'));
for i = 1: 5
    for j = 1: 8
        curr = abs(conv2(img,gaborArray{i,j},'same'));
        response(response < curr) = 0;
        new = curr(curr > response);
        curr(curr <= response) = 0;
        if ~isempty(new)
            response = response + curr;
        end
    end
end
figure
colormap gray
imagesc(response);

%% Comparison
% frameIr = read(movObj, 800);
% imshow(frameIr);
% color_dist(frame, 'HSV', 'Best frame in HSV space');
% [h, s, v] = color_dist(eyeregion, 'HSV', 'Eye region in best frame in HSV space');
% 
% frameIr = read(movObj, 600);
% imshow(frameIr);

