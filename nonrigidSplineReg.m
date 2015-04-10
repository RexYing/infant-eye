function [ Icor,  Igrid] = nonrigidSplineReg( I1, I2 )
%NONREGIDSPLINEREG Non-rigid B-spline registration using library
%   http://www.mathworks.com/matlabcentral/fileexchange/20057-b-spline-grid--image-and-point-based-registration
%

% Type of registration error used see registration_error.m
options.type='sd';

% Use fast forward instead of central error gradient
options.centralgrad=false;

% Use cubic interpolation
options.interpolation='cubic';

% b-spline grid spacing in x and y direction
Spacing=[32 32];

% Make the Initial b-spline registration grid
[O_trans]=make_init_grid(Spacing,size(I1));

% Convert all values tot type double
I1=double(I1); I2=double(I2); O_trans=double(O_trans); 

% Smooth both images for faster registration
%I1s=imfilter(I1,fspecial('gaussian'))+0.001;
%I2s=imfilter(I2,fspecial('gaussian'))+0.001;
I1s = I1;
I2s = I2;

% Optimizer parameters
optim=struct('Display','iter','GradObj','on','HessUpdate','lbfgs','MaxIter',30,'DiffMinChange',0.03,'DiffMaxChange',1,'TolFun',1e-14,'StoreN',5,'GoalsExactAchieve',0);

% Reshape O_trans from a matrix to a vector.
sizes=size(O_trans); O_trans=O_trans(:);

% Start the b-spline nonrigid registration optimizer
O_trans = fminlbfgs(@(x)bspline_registration_gradient(x,sizes,Spacing,I1s,I2s,options),O_trans,optim);

% Reshape O_trans from a vector to a matrix
O_trans=reshape(O_trans,sizes);

% Transform the input image with the found optimal grid.
Icor=bspline_transform(O_trans,I1,Spacing,3); 

% Make a (transformed) grid image
Igrid=make_grid_image(Spacing,size(I1));
[Igrid, T]=bspline_transform(O_trans,Igrid,Spacing); 

% Show the registration results
figure,
subplot(2,2,1), imshow(uint8(I1), [0, 255]); title('input image 1');
subplot(2,2,2), imshow(uint8(I2), [0, 255]); title('input image 2');
subplot(2,2,3), imshow(uint8(Icor), [0, 255]); title('transformed image 1');
subplot(2,2,4), imshow(Igrid); title('grid');


end

