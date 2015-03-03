%
% Mosaicing script

image_dir = 'images_dir\';
destination_dir = 'destination_dir\';
mkdir(destination_dir);

% Read input images
d = dir(image_dir);
images = cell(length(d)-2,1);
for i = 3:length(d)
    images{i-2} = imread(strcat(image_dir,d(i).name));
end

% Hue-saturation-value interval
hsv_interval = [0.7673    0.3673    0.2583    0.8583    0.4752    1.0752];

% Mosaic the images
[Mm,Mgb,M,Mg,Mc] = mosaic_images(destination_dir,images,hsv_interval);
