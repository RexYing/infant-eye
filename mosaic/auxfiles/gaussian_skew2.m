function [G,G2,tform] = gaussian_skew2(s,f,k)

if nargin == 0
    s = [100,100];
    f = 0.25;
    k = 0.5;
elseif nargin == 1
    f = 0.25;
    k = 0.5;
elseif nargin == 2
    k = 0.5;
end

f = round(min(s).*f);
G = fspecial('gaussian',s,f);
tform = maketform('affine',[1 0 0; 0 k 0; 0 0 1]);
G = imtransform(G,tform);
G2 = G;
k2 = s(1)-size(G2,1);
G = padarray(G,[floor(k2/2),0],0,'pre');
G = padarray(G,[ceil(k2/2),0],0,'post');
G = ifftshift(G);
