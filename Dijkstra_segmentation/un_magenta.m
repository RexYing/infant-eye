function [I,B] = un_magenta(I,hh1,hh2)
%CODE FOR THE PAPER
%"Exploratory Dijkstra forest based automatic vessel segmentation: applications in video indirect ophthalmoscopy (VIO)",
%R. Estrada, C. Tomasi, M. T. Cabrera, D.K. Wallace, S.F. Freedman, S. Farsiu
%Biomedical Optics Express, 3(2), pp. 327-339. Feb. 2012. 
%COPYRIGHT 2012, DUKE UNIVERSITY 
%Please contact Rolando Estrada who developed the code under the supervision of Prof. Sina Farsiu and Prof. Carlo Tomasi    if you have questions about the code and dataset.
%restrada@cs.duke.edu
if nargin == 1
    hh1 = 0.9;
    hh2 = 0;
end

I = rgb2hsv(I);

B = zeros(size(I,1),size(I,2),'uint8');
for i = 1:size(I,1)
    for j = 1:size(I,2)
        if I(i,j,1) > hh1
            I(i,j,1) = 0;
            B(i,j) = 1;
        elseif I(i,j,1) < hh2
            I(i,j,1) = 0;
            B(i,j) = 1;
        end
    end
end

I = uint8(255*hsv2rgb(I));
