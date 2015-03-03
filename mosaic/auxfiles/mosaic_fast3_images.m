function [Mm,Mgb,M,Mg,Mc,R,R4,D,C,H,L,G,F0,t_ff,t_fm] = mosaic_fast3_images(V,nums,bi)

if nargin == 1
    nums = [1,2,3,4,5];
    opt = options_defaults;
    bi = opt.b;
end

opt = option_defaults;
opt.b = bi;
opt.d = 1;

tic;
F0 = cell(length(nums),1);
for i = 1:length(nums)
    F0{i} = V{nums(i)}.frames(1).cdata;
end

D = F0; C = F0; H = F0; L = F0; G = F0;
hh = waitbar(0,'Filtering frames: step 1 of 4');
lf0 = length(F0);
for i = 1:lf0
    [D{i},C{i},H{i},L{i},G{i},B5{i}] = filter_frame(F0{i},opt);
    if i == 1
        P = normalize1(padarray(L{i},[351,351],mode(mode(L{i}))),1);
    end
    Hp{i} = padarray(H{i},[351,351],0);
    if nums(i) < 10
        imwrite(uint8(normalize1(L{i})),strcat(dname,'filtered_image_log_0',num2str(nums(i)),'.png'));
        imwrite(uint8(normalize1(G{i})),strcat(dname,'filtered_image_gabor_0',num2str(nums(i)),'.png'));
    else
        imwrite(uint8(normalize1(L{i})),strcat(dname,'filtered_image_log_',num2str(nums(i)),'.png'));
        imwrite(uint8(normalize1(G{i})),strcat(dname,'filtered_image_gabor_',num2str(nums(i)),'.png'));
    end
    waitbar(i/lf0);
end
close(hh)
t_ff = toc;

size(L)
tic;
hh = waitbar(0,'Registering frames: step 2 of 4');
ll = length(L)-1;
for i = 1:ll
    [R{i},R4{i}] = ...
        registration_phase_full_fast5(normalize1(L{1},1),normalize1(L{i+1},1),...
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
bb = regionprops(B,'BoundingBox');
xn = floor(bb.BoundingBox(2));
xx = ceil(bb.BoundingBox(2)+bb.BoundingBox(4));
yn = floor(bb.BoundingBox(1));
yx = ceil(bb.BoundingBox(1)+bb.BoundingBox(3));
Mc = Mc(xn:xx,yn:yx,:);
Mc = padarray(Mc,[p,p],0);
Mg = Mg(xn:xx,yn:yx,:);
Mg = padarray(Mg,[p,p],1);

opt = option_defaults2;
Mgb = uint8(normalize1(gabor_only2(Mg,opt)));

M = vessel_enhancement(Mc,Mg,0.85);
Mm = mosaic_mix(M,Mgb,0.75);
t_fm = toc;
