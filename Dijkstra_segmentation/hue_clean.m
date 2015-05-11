function B = hue_clean(B)
%CODE FOR THE PAPER
%"Exploratory Dijkstra forest based automatic vessel segmentation: applications in video indirect ophthalmoscopy (VIO)",
%R. Estrada, C. Tomasi, M. T. Cabrera, D.K. Wallace, S.F. Freedman, S. Farsiu
%Biomedical Optics Express, 3(2), pp. 327-339. Feb. 2012. 
%COPYRIGHT 2012, DUKE UNIVERSITY 
%Please contact Rolando Estrada who developed the code under the supervision of Prof. Sina Farsiu and Prof. Carlo Tomasi    if you have questions about the code and dataset.
%restrada@cs.duke.edu
L = bwlabel(B);
p = regionprops(L,'Area');

m = p(1).Area;
mx = 1;
for i = 1:length(p)
    if p(i).Area > m
        mx = i;
        m = p(i).Area;
    end
end

B(L ~= mx) = 0;
