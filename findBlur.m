dirIn = 'data/eyeregions_all';
dirOut = 'data/eyeregions_blur_metric';

%%

img = imread(sprintf('%s/Grp001_img000001.png', dirIn));
blurMetric(rgb2gray(img))
img = imread(sprintf('%s/Grp001_img000079.png', dirIn));
blurMetric(rgb2gray(img))
img = imread(sprintf('%s/Grp001_img000080.png', dirIn));
blurMetric(rgb2gray(img))

%% S3
img = imread(sprintf('%s/Grp001_img000001.png', dirIn));
[s_map1 s_map2 s3] = s3_map(double(rgb2gray(img)), true);
sum(s_map1(:) == 0)
img = imread(sprintf('%s/Grp001_img000079.png', dirIn));
[s_map1 s_map2 s3] = s3_map(double(rgb2gray(img)), false);
sum(s_map1(:) == 0)
img = imread(sprintf('%s/Grp001_img000080.png', dirIn));
[s_map1 s_map2 s3] = s3_map(double(rgb2gray(img)), false);
sum(s_map1(:) == 0)


%% find clear images among exported eyeregion images

fileInfo = dir([dirIn,'/*.png']);
nImgs = length(fileInfo);

blurMetricThreshold = 0.32;
for i = 1:nImgs
    filename = fileInfo(i).name
    img=imread([dirIn,'/', filename]);
    
    filename = filename(1: end-4); % no extension .png
    blurness = blurMetric(rgb2gray(img));
    if blurness >= blurMetricThreshold
        imwrite(img, sprintf('%s/%s_blur%.4d.png', dirOut, filename, blurness));
    end
end