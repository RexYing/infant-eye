function [D,C,H,L,G,B5] = filter_frame_extend(I,opt,p2,s,w,p)
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
    opt = option_defaults;
    p2 = [5,5];
    s = 10;
    w = 7;
    p = 5;
elseif nargin == 2
    p2 = [5,5];
    s = 10;
    w = 7;
    p = 5;    
elseif nargin ==3
    s = 10;
    w = 7;
    p = 5;        
end

if length(p2) == 1
    p2 = [p2,p2];
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
P1 = padarray(H(:,:,2),p2);
[P1,B] = border_extend2(P1,s,w,p);
B3 = uint8(imfill(B,'holes'));
B4 = uint8(imerode(B3,strel('disk',2)));
L0 = laplace_of_gaussian_scales(P1,opt.kernelSize,opt.sigmaMin,...
    opt.sigmaMax,opt.sigmaStepSize,'min');
L0(B4 == 0) = max(max(L0));
L = normalize1(L0,1);

L = L((p2(1)+1):(size(L,1)-p2(1)),(p2(2)+1):(size(L,2)-p2(2)));
B = B((p2(1)+1):(size(B,1)-p2(1)),(p2(2)+1):(size(B,2)-p2(2)));

% Gabor filtering
G = gabor_convolve(L,opt.orientations,...
    opt.gaborSigmaX,opt.gaborSigmaY,opt.frequency,...
    opt.gaborKernelSize,opt.bankScale);
G = normalize1(G,1);
m = median(median(G));
G2 = G; G2(G > m) = m;
G = G2;