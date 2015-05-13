function opt = dijkstra_seg_defaults
%CODE FOR THE PAPER
%"Exploratory Dijkstra forest based automatic vessel segmentation: applications in video indirect ophthalmoscopy (VIO)",
%R. Estrada, C. Tomasi, M. T. Cabrera, D.K. Wallace, S.F. Freedman, S. Farsiu
%Biomedical Optics Express, 3(2), pp. 327-339. Feb. 2012. 
%COPYRIGHT 2012, DUKE UNIVERSITY 
%Please contact Rolando Estrada who developed the code under the supervision of Prof. Carlo Tomasi and Prof. Sina Farsiu if you have questions about the code and dataset.
%restrada@cs.duke.edu
opt.k = 20;
opt.k2 = 5;
opt.k3 = 3;
opt.sx = 20;
opt.sy = 20;
opt.sx2 = 10;
opt.sy2 = 10;
opt.c = 1.5;    
opt.t = 0.6;
opt.t2 = 10000;
opt.t3 = 1e9;
opt.t4 = 8000;
opt.t5 = 1e7;
opt.t6 = 1e10;
opt.t8 = 0.8;
opt.t9 = 0.4;
opt.t10 = 0.95;
opt.t11 = 0.4;
opt.t12 = 0;    
opt.a = 20;
opt.w = 1;
opt.q = 0.75;
opt.d = 5;
opt.br1 = 100;
opt.br2 = 100;
opt.s2 = [10,10];
opt.prt = 0.2;
opt.bkt = 0;
opt.exp_thr = 0.00005;
opt.flt_thr = 0.7;

