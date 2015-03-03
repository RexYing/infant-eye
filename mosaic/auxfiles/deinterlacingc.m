function [D,F2,F] = deinterlacingc(I,s,k)
% Eliminates interlacing artifacts using the frequency domain.
% Assumes a grayscale image
% Employs a Gaussian low-pass filter

if nargin == 1
    s = 0.25;
    k = 0.5;
elseif nargin == 2
    k = 0.5;
end

D = I;
for i = 1:size(I,3)
    F = fft2(double(I(:,:,i)));
    G = gaussian_skew2(size(F),s,k);
    F2 = F.*G;
    D(:,:,i) = uint8(normalize1(real(ifft2(F2))));
end
