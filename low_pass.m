function [ F, filter ] = low_pass( F, D0 )
%LOWPASS A low pass filter in frequency domain
% 
% Type: Gaussian
% F: Fourier transform of an image
% D0: cutoff frequency

[numRows, numCols] = size(F);
filter = zeros(size(F));
centerX = round(numRows / 2);
centerY = round(numCols / 2);
D0 = D0^2 * 2;
for i = 1: numRows
    for j = 1: numCols
        dist = norm([i - centerX, j - centerY]);
        filter(i, j) = exp(-dist^2 / D0);
    end
end

F = F .* filter;

end

