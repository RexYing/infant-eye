function G2 = gabor_only2(L,opt)

G = gabor_convolve_wb(L,opt.orientations,...
    opt.gaborSigmaX,opt.gaborSigmaY,opt.frequency,...
    opt.gaborKernelSize,opt.bankScale);
G = normalize1(G,1);
m = median(median(G));
G2 = G; G2(G > m) = m;
