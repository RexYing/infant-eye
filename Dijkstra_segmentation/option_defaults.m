function opt = option_defaults
%CODE FOR THE PAPER
%"Exploratory Dijkstra forest based automatic vessel segmentation: applications in video indirect ophthalmoscopy (VIO)",
%R. Estrada, C. Tomasi, M. T. Cabrera, D.K. Wallace, S.F. Freedman, S. Farsiu
%Biomedical Optics Express, 3(2), pp. 327-339. Feb. 2012. 
%COPYRIGHT 2012, DUKE UNIVERSITY 
%Please contact Rolando Estrada who developed the code under the supervision of Prof. Sina Farsiu and Prof. Carlo Tomasi    if you have questions about the code and dataset.
%restrada@cs.duke.edu
opt.sig = 0.3;
opt.k = 0.5;
opt.s1 = [50,50];
opt.t1 = 1.15;
opt.cf = 'max';
opt.mg1 = 0.7;
opt.mg2 = 0;
opt.sh1 = 0.25;
opt.sh2 = 0;
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
opt.r = 7;
opt.ks = 0.95;
opt.divSig = 1;
opt.s = 30;
opt.w = 1;
opt.p = 1;
