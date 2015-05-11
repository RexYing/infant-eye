function [I,I2] = hue_zero_out(I,hl,hh,sl,sh,vl,vh,d)
%CODE FOR THE PAPER
%"Exploratory Dijkstra forest based automatic vessel segmentation: applications in video indirect ophthalmoscopy (VIO)",
%R. Estrada, C. Tomasi, M. T. Cabrera, D.K. Wallace, S.F. Freedman, S. Farsiu
%Biomedical Optics Express, 3(2), pp. 327-339. Feb. 2012. 
%COPYRIGHT 2012, DUKE UNIVERSITY 
%Please contact Rolando Estrada who developed the code under the supervision of Prof. Sina Farsiu and Prof. Carlo Tomasi    if you have questions about the code and dataset.
%restrada@cs.duke.edu
if nargin == 1
    hl = 0.1;
    hh = 0.9;
    sl = 0.25;
    sh = 0.75;
    vl = 0.3;
    vh = 0.9;
    d = 1;
end

I3 = rgb2hsv(I);

I2h = zeros(size(I,1),size(I,2),'uint8');
I2s = zeros(size(I,1),size(I,2),'uint8');
I2v = zeros(size(I,1),size(I,2),'uint8');

if d == 1
    I2h(I3(:,:,1) > hh) = 1;
    I2h(I3(:,:,1) < hl) = 1;
    I2s(I3(:,:,2) > sl) = 1;
    I2s(I3(:,:,2) > sh) = 0;
    I2v(I3(:,:,3) > vl) = 1;
    I2v(I3(:,:,3) > vh) = 0;
    I2 = I2h.*I2s.*I2v;
elseif d == 0
    I2h(I3(:,:,1) > hl) = 1;
    I2h(I3(:,:,1) > hh) = 0;
    I2s(I3(:,:,2) > sl) = 1;
    I2s(I3(:,:,2) > sh) = 0;
    I2v(I3(:,:,3) > vl) = 1;
    I2v(I3(:,:,3) > vh) = 0;
    I2 = I2h.*I2s.*I2v;    
end

for i = 1:size(I,3)
    I(:,:,i) = I(:,:,i).*I2;
end
                