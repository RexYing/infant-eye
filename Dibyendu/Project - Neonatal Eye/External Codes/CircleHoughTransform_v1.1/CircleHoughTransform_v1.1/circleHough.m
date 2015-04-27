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

function [xc,yc,r]=circleHough(I,rmin,rmax,P,FS)

%%  Find the best fit of circles on a bianry image using circle Hough transform
%   I: 2D binary image
%   rmin: smallest radius to be considered
%   rmax: largest radius to be considered
%   P: precision
%       Suggested value is 1. When larger than 2, will be very slow.
%   FS: Gaussian filter size
%       Suggested value is 5. When larger than 10, will ve very slow.
%   xc: x-coordinate of center (best fit)
%   yc: y-coordinate of center (best fit)
%   r: radius (best fit)

%% input checking
xc=[];yc=[];r=[];
if length(size(I))>2
    fprintf('Error: I must be a 2D binary image. \n');
    return;
end
if rmin>=rmax || rmin<=0 || rmax<=0
    fprintf('Error: Must ensure 0<rmin<rmax. \n');
    return;
end
if rmin~=round(rmin) || rmax~=round(rmax)
    fprintf('Error: rmin and rmax must be integers. \n');
end
if P<1 || round(P)~=P || P>100
    fprintf('Error: P must be a small positive integer');
end
if FS<1 || round(FS)~=FS || FS>100
    fprintf('Error: FS must be a small positive integer');
end

%% Hough transform
I=double(I);
H=CircleHoughTransform(I,rmin,rmax,P);

%% gaussian filtering
if FS>=2
    h=gaussian3(FS);
    fprintf('Performing 3D Gaussian filtering ... \n');
    H=imfilter(H,h);
end

%% get best parameters
[~,index]=max(H(:));
y_index=mod(index-1,size(H,1))+1;
index=(index-y_index)/size(H,1)+1;
x_index=mod(index-1,size(H,2))+1;
r_index=(index-x_index)/size(H,2)+1;

xc=(x_index-1)/P+1;
yc=(y_index-1)/P+1;
r=(r_index-1)/P+rmin;