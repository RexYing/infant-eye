function [G,Gt] = gabor_filter(L,opt)
%CODE FOR THE PAPER
%"Exploratory Dijkstra forest based automatic vessel segmentation: applications in video indirect ophthalmoscopy (VIO)",
%R. Estrada, C. Tomasi, M. T. Cabrera, D.K. Wallace, S.F. Freedman, S. Farsiu
%Biomedical Optics Express, 3(2), pp. 327-339. Feb. 2012. 
%COPYRIGHT 2012, DUKE UNIVERSITY 
%Please contact Rolando Estrada who developed the code under the supervision of Prof. Sina Farsiu and Prof. Carlo Tomasi    if you have questions about the code and dataset.
%restrada@cs.duke.edu
[G,Gt] = gabor_convolve(L,opt.orientations,...
    opt.gaborSigmaX,opt.gaborSigmaY,opt.frequency,...
    opt.gaborKernelSize,opt.bankScale);
G = normalize_image(G,1);
m = median(median(G));
G(G > m) = m;
