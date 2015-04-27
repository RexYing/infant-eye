function [ G, keyV, vesselSkeleton ] = extractGraph( vesselSkeleton )
%EXTRACTVERTICES Extract vertices and edges from vessel skeletons.
%
% INPUT
%
%   G: Vessel graph struct. 
%       G.V: [N-by-2] coordinates of vertices
%       G.A: [N-by-N] sparse adjacency matrix
%   keyV: Key vertices: vertices that are end points, intersections or
% bifurcation points of vessel
%   vessselSkeleton: [1-by-n] cell array, each cell contains [k_i-by-2]
% array containing the points on the centerline of vessels.
%   

% Initialize key-vertices
keyV = zeros(length(vesselSkeleton) * 2, 2);
numKeyV = 0;
% vessel endpoints list, each edge corresponds to each row of E, that contains the 2
% indices of the end point vertices
vesselV = zeros(length(vesselSkeleton), 2);

% Generate vertices from centerline
% for i = 1: length(vesselSkeleton)
%     x1 = vesselSkeleton{i}(:, 1);
%     y1 = vesselSkeleton{i}(:, 2);
%     for j = i + 1 : length(vesselSkeleton)
%         % intersections: assume at most one for any two segments
%         x2 = vesselSkeleton{j}(:, 1);
%         y2 = vesselSkeleton{j}(:, 2);
%         [xi, yi] = polyxpoly(x1, y1, x2, y2);
%         if ~isempty(xi)
%             numV = numV + 1;
%             V(numV, :) = [xi, yi];
%         end
%     end
% end

% If two vertices have distance difference less than 'threshold' pixel, merge
threshold = 5;
% minimum number of centerline pixel required for a vessel (remove vessel
% if there is not enough centerline pixels for this vessel)
minNumPixels = 5;

    function ind = nearUnique(pt)
        ind = numKeyV + 1; % unique, set index to be the next unused index
        for k = 1 : numKeyV
            if norm(keyV(k, :) - pt) <= threshold
                ind = k;
                break;
            end
        end
    end

%% Find key vertices keyV
i = 1;
while i <= length(vesselSkeleton)
    pts = vesselSkeleton{i};
    endpt1 = pts(1, :);
    endpt2 = pts(length(pts), :);
    ind = nearUnique(endpt1);
    
    % end point 1
    if (ind == numKeyV + 1)
        numKeyV = ind;
        keyV(numKeyV, :) = endpt1;
        vesselV(i, 1) = numKeyV;
    end
    vesselV(i, 1) = ind;
    
    % adjust vesselSkeleton so that it conforms with key vertices
    j = 2;
    while j <= size(vesselSkeleton{i}, 1);
        if norm(vesselSkeleton{i}(j, :) - keyV(ind, :)) <= threshold
            j = j + 1;
        else
            break;
        end
    end
    vesselSkeleton{i} = [keyV(ind, :); vesselSkeleton{i}(j: length(pts), :)];
    
    % end point 2
    ind = nearUnique(endpt2);
    if (ind == numKeyV + 1)
        numKeyV = ind;
        keyV(numKeyV, :) = endpt2;
        vesselV(i, 2) = numKeyV;
    end
    vesselV(i, 2) = ind;
    
    % adjust vesselSkeleton so that it conforms with key vertices
    j = size(vesselSkeleton{i}, 1);
    while j >= 1
        if norm(vesselSkeleton{i}(j, :) - keyV(ind, :)) <= threshold
            j = j - 1;
        else
            break;
        end
    end
    vesselSkeleton{i} = [vesselSkeleton{i}(1: j, :); keyV(ind, :)];
    
    % too short vessels are eliminated
    if size(vesselSkeleton{i}, 1) <= minNumPixels
        vesselSkeleton(i) = [];
    else
        i = i + 1;
    end
end
keyV = keyV(1: numKeyV, :);

%% Construct fields in struct G
% V in G
numVertsPerSegment = cellfun(@length, vesselSkeleton);
numV = sum(numVertsPerSegment);
V = zeros(numV, 2);

vg = graph.VasculatureGraph(keyV);
% key vertices have indices starting from 1
cumNumVerts = vg.getKeyVSize();
V(1: cumNumVerts, :) = keyV;

% for A in G
nEdges = numV - length(numVertsPerSegment);
rowInds = zeros(nEdges, 1);
colInds = zeros(nEdges, 1);
% index for rowInds, colInds
cumIndE = 0;
for i = 1: length(vesselSkeleton)
    nV = size(vesselSkeleton{i}, 1);
    rowInds(cumIndE + 1) = vesselV(i, 1);
    rowInds(cumIndE + 2: cumIndE + nV - 1) = cumNumVerts + (1: nV - 2);
    
    colInds(cumIndE + nV - 1) = vesselV(i, 2);
    colInds(cumIndE + 1: cumIndE + nV - 2) = cumNumVerts + (1: nV - 2);
    
    V(cumNumVerts + 2: cumNumVerts + nV - 1, :) = vesselSkeleton{i}(2: nV - 1, :);
    
    cumNumVerts = cumNumVerts + nV - 2;
    cumIndE = cumIndE + nV - 1;
end
% logical value in adjacency matrix
s = true(cumIndE, 1);

A = sparse(rowInds, colInds, s, numV, numV);
A = A + A';

G = struct('V', V, 'A', A, 'E', A);

end

