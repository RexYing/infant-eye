
addpath(genpath('sparsefusion'));
addpath(genpath('dtcwt_toolbox'));
addpath(genpath('fdct_wrapping_matlab'));
addpath(genpath('nsct_toolbox'));

load('sparsefusion/Dictionary/D_100000_256_8.mat');

% dir1 = 'I:/Postdoctoral Works/Image Registration/Siftflow/SIFT-Flow/fused_reg';
% dir2 = 'I:/Postdoctoral Works/Image Registration/Siftflow/SIFT-Flow/fused_reg';
dir1 = '../fused_reg1';
dir2 = '../fused_reg1';
a = dir([dir1,'/*.png']);
len = length(a);
overlap = 6;
epsilon=0.1;
level=4;
imgf = [];
for cf = 1:len
    
    if cf == 1
        image_input1=imread([dir1,'/',a(cf).name]);
    else
        image_input2=imread([dir1,'/',a(cf).name]);
        
        if size(image_input1)~=size(image_input2)
            error('two images are not the same size.');
        end
        
        img1=double(image_input1);
        img2=double(image_input2);
        
        
        
        tic;
        %imgf = wfusimg(img1, img2, 'sym4',5,'max','max');
        imgf = lp_sr_fuse(img1,img2,level,3,3,D,overlap,epsilon);      %LP-SR
        %imgf = rp_sr_fuse(img1,img2,level,3,3,D,overlap,epsilon);     %RP-SR
        %imgf = dwt_sr_fuse(img1,img2,level,D,overlap,epsilon);        %DWT-SR
        %imgf = dtcwt_sr_fuse(img1,img2,level,D,overlap,epsilon);      %DTCWT-SR
        %imgf = curvelet_sr_fuse(img1,img2,level+1,D,overlap,epsilon); %CVT-SR
        %imgf = nsct_sr_fuse(img1,img2,[2],D,overlap,epsilon);         %NSCT-SR
        toc;
        
        image_input1 = imgf;
    end
    
end
imwrite(mat2gray(imgf),sprintf('%s/FinalReg.png',dir2));

