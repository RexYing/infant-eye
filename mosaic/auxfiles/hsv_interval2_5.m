function [b,d] = hsv_interval2_5(I,k,p)

if nargin == 1
    k = 0.2;
end

H = rgb2hsv(I);
if H(p(2),p(1),1)+k > 1 || H(p(2),p(1),1)-k < 0
    d = 1;
else
    d = 0;
end
b(1) = mod(H(p(2),p(1),1)-k,1);
b(2) = mod(H(p(2),p(1),1)+k,1);
b(3) = H(p(2),p(1),2)-k;
b(4) = H(p(2),p(1),2)+k;
b(5) = H(p(2),p(1),3)-k;
b(6) = H(p(2),p(1),3)+k;
