function [ img, conncomp, vesselSkeleton ] = postseg( segImg, mask )
%POSTSEG Post-processing for retinal image segmentation results
%   segImg: binary image representing the segmented results
%   mask: binary image representing region of interest

maxIntensity = 255;

% blur the mask to reduce the region of interest so that the border does not
% get classified as vessel.
gKern = fspecial('average', [15, 15]);
mask = imfilter(mask, gKern) == maxIntensity;
img = im2double(segImg & mask);

% eliminate false classification
conncomp = bwconncomp(img);
numPixels = cellfun(@numel, conncomp.PixelIdxList);
smallComp = find(numPixels < 30);
for i = 1 : length(smallComp)
    img(conncomp.PixelIdxList{smallComp(i)}) = 0;
end

vesselSkeleton = skeleton(img);
% vesselSkeleton = bwmorph(img, 'skel', Inf);
% imshow(1 - vesselSkeleton);
end

