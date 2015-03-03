function [h, s, v ] = color_dist( img,  colorspace, plotTitle)
%COLOR_DIST Draw color distribution as 3D plot
%
%   colorspace: can be RGB or HSV

figure
if strcmp(colorspace, 'HSV')
    img = rgb2hsv(img);
end

h = img(:, :, 1);
s = img(:, :, 2);
v = img(:, :, 3);
scatter3(h(:), s(:), v(:), 1, 'filled');
if exist('plotTitle', 'var')
    title(plotTitle);
end
end

