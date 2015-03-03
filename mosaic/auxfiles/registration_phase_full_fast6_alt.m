function [R,R4,R2,I5,I3,Z1c,Z2c,Z0c,ar,ccr,fs,f,ft2,f1,cc2] = registration_phase_full_fast6_alt(I1,I2,H,k,sx,sy,ds,ds2,md,s,t)
% [R3,mytform,a,dm,cc,sm,mn,f,fs,f1,f3,Z,Z1,Z2,I3,I4,I5,I6,I7] =
% registration_phase_full(I1,I2,k,sx,sy,ds,ds2,md,s,t)

if nargin == 3
    k = 30;
    sx = 30;
    sy = 30;
    ds = 5;
    ds2 = 2;
    md = 15;
    s = 0.25;
%     t = 0.03;
    t = Inf;
elseif nargin == 4
    sx = 30;
    sy = 30;
    ds = 5;
    ds2 = 2;
    md = 15;
    s = 0.25;
%     t = 0.03;
    t = Inf;
end

n3 = round(sx/2);
m3 = round(sy/2);

% ks = 0.85;
ks = 0.95;
N1 = normalize1(I1,1); N1(N1 > ks) = 1;
N2 = normalize1(I2,1); N2(N2 > ks) = 1;
[N5,I3,ar,ccr] = cross_cor_rot_iter5(N1,N2,ds,ds2,md,s);

I1 = normalize1(padarray(I1,[351,351],mode(mode(I1))),1);
I5 = normalize1(padarray(I2,[351,351],mode(mode(I2))),1);
H = padarray(H,[351,351],0);

I5 = imrotate(max(max(I5)) - I5,ar,'crop');
I5 = max(max(I5)) - I5;
I5 = circshift(I5,ccr);

H = imrotate(H,ar,'crop');
H = circshift(H,ccr);

% display_image(I5,5);
% display_image(H,6);

% I5 = shift_matrix2(I5,ccr,(max(max(I5))));
% display_image(I5,5);

% display_image(I5,5);
% display_image(H,4);
% ar
% ccr

f = pick_points(I5,k,sx,sy);

% Z = cell(k,1);
% I9 = I3;
% I10 = I1;
% l = 1;
% dm = zeros(k,1);
% sm = zeros(k,1);
% mn = zeros(k,1);
fs = zeros(k,2);
ft2 = zeros(k,2);
l = 1;
cc2 = zeros(k,2);
for i = 1:k
    cx = f(i,1); cy = f(i,2);
%     Z1 = I1(max(cx-sx,1):min(cx+sx,size(I1,1)),max(cy-sy,1):min(cy+sy,size(I1,2)));
    Z1 = I1(max(cx-(sx+round(sx/2))+1,1):min(cx+(sx+round(sx/2)),size(I1,1)),...
        max(cy-(sy+round(sy/2))+1,1):min(cy+(sy+round(sy/2)),size(I1,2)));
    Z1c{i} = Z1;
    Z2 = I5(max(cx-sx+1,1):min(cx+sx,size(I5,1)),max(cy-sy+1,1):min(cy+sy,size(I5,2)));
%     Z2 = I5(max(cx-round(sx/2)+1,1):min(cx+round(sx/2),size(I3,1)),max(cy-round(sy/2)+1,1):min(cy+round(sy/2),size(I3,2)));
    Z2 = padarray(Z2,[round(sx/2),round(sy/2)],max(max(Z2)));
    Z2c{i} = Z2;
%     [Z{i},f1(i,:),R,dm(i),sm(i),mn(i)] = cross_corr_phase(Z1{i},Z2{i},n3,m3);
    if size(Z1) == size(Z2)
        [Z0,f1(i,:),R,dm(i),sm(i)] = cross_corr(Z1,Z2,n3,m3);
        Z0c{i} = Z0;
%         [Z,C,cc,cc2(i,:),mc(i)] = cross_cor_phase(Z1,Z2,1);
%         Zc{i} = Z;
%         dm(i)
        if dm(i) < t
            fs(l,:) = f(i,:);
    %         ft(l,:) = f(i,:) + cc2(i,:);
    %         ft2(l,:) = f(i,:) + f1(i,:);
