close all
eyeregion = imread('result_Man_IN_2.tif');

%% Filter
f1 = fspecial('gaussian', 10, 4);
f2 = fspecial('laplacian');
%img = double(rgb2gray(frame));
img = double(rgb2gray(eyeregion));
response = imfilter(imfilter(img, f1), f2);
imshow(response);

bw = response > 0.1;
bwskel = bwmorph(bw,'skel',5);
figure
colormap gray
imagesc(bwskel);

%%
img = 255 - img;
img = double(imread('Fundus_photograph_of_normal_left_eye.tif'));
gaborArray = gaborFilterBank(1, 5,8,39,39);
featureVector = gaborFeatures(img,gaborArray,1,1);
response = abs(conv2(img,gaborArray{1,1},'same'));
for i = 1: 5
    for j = 1: 8
        curr = abs(conv2(img,gaborArray{i,j},'same'));
        response(response < curr) = 0;
        new = curr(curr > response);
        curr(curr <= response) = 0;
        if ~isempty(new)
            response = response + curr;
        end
    end
end
figure
colormap gray
imagesc(response);