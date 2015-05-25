function [  ] = extractEyeRegion( videoObj, outputDir )
%EXTRACTEYEREGION extract eyeregion
%   Detailed explanation goes here

stdFun = @(x) (std(x));

circularHoughThresh = 2.5;

radii = 15:1:40;
radiiGap = 6;

k = 1;
videoObj.CurrentTime = 0;
while hasFrame(videoObj)
    imgo = readFrame(videoObj); % original image
    imSize = size(imgo);
    img = imresize(imgo, 0.25);
    img = colfilt(double(img(:,:,1)), [9 9], 'sliding', stdFun);
    %     im = rgb2gray(img);
    tSize = size(img);
    e = edge(img, 'canny');
    h = circle_hough(e, radii, 'same', 'normalise');
    peak = circle_houghpeaks(h, radii, 'nhoodxy', 15, 'nhoodr', 21, 'npeaks', 1, ...
        'Threshold',circularHoughThresh);
    
    if ~isempty(peak)
        [x, y] = circlepoints(peak(3) + radiiGap); % take more location
        currX = x+peak(1);
        currY = y+peak(2);
        
        flag = (min(currY)>=1) + (max(currY)<=tSize(1)) + (min(currX)>=1) + (max(currX)<=tSize(2));
        if flag==4
            sizeScaleY = imSize(1)/tSize(1);
            sizeScaleX = imSize(2)/tSize(2);
            currY = round(currY*sizeScaleY);
            currX = round(currX*sizeScaleX);
            currY(currY>imSize(1)) = imSize(1);
            currX(currX>imSize(2)) = imSize(2);
            Ym = min(currY);
            YM = max(currY);
            Xm = min(currX);
            XM = max(currX);
%             imco = imgo(Ym:YM,Xm:XM,:);
            imco2 = imgo;
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
            imco = imco2(Ym:YM,Xm:XM,:);
            img2 = rgb2lab(uint8(imco));
            img2 = imfilter(img2(:,:,2),h1);
            maskX = img2>0.5*max(img2(:));
            maskX = imopen(maskX,se);
            imco = double(imco).*repmat(maskX,[1 1 3]);
            %imco2 = colfilt(imco(:,:,1)/sum(sum(imco(:,:,1))),[9 9],'sliding',fun1);
            %tVar = 10000000*mean(imco2(:));
            fc = fc + 1;
            if fc == 1
                prevcf = cf-1;
            end
            
            if abs(cf-prevcf)>3
                imgCnt = 1;
                grp = grp + 1;
            end
            prevcf = cf;
            imwrite(uint8(imco), sprintf('%s/Grp%03d_img%06d.png', outputDir, grp, imgCnt));
%             imwrite(uint8(imco),sprintf('%s/Grp%03d_img%06d_var%s.png',dir2,grp,imgCnt,num2str(tVar)));
%           imwrite(uint8(imco),sprintf('%s/img%06d_var%s.png',dir2,cf,num2str(tVar)));
            imgCnt = imgCnt + 1;
            
            fc = fc + 1;
        end
    end
    
    k = k+1
end


end

