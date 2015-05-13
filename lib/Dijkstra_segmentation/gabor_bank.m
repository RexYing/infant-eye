function [filter_bank ang_s]=gabor_bank(bank_size,sigma_x,sigma_y,freq,sc)
%CODE FOR THE PAPER
%"Exploratory Dijkstra forest based automatic vessel segmentation: applications in video indirect ophthalmoscopy (VIO)",
%R. Estrada, C. Tomasi, M. T. Cabrera, D.K. Wallace, S.F. Freedman, S. Farsiu
%Biomedical Optics Express, 3(2), pp. 327-339. Feb. 2012. 
%COPYRIGHT 2012, DUKE UNIVERSITY 
%Please contact Rolando Estrada who developed the code under the supervision of Prof. Carlo Tomasi and Prof. Sina Farsiu if you have questions about the code and dataset.
%restrada@cs.duke.edu
ang_s=fix(linspace(0,180,bank_size));
ang_s = ang_s(1:(end-1));
angs=deg2rad(ang_s);

filter_bank=cell(length(angs),1);
for i=1:length(angs),
    filter_bank{i}=gabor_fn(sigma_x,sigma_y,angs(i),freq,sc);
end

