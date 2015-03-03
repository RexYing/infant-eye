function [I3,f,R,dm,sm,mn] = cross_corr(I1,I2,n,m)

if nargin == 2
    n = 5;
    m = 5;
end

% Pad if necessary

dm = Inf;
x = 0;
y = 0;
R = zeros(length(-n:n),length(-m:m));
mx = size(I1,1)*size(I1,2);
k1 = 1;
for i = -n:n
    k2 = 1;
    for j = -m:m
        I4 = circshift(I2,[i,j]);
        d = sum(sum((I4 - I1).^2))/mx;
        if d < dm
            I3 = I4;
            dm = d;
            x = i;
            y = j;
        end
        k2 = k2+1;
        R(k1,k2) = d;
    end
    k1 = k1+1;
end
f = [x,y];
sm = 0;
mn = 0;
