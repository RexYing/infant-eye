function [ F, filter ] = high_pass( F, D0, n )
%LOWPASS A low pass filter in frequency domain
% 
% Type: Butterworth
% F: Fourier transform of an image
% D0: cutoff frequency
% n: order

[numRows, numCols] = size(F);
filter = zeros(size(F));
centerX = round(numRows / 2);
centerY = round(numCols / 2);

for i = 1: numRows
    for j = 1: numCols
        dist = norm([i - centerX, j - centerY]);
        filter(i, j) = 1 / (1 + (D0 / dist)^(2 * n));
    end
end

F = F .* filter;

end

