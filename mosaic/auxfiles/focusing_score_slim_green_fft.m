function [h,hi,hb] = focusing_score_slim_green_fft(Ig,G1,G2)

Ig = double(Ig);
F = fft2(Ig);

F2 = F.*G1;
F3 = F2.*G2;

hi = sum(sum(abs(real(F)-real(F2))));
hb = sum(sum(abs(real(F2)-real(F3))));
h = max(hb/hi,0);
