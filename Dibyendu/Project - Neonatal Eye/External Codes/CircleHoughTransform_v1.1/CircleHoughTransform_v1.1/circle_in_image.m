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

function [x,y,theta]=circle_in_image(m,n,xc,yc,r)

%%  Return discrete coordinates of points on a circle.
%   The function of the circle : 
%       x=xc+r*cos(theta)
%       y=yc+r*sin(theta)
%   m: number of image rows
%   n: number of image columns

theta=linspace(0,2*pi,round(2*pi*r));
data=[xc+r*cos(theta);yc+r*sin(theta)];
data=round(data);
[data, index]=unique(data','rows'); % removed repeated data
data=data';
x=data(1,:);
y=data(2,:);
theta=theta(index);
[theta, index]=sort(theta);
x=x(index);
y=y(index);
if min(x)<1 || min(y)<1 || max(x)>n || max(y)>m
    fprintf('\n\nCircle out of image!\n\n');
end
