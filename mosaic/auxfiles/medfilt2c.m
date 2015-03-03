function I = medfilt2c(I,n)

if nargin == 1
    n(1) = 3;
    n(2) = 3;
end

for i = 1:size(I,3)
    I(:,:,i) = medfilt2(I(:,:,i),n);
end
