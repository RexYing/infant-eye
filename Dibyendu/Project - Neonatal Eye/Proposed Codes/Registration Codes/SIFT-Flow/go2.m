dir1 = 'data_sup';
a = dir([dir1,'/*.png']);
len = length(a);

im1=imread([dir1,'/',a(3).name]);

for cf = 4:len
    im2=imread([dir1,'/',a(cf).name]);
    
    im1 = imfilter(im1,fspecial('gaussian',7,1.));
    im2 = imfilter(im2,fspecial('gaussian',7,1.));
%     im1=imresize(imfilter(im1,fspecial('gaussian',7,1.),'same','replicate'),0.5,'bicubic');
%     im2=imresize(imfilter(im2,fspecial('gaussian',7,1.),'same','replicate'),0.5,'bicubic');
    
    im1=im2double(im1);
    im2=im2double(im2);
    
    
    % Step 2. Compute the dense SIFT image
    
    % patchsize is half of the window size for computing SIFT
    % gridspacing is the sampling precision
    
    patchsize=8;
    gridspacing=1;
    
    Sift1=dense_sift(im1,patchsize,gridspacing);
    Sift2=dense_sift(im2,patchsize,gridspacing);
    
    % % visualize the SIFT image
    % figure;imshow(showColorSIFT(Sift1));title('SIFT image 1');
    % figure;imshow(showColorSIFT(Sift2));title('SIFT image 2');
    
    % Step 3. SIFT flow matching
    
    % prepare the parameters
    SIFTflowpara.alpha=2;
    SIFTflowpara.d=40;
    SIFTflowpara.gamma=0.005;
    SIFTflowpara.nlevels=4;
    SIFTflowpara.wsize=5;
    SIFTflowpara.topwsize=20;
    SIFTflowpara.nIterations=60;
    
    tic;[vx,vy,energylist]=SIFTflowc2f(Sift1,Sift2,SIFTflowpara);toc
    
    % Step 4.  Visualize the matching results
    Im1=im1(patchsize/2:end-patchsize/2+1,patchsize/2:end-patchsize/2+1,:);
    Im2=im2(patchsize/2:end-patchsize/2+1,patchsize/2:end-patchsize/2+1,:);
    warpI2=warpImage(Im2,vx,vy);
    im1 = warpI2;
    
    imwrite(warpI2,sprintf('op/%05d.png',cf-2));
end
