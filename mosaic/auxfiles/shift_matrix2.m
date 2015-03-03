function M = shift_matrix2(M,d,f)

if nargin == 1
    d(1) = 1;
    d(2) = 1;
    f = 0;
elseif length(d) == 1
    e = d;
    d(1) = e;
    d(2) = e;
    f = 0;
elseif nargin == 2
    f = 0;
end

d1 = abs(d);
M2 = padarray(M,d1,f);
M2 = circshift(M2,d);
M = M2((d1(1)+1):(end-d1(1)),(d1(2)+1):(end-d1(2)),:);
