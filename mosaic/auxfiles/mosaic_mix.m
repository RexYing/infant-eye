function Mm = mosaic_mix(M,Mgb,r)

if nargin == 2
    r = 0.75;
end

Mm = M;
for j = 1:3
    Mm1 = uint8(r.*double(M(:,:,j)) + (1-r).*normalize1(double(Mgb),max(max(double(M(:,:,j))))));
    Mm1(M(:,:,j) < 10) = 0;
    Mm(:,:,j) = Mm1;
end
