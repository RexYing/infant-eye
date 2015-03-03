
dname = 'C:\Users\Rolando\Documents\Postdoc\Research\Mosaicing_images_gui\fwmosaic\';
d = dir([dname,'*.JPG']);

I = cell(numel(d),1);
for i = 1:numel(d)
    I{i} = imread([dname,d(i).name]);
end

dname3 = [dname,'mosaics5\'];
mkdir(dname3);
f = 1:4;
% bi3 = I{1}(500,500,:);
% 
%  0.8741    0.1741    0.7226    1.0226    0.7706    1.0706
% 
% 
% ans =
% 
%     0.8241    0.2241    0.6726    1.0726    0.7206    1.1206


% bi3 = [0.7241    0.3241    0.5726    1.1726    0.6206    1.2206];

bi3 = [0.7216    0.3216    0.5035    1.1035    0.6820    1.2820];
tic
[Mm,Mgb,M,Mg,Mc,R,R4,H,L,G,F0,t_ff,t_fm] = mosaic_fast5_images(dname3,I,f,bi3,1);
toc

% [Mm,Mgb,M,Mg,Mc] = mosaic_fast5_images(dname3,I,f,bi3,1);

% display_image(M,1);

