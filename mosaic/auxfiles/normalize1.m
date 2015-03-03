function I = normalize1(I,k)

if nargin == 1
    k = 255;
end


I = double(I);
I0 = I;
I = I - min(min(I));
if max(max(I)) ~= 0
    I = k*(I./max(max(I)));
else
    I = I0;
end

