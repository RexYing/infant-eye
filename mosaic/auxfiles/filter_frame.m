function [D,C,H,L,G,B5] = filter_frame(I,opt)
%
% FILTER FRAME
% Applies local contrast adjustment, HSV masking, Laplacian-of-Gaussian
% filtering and Gabor filtering to the input image I.
%
%
% Input:
%   F   An RGB image
%
% Output:
%   C   The local contrast image
%   H   The HSV masked image
%   G   The Gabor-filtered image
%   L   The Laplacian-of-Gaussian image

if nargin == 1
    opt.sig = 0.3;
    opt.k = 0.5;
    opt.s1 = [50,50];
    opt.t1 = 1.15;
    opt.cf = 'max';
    opt.mg1 = 0.7;
    opt.mg2 = 0;
    opt.sigmaMax = 0.51;
    opt.sigmaMin = 0.11;
    opt.sigmaStepSize = 0.1;
    opt.kernelSize = 26;
    opt.orientations = 10;
    opt.gaborSigmaX = 10;
    opt.gaborSigmaY = 10;
    opt.frequency = 0.05;
    opt.gaborKernelSize = 60;
    opt.bankScale = 0.5;
    opt.b(1) = 0.1;
    opt.b(2) = 0.9;
    opt.b(3) = -1;
    opt.b(4) = 2;
    opt.b(5) = 0.1;
    opt.b(6) = 2;    
    opt.d = 1;
    opt.r = 5;    
end

% Deinterlacing
D = deinterlacingc(I,opt.sig,opt.k);

% Directional local contrast adjustment
C = local_contrast_adjust_green(D,opt.s1,opt.t1,opt.cf);

% Artificial color removal
C = un_magenta_basic2(C,opt.mg1,opt.mg2);

% HSV masking
C2 = imresize(C,0.5);
[H2,B5] = remove_retinal_buffer_fast(C2,opt.b,opt.d,opt.r);
B5 = imresize(B5,2);
H = imresize(H2,2);

% LoG filtering
L0 = laplace_of_gaussian_scales(H(:,:,2),opt.kernelSize,opt.sigmaMin,...
    opt.sigmaMax,opt.sigmaStepSize,'min');
L = normalize1(max(L0,double((max(max(L0)))*B5)));

% Gabor filtering
G = gabor_convolve(L,opt.orientations,...
    opt.gaborSigmaX,opt.gaborSigmaY,opt.frequency,...
    opt.gaborKernelSize,opt.bankScale);
G = normalize1(G,1);
m = median(median(G));
G = max(G,m*double(B5));
G2 = G; G2(G > m) = m;
G = max(G2,max(max(G2))*double(B5));
