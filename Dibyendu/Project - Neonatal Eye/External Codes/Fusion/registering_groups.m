dir1 = 'fused1';
a = dir([dir1,'/*.png']); % For filtered images
% a = dir([dir1,'/*.png']);
len = length(a);
% For original images
% a = a(cellfun(@isempty,cellfun(@strfind,{a(:).name}',repmat({'_o'},length(a),1),'UniformOutput',0)));

% prepare the parameters
SIFTflowpara.alpha=2;
SIFTflowpara.d=40;
SIFTflowpara.gamma=0.005;
SIFTflowpara.nlevels=4;
SIFTflowpara.wsize=5;
SIFTflowpara.topwsize=20;
SIFTflowpara.nIterations=60;

im1=imread([dir1,'/',a(1).name]);
im1 = imfilter(im1,fspecial('gaussian',7,1.));
im1=im2double(im1);
Sift1=dense_sift(im1,patchsize,gridspacing);
Im1=im1(patchsize/2:end-patchsize/2+1,patchsize/2:end-patchsize/2+1,:);
imwrite(Im1,sprintf('fused_reg1/Grp%03d.png',1));
for cf = 2:len
    
        im2=imread([dir1,'/',a(cf).name]);
        
        
        im2 = imfilter(im2,fspecial('gaussian',7,1.));
        %     im1=imresize(imfilter(im1,fspecial('gaussian',7,1.),'same','replicate'),0.5,'bicubic');
        %     im2=imresize(imfilter(im2,fspecial('gaussian',7,1.),'same','replicate'),0.5,'bicubic');
        
        
        im2=im2double(im2);
        
        
        % Step 2. Compute the dense SIFT image
        
        % patchsize is half of the window size for computing SIFT
        % gridspacing is the sampling precision
        
        patchsize=8;
        gridspacing=1;
        
        
        Sift2=dense_sift(im2,patchsize,gridspacing);
        
        % % visualize the SIFT image
        % figure;imshow(showColorSIFT(Sift1));title('SIFT image 1');
        % figure;imshow(showColorSIFT(Sift2));title('SIFT image 2');
        
        % Step 3. SIFT flow matching
        
        
        
        tic;[vx,vy,energylist]=SIFTflowc2f(Sift1,Sift2,SIFTflowpara);toc
        
        % Step 4.  Visualize the matching results
        
        Im2=im2(patchsize/2:end-patchsize/2+1,patchsize/2:end-patchsize/2+1,:);
        warpI2=warpImage(Im2,vx,vy);
%         im1 = warpI2;
        
        imwrite(warpI2,sprintf('fused_reg1/Grp%03d.png',cf));
   
end
