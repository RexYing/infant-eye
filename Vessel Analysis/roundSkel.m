function [ skeleton ] = roundSkel( skeleton )
%ROUNDPOINTS Round points in skeleton to the nearest pixel 
% (integer coordinates)
%   

for i = 1: length(skeleton)
    skeleton{i} = unique(round(skeleton{i}), 'rows', 'stable');
end

end

