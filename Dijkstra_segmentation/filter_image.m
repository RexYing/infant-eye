function G = filter_image(I,opt)
%CODE FOR THE PAPER
%"Exploratory Dijkstra forest based automatic vessel segmentation: applications in video indirect ophthalmoscopy (VIO)",
%R. Estrada, C. Tomasi, M. T. Cabrera, D.K. Wallace, S.F. Freedman, S. Farsiu
%Biomedical Optics Express, 3(2), pp. 327-339. Feb. 2012. 
%COPYRIGHT 2012, DUKE UNIVERSITY 
%Please contact Rolando Estrada who developed the code under the supervision of Prof. Carlo Tomasi and Prof. Sina Farsiu if you have questions about the code and dataset.
%restrada@cs.duke.edu
if nargin == 1
    opt = option_defaults;
end
p2 = opt.s1;
s = opt.s;
w = opt.w;
p = opt.p;

if length(p2) == 1
    p2 = [p2,p2];
end

P1 = padarray(I,p2);
[P1,B] = border_extend(P1,s,w,p);
B3 = uint8(imfill(B,'holes'));
B4 = uint8(imerode(B3,strel('disk',2)));
L = log_filter(P1,opt);
L(B4 == 0) = max(max(L));
L = normalize_image(L,1);

opt.bankScale = 0.5;
G_5 = gabor_filter(L,opt);
G_5 = normalize_image(G_5,1);

opt2 = opt; opt2.bankScale = 0.75;
G_7 = gabor_filter(L,opt2);
G_7 = normalize_image(G_7,1);
G = normalize_image(G_5.*G_7,1);
G = G((p2(1)+1):(size(G,1)-p2(1)),(p2(2)+1):(size(G,2)-p2(2)));