%             ft(l,:) = f(i,:) + [cc2(i,2),cc2(i,1)];
            ft2(l,:) = f(i,:) + [f1(i,1),f1(i,2)];
            l = l+1;

    %       ft(l,:) = cc2;
    %       l = l+1;
    % %     dm(i)
    % %     if dm(i) < 2
    % %         fs(l,:) = [cx+f1(i,1),cy+f1(i,2)];
    % %         f3(l,:) = [cx,cy];
    % %         I9(f(i,1),f(i,2)) = 1.5*max(max(I5));
    % %         I10(max(fs(l,1),1),max(fs(l,2),1)) = 1.5*max(max(I1));
    %         l = l+1;
        end
    end
end
fs = fs(1:(l-1),:);
% ft = ft(1:(l-1),:);
ft2 = ft2(1:(l-1),:);

% length(fs)
% f = [f(:,2),f(:,1)];
% fs = [fs(:,2),fs(:,1)];
% f3 = [f3(:,2),f3(:,1)];
% fs = [fs(:,2),fs(:,1)];

% trans = 'linear conformal';
% trans1 = 'affine';
% trans2 = 'projective';
% trans3 = 'polynomial';
% trans4 = 'piecewise linear';
% trans = 'lwm';

fs = [fs(:,2),fs(:,1)];
ft2 = [ft2(:,2),ft2(:,1)];
% ft = [ft(:,2),ft(:,1)];
% R3 = I5;
% mytform = cp2tform(ft, fs, trans);
% mytform3 = cp2tform(fs, ft2, trans);

% T31 = cp2tform(fs, ft2, trans1);
% T32 = cp2tform(fs, ft2, trans2);
% T33 = cp2tform(fs, ft2, trans3);
% T34 = cp2tform(fs, ft2, trans4);

% [R3 xdata ydata] = imtransform(I5, mytform,'FillValues', max(max(I5)),...
%     'XData', [1 size(I1,2)],'YData', [1 size(I1,1)]);
% 
% [R41 xdata ydata] = imtransform(I1, mytform2,'FillValues', max(max(I5)),...
%     'XData', [1 size(I1,2)],'YData', [1 size(I1,1)]);
% 
% [R42 xdata ydata] = imtransform(I5, mytform3,'FillValues', max(max(I5)),...
%     'XData', [1 size(I1,2)],'YData', [1 size(I1,1)]);
% 
% [R43 xdata ydata] = imtransform(I1, mytform3,'FillValues', max(max(I5)),...
%     'XData', [1 size(I1,2)],'YData', [1 size(I1,1)]);

A2 = affine_inverse(fs,ft2);
% [A1,A2] = steepest_descent(fs,ft2,2000,0.0001,0.002,0.001);

T2 = maketform('affine',A2);
% T2 = maketform('affine',A2);

% Rs{1} = I5;

[R2 xdata ydata] = imtransform(I5, T2,'FillValues', max(max(I5)),...
    'XData', [1 size(I1,2)],'YData', [1 size(I1,1)]);

df(1) = sum(sum(abs(I1 - R2)));
df(2) = sum(sum(abs(I1 - I5)));

[si,sj] = min(df);

if sj == 1
    R = R2;
    R4 = imtransform(H, T2,'FillValues', 0,...
        'XData', [1 size(H,2)],'YData', [1 size(H,1)]);
elseif sj == 2
    R = I5;
    R4 = H;
end

% [R3a xdata ydata] = imtransform(I5, T31,'FillValues', max(max(I5)),...
%     'XData', [1 size(I1,2)],'YData', [1 size(I1,1)]);
% 
% [R3pr xdata ydata] = imtransform(I5, T32,'FillValues', max(max(I5)),...
%     'XData', [1 size(I1,2)],'YData', [1 size(I1,1)]);
% 
% [R3pl xdata ydata] = imtransform(I5, T33,'FillValues', max(max(I5)),...
%     'XData', [1 size(I1,2)],'YData', [1 size(I1,1)]);
% 
% [R3l xdata ydata] = imtransform(I5, T34,'FillValues', max(max(I5)),...
%     'XData', [1 size(I1,2)],'YData', [1 size(I1,1)]);


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
