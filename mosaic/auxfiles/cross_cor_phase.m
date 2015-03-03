function [I3,C,cc,cc2] =  cross_cor_phase(I1,I2,s)
%
%   CROSS_COR_PHASE     Cross correlation registration between two
%   grayscale images using phase correlation.
%   INPUT:
%       I1      The target image
%       I2      The source image
%       s       Pyramid resizing value
%   OUTPUT:
%   I3  Translated image
%   C   Cross-correlation values at each translation location
%   cc  maximum correlation translation value - 1st pyramid level
%   cc2 maximum correlation translation value

%   Rolando Estrada
%   Department of Computer Science
%   Duke University
%   09/06/2010

if nargin == 2
    s = 0.25;
end

m1 = max(max(I1));
m2 = max(max(I2));
V1 = m1 - I1;
V2 = m2 - I2;

V1 = imresize(V1,s);
V2 = imresize(V2,s);

if max(max(V2)) == min(min(V2))
    V2(1,1) = V2(1,1) + 0.1;
end

C = normxcorr2(V2,V1);
[max_c, imax] = max(abs(C(:)));
[ypeak, xpeak] = ind2sub(size(C),imax(1));

cc = [(xpeak-size(V2,2)),(ypeak-size(V2,1))];
cc2 = [cc(2)*round((1/s)),cc(1)*round((1/s))];

I3 = shift_matrix2(I2,cc2,m2);
