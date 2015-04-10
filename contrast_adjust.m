function [ adjustedImg ] = contrast_adjust( img, range )
%CONTRAST_ADJUST % Contrast adjustment
%   make use of all color range
% img: image matrix
% range: [0, range) is the range of values (default 255)

if nargin < 2
    range = 256;
end

img = double(img);
maxVal = max(img(:));
minVal = min(img(:));
adjustedImg = img - ones(size(img)) * minVal;
adjustedImg = adjustedImg * range / (maxVal - minVal);

end

