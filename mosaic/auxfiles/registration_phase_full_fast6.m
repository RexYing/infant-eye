function [R,R4,R2,I5,I3,Z1c,Z2c,Z0c,ar,ccr,fs,f,ft2,f1,cc2] = registration_phase_full_fast6(I1,I2,H,k,sx,sy,ds,ds2,md,s,t,p)

if nargin == 3
    k = 30;
    sx = 30;
    sy = 30;
    ds = 5;
    ds2 = 2;
    md = 15;
    s = 0.25;
    t = Inf;
    p = [351,351];
elseif nargin == 4
    sx = 30;
    sy = 30;
    ds = 5;
    ds2 = 2;
    md = 15;
    s = 0.25;
    t = Inf;
    p = [351,351];
end

n3 = round(sx/2);
m3 = round(sy/2);

ks = 0.95;
N1 = normalize1(I1,1); N1(N1 > ks) = 1;
N2 = normalize1(I2,1); N2(N2 > ks) = 1;
[N5,I3,ar,ccr] = cross_cor_rot_iter5(N1,N2,ds,ds2,md,s);

I1 = normalize1(padarray(I1,p,mode(mode(I1))),1);
I5 = normalize1(padarray(I2,p,mode(mode(I2))),1);
H = padarray(H,p,0);

I5 = imrotate(max(max(I5)) - I5,ar,'crop');
I5 = max(max(I5)) - I5;
I5 = circshift(I5,ccr);

H = imrotate(H,ar,'crop');
H = circshift(H,ccr);

f = pick_points(I5,k,sx,sy);

fs = zeros(k,2);
ft2 = zeros(k,2);
l = 1;
cc2 = zeros(k,2);
for i = 1:k
    cx = f(i,1); cy = f(i,2);
    Z1 = I1(max(cx-(sx+round(sx/2))+1,1):min(cx+(sx+round(sx/2)),size(I1,1)),...
        max(cy-(sy+round(sy/2))+1,1):min(cy+(sy+round(sy/2)),size(I1,2)));
    Z1c{i} = Z1;
    Z2 = I5(max(cx-sx+1,1):min(cx+sx,size(I5,1)),max(cy-sy+1,1):min(cy+sy,size(I5,2)));
    Z2 = padarray(Z2,[round(sx/2),round(sy/2)],max(max(Z2)));
    Z2c{i} = Z2;
    if size(Z1) == size(Z2)
        [Z0,f1(i,:),R,dm(i),sm(i)] = cross_corr(Z1,Z2,n3,m3);
        Z0c{i} = Z0;
        if dm(i) < t
            fs(l,:) = f(i,:);
            ft2(l,:) = f(i,:) + [f1(i,1),f1(i,2)];
            l = l+1;
        end
    end
end
fs = fs(1:(l-1),:);
ft2 = ft2(1:(l-1),:);

fs = [fs(:,2),fs(:,1)];
ft2 = [ft2(:,2),ft2(:,1)];

A2 = affine_inverse(fs,ft2);

T2 = maketform('affine',A2);

[R2 xdata ydata] = imtransform(I5, T2,'FillValues', max(max(I5)),...
    'XData', [1 size(I1,2)],'YData', [1 size(I1,1)]);

df(1) = sum(sum(abs(I1 - R2)));
df(2) = sum(sum(abs(I1 - I5)));

[si,sj] = min(df);

df
sj = 1;
if sj == 1
    R = R2;
    R4 = imtransform(H, T2,'FillValues', 0,...
        'XData', [1 size(H,2)],'YData', [1 size(H,1)]);
elseif sj == 2
    R = I5;
    R4 = H;
end

function [p,I,I2] = pick_points(I,k,sx,sy)
I2 = I;
m = max(max(I));
p = zeros(k,2);
for i = 1:k
    [cx,cy] = find(I == min(min(I)),1);
    I(cx,cy) = max(max(I));
    I(max(cx-sx,1):min(cx+sx,size(I,1)),max(cy-sy,1):min(cy+sy,size(I,2))) = m;
    p(i,:) = [cx,cy];
    I2(cx,cy) = 1.5*m;
end
