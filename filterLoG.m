function [ response ] = filterLoG( img )
%LOG Laplace of Gaussian filter
%   Detailed explanation goes here

f1 = fspecial('gaussian', 10, 4);
f2 = fspecial('laplacian');
response = imfilter(imfilter(img, f1), f2);

end

