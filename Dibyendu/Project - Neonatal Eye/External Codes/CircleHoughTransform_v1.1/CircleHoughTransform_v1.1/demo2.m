% Copyright (C) 2012 Quan Wang <wangq10@rpi.edu>,
% Signal Analysis and Machine Perception Laboratory,
% Department of Electrical, Computer, and Systems Engineering,
% Rensselaer Polytechnic Institute, Troy, NY 12180, USA
%
% You are free to use this software for academic purposes if you cite our paper:
% Quan Wang, Kim L. Boyer,
% The active geometric shape model: A new robust deformable shape model and its applications,
% Computer Vision and Image Understanding, Volume 116, Issue 12, December 2012, Pages 1178-1194,
% ISSN 1077-3142, 10.1016/j.cviu.2012.08.004.
%
% For commercial use, please contact the authors.

clear;clc;close all;

mex CircleHoughTransform.cpp;
I=imread('wheel.jpg');
I2=rgb2gray(I);
BW = edge(I2,'canny',0.7);

rmin=100;
rmax=300;
P=1; % precision (large P will use a huge amount of memory)
FS=1; % Gaussian filter size (large FS will be extremely slow)

%% performing Hough transform
tic;
[xc,yc,r]=circleHough(double(BW),rmin,rmax,P,FS);
t=toc;
fprintf('Hough transform and 3D filtering took %f seconds \n',t);

%% display resulting circle
figure;
imshow(I);
hold on;
[x,y,theta]=circle_in_image(size(I,1),size(I,2),xc,yc,r);
plot(x,y,'-g','LineWidth',10);
