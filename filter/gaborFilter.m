function [ maxResponse ] = gaborFilter( img, Fs, sigmas )
%GABORFILTER Summary of this function goes here
%   Detailed explanation goes here

scale = 1;
% initialize parameters for Gabor transforms
filter_size = 40.*scale;
filter_size_halfed = round((filter_size)/2);

maxResponse = zeros(size(img));

if ~exist('Fs', 'var')
    Fs = 0.1:0.1:0.3;
end
if ~exist('sigmas', 'var')
    sigmas = (2:2:8) .* scale;
end
thetas=pi/8: pi/8: pi-pi/8;

% initialize array for storing features
features = zeros([size(img),numel(sigmas),numel(thetas),numel(Fs)]);

% writerObj = VideoWriter('gabor_response.avi');
% open(writerObj);

% perform multiple Gabor transforms with varying parameters 
for k = 1:numel(sigmas)
for j = 1:numel(Fs)
for i = 1:numel(thetas)


    sigma = sigmas(k);    
    F = Fs(j);
    theta = thetas(i);

    % setup the Gabor transform
    [x,y]=meshgrid(-filter_size_halfed:filter_size_halfed,-filter_size_halfed:filter_size_halfed);
    g_sigma = (1./(2*pi*sigma^2)).*exp(((-1).*(x.^2+y.^2))./(2*sigma.^2));
    real_g = g_sigma.*cos((2*pi*F).*(x.*cos(theta)+y.*sin(theta)));
    im_g = g_sigma.*sin((2*pi*F).*(x.*cos(theta)+y.*sin(theta)));

    % perform Gabor transform
    uT =sqrt(conv2(img,real_g,'same').^2+conv2(img,im_g,'same').^2);
    
    % normalize transformed image
    uT = (uT-mean(uT(:)))./std(uT(:));

    % append tranformed images to 'features'
    features(:,:,k,j,i) = uT;
    
    % visualize filtered image and the varying filters
    subplot(2,1,1);
    imagesc([img mat2gray(uT).*255],[0 255]);
    colormap('gray'); axis image; axis off;
    title('testing image and the Gabor transformed image');
    
%     frame = getframe;
%     for i = 1: 10
%         writeVideo(writerObj,frame);
%     end
    
    subplot(2,1,2);
    imagesc([real_g im_g]);
    colormap('gray'); axis image; axis off;
    title(sprintf('Gabor filter F:%1.2f t:%1.2f k:%1.f',F,theta,sigma));
    
    drawnow;
    pause(0.5);
    
    maxResponse = max(cat(3, img, maxResponse), [], 3);
    
end
end
end
figure
imagesc(squeeze(maxResponse));
title 'max response';
end

