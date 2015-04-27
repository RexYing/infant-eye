function [ tort ] = tortuosityAOC( curve )
%TORTUOSITYAOC tortuosity defined as arc length over chord length
%   line: [n-by-2] matrix, each row represents a point on the curve

[arcLen, ~] = arclength(curve(:, 1), curve(:, 2), 'spline');
n = length(curve);
chordLen = norm(curve(1, :) - curve(n, :));
tort = arcLen / chordLen;

end

