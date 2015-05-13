function [A,E,Gx,Gy,Gd1,Gd2] = build_graph_points_lattice(I2,a,k)
%CODE FOR THE PAPER
%"Exploratory Dijkstra forest based automatic vessel segmentation: applications in video indirect ophthalmoscopy (VIO)",
%R. Estrada, C. Tomasi, M. T. Cabrera, D.K. Wallace, S.F. Freedman, S. Farsiu
%Biomedical Optics Express, 3(2), pp. 327-339. Feb. 2012. 
%COPYRIGHT 2012, DUKE UNIVERSITY 
%Please contact Rolando Estrada who developed the code under the supervision of Prof. Sina Farsiu and Prof. Carlo Tomasi    if you have questions about the code and dataset.
%restrada@cs.duke.edu
if nargin == 1
    a = 2;
    k = 0.5;
end

[X Y]=size(I2);
[points, edges]=lattice(X,Y,1);
[Gx,Gy,Gd1,Gd2] = shift_gradient(I2,k);

Gx = abs(Gx);
Gy = abs(Gy);
Gd1 = abs(Gd1);
Gd2 = abs(Gd2);
Gx = exp(a*(max(max(Gx))-Gx));
Gy = exp(a*(max(max(Gy))-Gy));
Gd1 = exp(a*(max(max(Gd1))-Gd1));
Gd2 = exp(a*(max(max(Gd2))-Gd2));

Ge = [Gy(:);Gx(:);Gd1(:);Gd2(:)];
Ge = (Ge + 1)*10;

mg = min(Ge);
Ge = Ge - mg + 1;    
E = [edges,Ge];

A = sparse(E(:,1),E(:,2),E(:,3));
A = [A;zeros(1,size(A,2))];
A = A + A';
