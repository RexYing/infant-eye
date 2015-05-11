function L = log_filter(I,opt)
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

if size(I,3) == 3
    I = I(:,:,2);
end

L = log_scales(I,opt.kernelSize,opt.sigmaMin,...
    opt.sigmaMax,opt.sigmaStepSize,'min');
L = normalize_image(L,1);
