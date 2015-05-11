function opt = option_defaults_fa

opt.vessels = 'dark';
opt.pad = 30;
opt.bf_sp = 16;
opt.bf_sr = 0.1;

opt.scale = 1;
opt.sig = 0.3;
opt.k = 0.5;
opt.s1 = [10,10];
opt.t1 = 1.15;
opt.cf = 'max';
opt.mg1 = 0.7;
opt.mg2 = 0;
opt.sh1 = 0.25;
opt.sh2 = 0;
opt.sigmaMax = 0.51;
opt.sigmaMin = 0.11;
opt.sigmaStepSize = 0.1;

opt.kernelSize = 14;
opt.kSrange = 4;

opt.orientations = 9;
opt.gaborSigmaX = 10;

opt.gaborSigmaY = 10;
opt.frequency = 0.05;
opt.gaborKernelSize = 60;

opt.bankScale = 0.4;
opt.bSrange = 0.3;
opt.bSstep = 0.05;

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
opt.p = 7;
opt.pd = [40,40];

opt.bankMin = 0.1;
opt.bankMax = 0.7;
opt.bankSize = 10;
