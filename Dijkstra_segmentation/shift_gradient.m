function [Gx,Gy,Gd1,Gd2] = shift_gradient(R,b)
%CODE FOR THE PAPER
%"Exploratory Dijkstra forest based automatic vessel segmentation: applications in video indirect ophthalmoscopy (VIO)",
%R. Estrada, C. Tomasi, M. T. Cabrera, D.K. Wallace, S.F. Freedman, S. Farsiu
%Biomedical Optics Express, 3(2), pp. 327-339. Feb. 2012. 
%COPYRIGHT 2012, DUKE UNIVERSITY 
%Please contact Rolando Estrada who developed the code under the supervision of Prof. Sina Farsiu and Prof. Carlo Tomasi    if you have questions about the code and dataset.
%restrada@cs.duke.edu
if nargin == 1
    b = 0.5;
end

[G1,G2,G3] = xyGradient(R,0.05);

G3 = max(max(G3)) - G3;
R = max(max(R))-R;
Gx = b*R(:,1:end-1) + (1-b)*(G1(:,1:end-1));
Gy = b*R(1:end-1,:) + (1-b)*(G2(1:end-1,:));

Gd1 = sqrt(2).*(b*R(1:end-1,2:end) + (1-b)*(G3(1:end-1,2:end)));
Gd2 = sqrt(2).*(b*R(1:end-1,1:end-1) + (1-b)*(G3(1:end-1,1:end-1)));
