%% Groups frames that are similar

dir2 = 'data/output';
% nFrames = 990;
% gap = 12;
% 
% dsFactor = 0.25;
% 
% load(sprintf('I:/Postdoctoral Works/From Sina/Project - Neonatal Eye/Datasets/Initial Dataset/video/mat/in%06d.mat',1));
% img = imresize(img,0.25);
% imSizeOrig = size(img);
% img = img(gap:imSizeOrig(1)-gap,gap:imSizeOrig(2)-gap,:);
% imSize = size(img);
% dataSize = [imSize(1)*imSize(2),imSize(3)];
% rowmat = repmat([1:imSize(1)]',[1,imSize(2)]);
% colmat = repmat([1:imSize(2)],[imSize(1),1]);
% h2 = strel('disk',3);
% hh = fspecial('sobel');
% data = zeros(dataSize);
% datahsv = zeros(dataSize);
% img2 = img;
% k = 2;
% radii = 15:1:40;
% radiiGap = 1;
% fc = 0;
% blankImg = uint8(255*ones(255,255));
% 
% thresh = 2.5;


%% grouping k-means + hsv correction + bwlabel based rectangle
% Frame data includes:
%   stack: [n-by-width-by-height-by-3] matrix of frame data
%   fWidth, fHeight: width and height of each frame
%   nFrames: number of frames stored
%load frame_data.mat;

grp = 1;
imgCnt = 1;
opt = option_defaults;
[optimizer, metric]  = imregconfig('multimodal');
prevcf = 0;
for cf = 290:nFrames
    %load(sprintf('I:/Postdoctoral Works/From Sina/Project - Neonatal Eye/Datasets/Initial Dataset/video/mat/in%06d.mat',cf));
    img = squeeze(stack(cf, :, :, :));
    imgo = img;
    img = imresize(imgo,0.25);
    img = img(gap:imSizeOrig(1)-gap,gap:imSizeOrig(2)-gap,:);
    
    %preprocessing
    imghsv = rgb2hsv(img);
    for l = 1:imSize(3)
        tmp = imghsv(:,:,l);
        datahsv(:,l) = tmp(:);
    end
    meanhsv = mean(datahsv);
    indx = datahsv(:,2)<0.2;
    datahsv(indx,2) = meanhsv(2);
    indx2 = datahsv(indx,3)>0.9;
    datahsv2 = datahsv(indx,:);
    datahsv2(indx2,3) = meanhsv(3);
    datahsv(indx,:) = datahsv2;
    for l = 1:imSize(3)
        tmp = datahsv(:,l);
        imghsv(:,:,l) = reshape(tmp,[imSize(1),imSize(2)]);
    end
    imgn = hsv2rgb(imghsv);
    for l = 1:imSize(3)
        tmp = imgn(:,:,l);
        data(:,l) = tmp(:);
    end
    
    %segmentation
    notConverged = 1;
    while notConverged
        try
        [idx,c] = kmeans(data,k);
        notConverged = 0;
        catch ME
            % do nothing
        end
    end
    data2 = data;
    for ck = 1:k
        indx = idx==ck;
        data2(indx,:) = repmat(c(ck,:),[sum(indx),1]);
    end
    for l = 1:imSize(3)
        tmp = data2(:,l);
        img2(:,:,l) = reshape(tmp,[imSize(1),imSize(2)]);
    end
    
    [~,cm] = min(sum(c,2)); %blackish
    imgb = reshape(idx==cm,[imSize(1),imSize(2)]);
    [L,n] = bwlabel(imgb);
    probEyeLocs = [];
    for nc = 1:n
        tmp = L==nc;
        top = min(rowmat(tmp));
        bottom = max(rowmat(tmp));
        left = min(colmat(tmp));
        right = max(colmat(tmp));
        locSize = (bottom-top)*(right-left);
        flag = (top==1) + (bottom==imSize(1)) + (left==1) + (right==imSize(2));
        if (locSize>(dataSize(1)/100)) && (flag<3) % at least 1/10th and not outside regions
            probEyeLocs = [probEyeLocs;top,bottom,left,right];
        end
    end
    

    
    if size(probEyeLocs,1)>0
        selectedRegion = [];
        for tS = 1:size(probEyeLocs,1)
            imc = img(probEyeLocs(tS,1):probEyeLocs(tS,2),probEyeLocs(tS,3):probEyeLocs(tS,4),:);
            im = rgb2gray(imc);
            tSize = size(imc);
            e = edge(im, 'canny');
            h = circle_hough(e, radii, 'same', 'normalise');
            peaks = circle_houghpeaks(h, radii, 'nhoodxy', 15, 'nhoodr', 21, 'npeaks', 1,'Threshold',thresh);
            
           for peak = peaks
                
                [x, y] = circlepoints(peak(3)+radiiGap); % take more location
                currX = x+peak(1);
                currY = y+peak(2);
                
                flag = (min(currY)>=1) + (max(currY)<=tSize(1)) + (min(currX)>=1) + (max(currX)<=tSize(2));
                if flag==4
                    sizeScaleY = size(imgo,1)/size(img,1);
                    sizeScaleX = size(imgo,2)/size(img,2);
                    probEyeLocso = round(probEyeLocs(tS,:)*sizeScaleY);
                    probEyeLocso(3:4) = round(probEyeLocs(tS,3:4)*sizeScaleX);
                    imco = imgo(probEyeLocso(1,1):probEyeLocso(1,2),probEyeLocso(1,3):probEyeLocso(1,4),:);
                    imcoSize = size(imco);
                    currY = round(currY*sizeScaleY);
                    currX = round(currX*sizeScaleX);
                    currY(currY>imcoSize(1)) = imcoSize(1);
                    currX(currX>imcoSize(2)) = imcoSize(2);
                    Ym = min(currY);
                    YM = max(currY);
                    Xm = min(currX);
                    XM = max(currX);
                    imco2 = imco;
                    [~,indx] = sort(x);
                    for cc = 1:length(x)
                        if x(indx(cc))<0
                            if y(indx(cc))<0
                                imco2(1:currY(indx(cc)),1:currX(indx(cc)),:) = 0;
                            else
                                imco2(currY(indx(cc)):end,1:currX(indx(cc)),:) = 0;
                            end
                        else
                            if y(indx(cc))<0
                                imco2(1:currY(indx(cc)),currX(indx(cc)):end,:) = 0;
                            else
                                imco2(currY(indx(cc)):end,currX(indx(cc)):end,:) = 0;
                            end
                        end
                    end
                    
                    selectedRegion = imco2(Ym:YM,Xm:XM,:);
                    Gtarg = filter_image(selectedRegion,opt);
                    
                    fc = fc + 1;
                    if fc == 1
                        prevcf = cf-1;
                    end
                    
                    if abs(cf-prevcf)>3
                        imgCnt = 1;
                        grp = grp + 1;
                    end
                    prevcf = cf;
                    
                    imwrite(selectedRegion, sprintf('%s/Grp%03d_img%06d.png',dir2,grp,imgCnt));
                    imwrite(mat2gray(Gtarg),sprintf('%s/Grp%03d_img%06d_o.png',dir2,grp,imgCnt));
                    imgCnt = imgCnt + 1;
%                     if fc == 1
%                         refImg = selectedRegion;
%                         GtargPrev = Gtarg;c
%                         imwrite(mat2gray(refImg),sprintf('%s/%06d.png',dir2,1));
%                     else
%                         lastwarn('');
%                         try
%                             [movingRegistered,aMovingReg] = imreg2(Gtarg,GtargPrev,'similarity',optimizer, metric,selectedRegion);
%                             error(lastwarn)
%                             GtargPrev = movingRegistered;
%                             %     movingRegistered = imregister(movingRegistered,Gref,'affine',optimizer, metric);
%                             imwrite(mat2gray(aMovingReg),sprintf('%s/Grp%03d_img%06d.png',dir2,grp,imgCnt));
%                             imwrite(mat2gray(movingRegistered),sprintf('%s/Grp%03d_img%06d_o.png',dir2,grp,imgCnt));
%                             imgCnt = imgCnt + 1;
%                         catch ME
%                             fprintf('frame %d not done. Considering new group\n',cf-2);
%                             GtargPrev = Gtarg;
%                             grp = grp + 1;
%                             imgCnt = 1;
%                         end
%                     end
                end
                
            end            
        end
    end
 
    cf
%     pause(0.01);
end

