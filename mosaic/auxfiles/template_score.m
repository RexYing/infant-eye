function [h,C] = template_score(I,H,s)

if nargin == 2
    s = 0.25;
end

if size(I,3) == 3
    I = I(:,:,2);
end

I = normalize1(imresize(I,s),1); 
C = normxcorr2(H,I);
h = max(max(C));