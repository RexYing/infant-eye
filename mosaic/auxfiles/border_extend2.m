function [I2,B0,E] = border_extend2(I0,s,w,p)
% B is a perimeter image.

if nargin == 1
    s = 10;
    w = 1;
    p = 5;
end

B = bwperim(I0 > 0);
B = hue_clean(B); B0 = B;
B = uint8(B);
se = strel('disk',1);
se2 = strel('disk',p);
B3 = uint8(imdilate(B,se2));
B4 = uint8(imfill(B3,'holes'));
B4 = B4 - B3; B4(B4 < 0) = 0;
B = bwperim(B4);
I2 = I0;
E = B;
for i = 1:s
    [fi,fj] = find(E);
    for j = 1:length(fi)
        M = I2(max(1,fi(j)-w):min(size(I0,1),fi(j)+w),max(1,fj(j)-w):min(size(I0,2),fj(j)+w),:);
        for k = 1:size(M,3)
            m = median_sans_zeros(M(:,:,k));
            I2(fi(j),fj(j),k) = m;
        end
    end
    B2 = uint8(imfill(E,'holes'));
    B3 = uint8(imdilate(E,se));    
    E = B3 - B2;
end
    