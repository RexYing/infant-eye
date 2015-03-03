function [ mask ] = crop( eyeregion )
%CROP Crop eye region based on red channel thresholding with largest
%connected component
% 
% RETURN
%   A mask that is 1 if it is in the eye region

threshold = 57;
r = eyeregion(:, :, 1);
mask = r > threshold;

% eliminate false positive
conncomp = bwconncomp(mask);
numPixels = cellfun(@numel, conncomp.PixelIdxList);

[~, i1] = max(numPixels);
inds = 1: length(numPixels);
inds(i1) = [];
for i = 1: length(inds)
    mask(conncomp.PixelIdxList{inds(i)}) = 0;
end

% eliminate false negative
conncomp = bwconncomp(1 - mask);
numPixels = cellfun(@numel, conncomp.PixelIdxList);

[~, i1] = max(numPixels);
inds = 1: length(numPixels);
inds(i1) = [];
for i = 1: length(inds)
    mask(conncomp.PixelIdxList{inds(i)}) = 1;
end

end

