function [I5,I3,a,t,da] = cross_cor_rot_iter5(I1,I2,ds,ds2,md,s)
% Works best for LoG images.

if nargin == 2
    ds = 5;
    ds2 = 2;
    md = 15;
    s = 0.25;
end


da = -Inf;
k = 1;
for i = -md:ds:md
    if i ~= 0
        R2 = imrotate(I2,i,'crop');
        R2 = max(max(R2)) - R2;
        R2 = imclearborder(R2);
        R2 = max(max(R2)) - R2;
    else
        R2 = normalize1(I2,1);
    end
    [I4,C,cc,cc2] =  cross_cor_phase(I1,R2,s);
    dm2 = max(max(C));
    if da < dm2
        da = dm2;
        a = i;
        I3 = I4;
        t = cc2;
    end
    k = k + 1;
end

I5 = I3;
k = 1;
for i = (a-ds2):(a+ds2)
    if i ~= 0
        R2 = imrotate(I2,i,'crop');
        R2 = max(max(R2)) - R2;
        R2 = imclearborder(R2);
        R2 = max(max(R2)) - R2;
    else
        R2 = normalize1(I2,1);
    end
    [I6,C,cc,cc2] =  cross_cor_phase(I1,R2,s);
    dm3 = max(max(C));
    if da < dm3
        da = dm3;
        a = i;
        I5 = I6;
        t = cc2;
    end
    k = k + 1;
end
