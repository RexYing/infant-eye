function [b,d] = hsv_interval2_5_3(H,k,p)

if nargin == 1
    k = [0.15,0.3,0.3];
end

if length(k) == 1
    k = [k,k,k];
end

if H(p(2),p(1),1)+k(1) > 1 || H(p(2),p(1),1)-k(1) < 0
    d = 1;
else
    d = 0;
end
b(1) = mod(H(p(2),p(1),1)-k(1),1);
b(2) = mod(H(p(2),p(1),1)+k(1),1);
b(3) = H(p(2),p(1),2)-k(2);
b(4) = H(p(2),p(1),2)+k(2);
b(5) = H(p(2),p(1),3)-k(3);
b(6) = H(p(2),p(1),3)+k(3);

if b(1) < b(2)
    d = 0;
else
    d = 1;
end
