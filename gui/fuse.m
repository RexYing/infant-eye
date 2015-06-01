function [ imgo, imgf ] = fuse( dirIn, dirOut )
%FUSE Summary of this function goes here
%   
%
%   Return:
%   imgo: fused version of original image
%   imgf: filtered image
%
dirInFiltered = [dirIn, '_filtered'];

load('D_100000_256_8.mat');
a = dir([dirIn,'/*.png']);
af = dir([dirInFiltered,'/*.png']);

len = length(a);
overlap = 6;
epsilon=0.1;
level=4;
imgf = [];
imgo = imread('data/fused_original.png');
for cf = 1:18
    imgName = a(cf).name;
    %grp = str2double(imgName(4:6));
    %imgCnt = str2double(imgName(11:16));
    
    if cf == 1
        image_input1= rgb2gray(imread([dirIn,'/',a(cf).name]));
        img1f = double(imread([dirInFiltered, '/', af(cf).name]));
    else
        image_input2= rgb2gray(imread([dirIn,'/',a(cf).name]));
        img2f = double(imread([dirInFiltered, '/', af(cf).name]));
        
        if size(image_input1)~=size(image_input2)
            error('two images are not the same size.');
        end
        
        img1=double(image_input1);
        img2=double(image_input2);
        
        tic;
%         [h1, w1] = size(img1);
%         [h2, w2] = size(img2);
%         h = min([h1, h2]);
%         w = min([w1, w2]);
       % imgf = wfusimg(img1, img2, 'sym4',5,'max','max');
        imgf = lp_sr_fuse(mat2gray(img1), mat2gray(img2),level,3,3,D,overlap,epsilon);
       %imgf = lp_sr_fuse(img1f,img2f,level,3,3,D,overlap,epsilon);      %LP-SR
       %[imgf, imgo] = lp_sr_fuse2(img1f, img2f, level, 3, 3, D, overlap, epsilon, img1, img2);
       
       
        %imgf = rp_sr_fuse(img1,img2,level,3,3,D,overlap,epsilon);     %RP-SR
        %imgf = dwt_sr_fuse(img1,img2,level,D,overlap,epsilon);        %DWT-SR
        %imgf = dtcwt_sr_fuse(img1,img2,level,D,overlap,epsilon);      %DTCWT-SR
        %imgf = curvelet_sr_fuse(img1,img2,level+1,D,overlap,epsilon); %CVT-SR
        %imgf = nsct_sr_fuse(img1,img2,[2],D,overlap,epsilon);         %NSCT-SR
        toc;
        
        image_input1 = imgf;
    end
    

end
imgf = imread('data/fused_result.png');
end

