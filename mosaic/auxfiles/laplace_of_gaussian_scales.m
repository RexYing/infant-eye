function I3 = laplace_of_gaussian_scales(I,sm,tmn,tmx,dt,m)
% Isotropic

if nargin == 1
    sm = 26;    
    tmn = 0.1;
    tmx = 2;
    dt = 0.1;
    m = 'max';
elseif nargin == 2
    tmn = 0.1;
    tmx = 2;
    dt = 0.1;
    m = 'max';
elseif nargin == 3
    tmn = 0.1;
    tmx = 2;
    dt = 0.1;    
    m = 'max';
end

I = double(I);

sm2 = [sm+5,sm+5];
I = padarray(I,sm2,'replicate');

if strcmp(m,'max')
    I3 = -Inf*ones(size(I));
elseif strcmp(m,'min');
    I3 = Inf*ones(size(I));
end

for t = tmn:dt:tmx
    h = fspecial('log',[sm,sm],t);
    I2 = imfilter(I,h,1);
    if strcmp(m,'max')
        I3 = max(I3,I2);
    elseif strcmp(m,'min');
        I3 = min(I3,I2);
    end        
end

I3 = I3 - min(min(I3));
I3 = I3((sm2(1)+1):size(I3,1)-sm2(1),(sm2(2)+1):size(I3,2)-sm2(2));
