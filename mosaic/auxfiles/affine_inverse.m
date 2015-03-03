function [A,X,b2,a] = affine_inverse(x,b)
% Assumes x and b have row data points and column coordinates

X = zeros(2*(size(x,1)),6);

j = 1;
for i = 1:2:size(X,1)
    X(i,:) = [x(j,1),x(j,2),1,0,0,0];
    X(i+1,:) = [0,0,0,x(j,1),x(j,2),1];
    j = j+1;
end

b2 = b';
b2 = b2(:);

% Least squares fit
a = X\b2;
A = reshape(a,3,2);
