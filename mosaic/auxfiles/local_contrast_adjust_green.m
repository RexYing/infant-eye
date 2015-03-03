function [L3,M4,M2,L2] = local_contrast_adjust_green(I,s1,t1,f)

if nargin == 1
    s1 = [50,50];
    t1 = 1.15;
    f = 'max';
elseif nargin == 2
    t1 = 1.15;
    f = 'max';
elseif nargin == 3
    f = 'max';
end

if strcmp(f,'max')
    M = medfilt2(I(:,:,2),s1);
    M2 = normalize1((double(I(:,:,2)) - double(M)),1);
    T = hysthresh_single(M2,t1);
    L2 = uint8(T > 0);
    L2n = uint8(T == 0);
elseif strcmp(f,'min')
    M = medfilt2(I(:,:,2),s1);
    M2 = normalize1((double(I(:,:,2)) - double(M)),1);
    T = hysthresh_single(M2,t1);
    L2 = I(:,:,2);
    L2(T > 0) = 0;
end

if size(I,3) == 3
    M4 = medfilt2c(I,s1);
else
    M4 = medfilt2(I,s1);
end

L3 = I;
for i = 1:size(L3,3)
    L3(:,:,i) = L2n.*L3(:,:,i);
    M4(:,:,i) = L2.*M4(:,:,i);
    L3(:,:,i) = L3(:,:,i)+M4(:,:,i);
end
