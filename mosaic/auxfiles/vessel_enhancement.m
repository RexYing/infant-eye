function I2 = vessel_enhancement(I,G,a)

if nargin == 2
    a = 0.9;
end

I2 = double(I);
G = normalize1(double(G),1);
for i = 1:size(I,3)
    I2(:,:,i) = a*normalize1(I2(:,:,i),1) + (1-a)*G;
end

I2(:,:,1) = max(max(I2(:,:,1))).*I2(:,:,1);
I2(:,:,2) = max(max(I2(:,:,2))).*I2(:,:,2);
I2(:,:,3) = max(max(I2(:,:,3))).*I2(:,:,3);

I2 = uint8(mean_adjust(I,I2));
