function [ thickness, idx ] = calcVesselThickness( centerline, NS, method )
%CALCVESSELTHICKNESS calculate vessel thickness in an image
%   centerline: [n-by-2] array with each row representing a point on the
% centerline. Each point could have interpolated coordinates, not 
% necessarily integer value)

%inds = dsearchn(imgSubs, delaunayn(imgSubs), centerline);
if ~exist('method', 'var')
    method = 'kdtree';
end

if strcmp(method, 'kdtree')
    idx = knnsearch(NS, centerline);
    diff = centerline - NS.X(idx, :);
    thickness = sqrt(sum(diff .* diff, 2));
else
    error('method not supported');
end

end

