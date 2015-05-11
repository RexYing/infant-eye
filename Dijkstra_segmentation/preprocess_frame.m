function [C,H,B] = preprocess_frame(I,opt)
%CODE FOR THE PAPER
%"Exploratory Dijkstra forest based automatic vessel segmentation: applications in video indirect ophthalmoscopy (VIO)",
%R. Estrada, C. Tomasi, M. T. Cabrera, D.K. Wallace, S.F. Freedman, S. Farsiu
%Biomedical Optics Express, 3(2), pp. 327-339. Feb. 2012. 
%COPYRIGHT 2012, DUKE UNIVERSITY 
%Please contact Rolando Estrada who developed the code under the supervision of Prof. Sina Farsiu and Prof. Carlo Tomasi    if you have questions about the code and dataset.
%restrada@cs.duke.edu
if nargin == 1
    opt = option_defaults;
end
p2 = opt.s1;

P1 = padarray(I,p2);

% Directional local contrast adjustment
C = local_contrast_adjust_green(P1,opt.s1,opt.t1,opt.cf);

% Artificial color removal
C = un_magenta(C,opt.mg1,opt.mg2);

% HSV masking
C2 = imresize(C,0.5);
[H2,B] = remove_retinal_buffer(C2,opt.b,opt.d,opt.r);
H = imresize(H2,2);

C = C((p2(1)+1):(size(C,1)-p2(1)),(p2(2)+1):(size(C,2)-p2(2)),:);
H = H((p2(1)+1):(size(H,1)-p2(1)),(p2(2)+1):(size(H,2)-p2(2)),:);
B = B((p2(1)+1):(size(B,1)-p2(1)),(p2(2)+1):(size(B,2)-p2(2)));
