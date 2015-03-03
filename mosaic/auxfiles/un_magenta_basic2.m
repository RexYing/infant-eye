function [I,B] = un_magenta_basic2(I,hh1,hh2)

if nargin == 1
    hh1 = 0.9;
    hh2 = 0;
end

I = rgb2hsv(I);

B = zeros(size(I,1),size(I,2),'uint8');
for i = 1:size(I,1)
    for j = 1:size(I,2)
        if I(i,j,1) > hh1
            I(i,j,1) = 0;
            B(i,j) = 1;
        elseif I(i,j,1) < hh2
            I(i,j,1) = 0;
            B(i,j) = 1;
        end
    end
end

I = uint8(255*hsv2rgb(I));
