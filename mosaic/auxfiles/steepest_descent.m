function [A1,A2,x1,x2,X,b2,a1m,a2,a1,pm,d] = steepest_descent(x,b,n,w,s,ds)

if nargin == 2
    n = 50;
    w = 0.1;
    s = 0.2;
    ds = 0.1;
end

[A2,X,b2,a2] = affine_inverse(x,b);

a1 = a2;
a1m = a2;
d = zeros(n+1,1);
d(1) = affine_l1(a1,X,b2);
dm = d(1);
pm = 1;
for i = 1:n
    g = affine_gradient_mesh(X,a1,b2,s,ds);
    at = a1 - w*g;
    s2 = affine_l1(at,X,b2);
    d(i+1) = s2;
    a1 = at;
    if dm > s2
        dm = s2;
        a1m = a1;
        pm = i;
    end
end

A1 = reshape(a1,3,2);

x2 = X*a2;
x1 = X*a1m;
