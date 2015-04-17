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

function h=gaussian3(FS)

%%  3D Gaussian filter
%   FS: Gaussian filter size 
%   h: 3D filter of size FS*FS*FS

sig=FS/(4*sqrt(2*log(2)));
FS=(FS-1)/2;
[x,y,z]=ndgrid(-FS:FS,-FS:FS,-FS:FS);
h=exp(-(x.*x/2/sig^2 + y.*y/2/sig^2 + z.*z/2/sig^2));
h=h/sum(h(:));
