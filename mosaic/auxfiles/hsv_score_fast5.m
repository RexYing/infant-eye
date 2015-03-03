function [h,I2,I2h,I2s,I2v] = hsv_score_fast5(I,b,d)

if nargin == 1
    b(1) = 0.1;
    b(2) = 0.9;
    b(3) = 0.25;
    b(4) = 0.75;
    b(5) = 0.3;
    b(6) = 0.9;
    d = 1;
elseif nargin == 2
    d = 1;
end

I3 = rgb2hsv_fast(I,'single');

I2h = zeros(size(I3,1),size(I3,2),'uint8');
I2s = zeros(size(I3,1),size(I3,2),'uint8');
I2v = zeros(size(I3,1),size(I3,2),'uint8');

if d == 1
    I2h(I3(:,:,1) > b(1)) = 1;
    I2h(I3(:,:,1) < b(2)) = 1;
    I2s(I3(:,:,2) > b(3)) = 1;
    I2s(I3(:,:,2) > b(4)) = 0;
    I2v(I3(:,:,3) > b(5)) = 1;
    I2v(I3(:,:,3) > b(6)) = 0;
    I2 = I2h.*I2s.*I2v;
elseif d == 0
    I2h(I3(:,:,1) > b(1)) = 1;
    I2h(I3(:,:,1) > b(2)) = 0;
    I2s(I3(:,:,2) > b(3)) = 1;
    I2s(I3(:,:,2) > b(4)) = 0;
    I2v(I3(:,:,3) > b(5)) = 1;
    I2v(I3(:,:,3) > b(6)) = 0;
    I2 = I2h.*I2s.*I2v;    
end

h = sum(sum(I2))/(size(I2,1)*size(I2,2));
                