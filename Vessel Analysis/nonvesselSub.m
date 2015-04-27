function [ sub ] = nonvesselSub( img )
%NONVESSELSUB obtain non-vessel subscripts from binary image
%   img: binary image with entry 0 as non-vessel pixels

ind = find(1 - img);
[x, y] = ind2sub(size(img), ind);
sub = [x, y];

end

