function [Mm,Mgb,M,Mg,Mc,R,R4,D,C,H,L,G,F0,t_ff,t_fm] = mosaic_fast4_images(dname,V,nums,bi,d)

if nargin == 1
    nums = [1,2,3,4,5];
    opt = options_defaults;
    bi = opt.b;
end

opt = option_defaults;
opt.b = bi;
opt.d = d;

tic;

F0 = cell(length(nums),1);
for i = 1:length(nums)
    F0{i} = V{nums(i)};
end

D = F0; C = F0; H = F0; L = F0; G = F0;
hh = waitbar(0,'Filtering frames: step 1 of 4');
lf0 = length(F0);
for i = 1:lf0
    [D{i},C{i},H{i},L{i},G{i},B5{i}] = filter_frame_extend(F0{i},opt,[5,5]);
    if i == 1
        P = normalize1(padarray(L{i},[351,351],mode(mode(L{i}))),1);
    end
    Hp{i} = padarray(H{i},[351,351],0);
    waitbar(i/lf0);
end
close(hh)
t_ff = toc;

tic;
hh = waitbar(0,'Registering frames: step 2 of 4');
ll = length(L)-1;
for i = 1:ll
    [R{i},R4{i}] = ...
        registration_phase_full_fast6(normalize1(L{1},1),normalize1(L{i+1},1),...
        H{i+1},30,20,20,5,2,15,0.25,0.03);
    waitbar(i/ll);
end
close(hh);

Mg = normalize1(P,1);
Mc = double(Hp{1});
a = -0.025;
Mc = feather_single(Mc,a);
hh = waitbar(0,'Fusing frames: step 3 of 4');
lr = length(R);
for i = 1:lr
    Mg = normalize1(min(Mg,R{i}),1);
    Mc2 = feather_single(double(R4{i}),a);
    Mc = max(Mc,Mc2);
    waitbar(i/lr);
end
close(hh);

% Trim borders
p = 20;
B = bwlabel(max(Mc > 0,[],3));
b0 = regionprops(B,'BoundingBox');
b02 = b0(1).BoundingBox;
for i = 2:length(b0)
    b03 = b0(i).BoundingBox;
    b02(1) = max(1,min(b02(1),b03(1)));
    b02(2) = max(1,min(b02(2),b03(2)));
    b02(3) = max(b02(3),b03(3));
    b02(4) = max(b02(4),b03(4));
end
xn = floor(b02(2));
xx = ceil(b02(2)+b02(4));
yn = floor(b02(1));
yx = ceil(b02(1)+b02(3));

Mc = Mc(xn:xx,yn:yx,:);
Mc = padarray(Mc,[p,p],0);
Mg = Mg(xn:xx,yn:yx,:);
Mg = padarray(Mg,[p,p],1);

opt = option_defaults2;
Mgb = uint8(normalize1(gabor_only2(Mg,opt)));

M = vessel_enhancement(Mc,Mg,0.85);
Mm = mosaic_mix(M,Mgb,0.75);
imwrite(Mm,strcat(dname,'mosaic_mix_075.png'));

imwrite(uint8(Mc),strcat(dname,'mosaic_color_only.png'));
imwrite(M,strcat(dname,'mosaic_color_enhanced.png'));
imwrite(Mgb,strcat(dname,'mosaic_gabor.png'));
t_fm = toc;
