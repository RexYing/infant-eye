function Hp2 = feather_single(Hp,a)

if nargin == 1
    a = -0.05;
end

Bb = Hp > 1;
Bb = bwperim(Bb);
Bb = Bb(:,:,2);
Bb = bwdist(Bb);
Bb = 1./(1+exp(a*Bb));
Hp2 = Hp;
for i = 1:size(Hp,3)
    Hp2(:,:,i) = uint8(double(Hp(:,:,i)).*Bb);
end
