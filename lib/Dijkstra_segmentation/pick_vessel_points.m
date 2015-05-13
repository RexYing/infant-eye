function [p,p2,cm,p3,cp,I2,I] = pick_vessel_points(I,k,sx,sy,t,t2,E)
%CODE FOR THE PAPER
%"Exploratory Dijkstra forest based automatic vessel segmentation: applications in video indirect ophthalmoscopy (VIO)",
%R. Estrada, C. Tomasi, M. T. Cabrera, D.K. Wallace, S.F. Freedman, S. Farsiu
%Biomedical Optics Express, 3(2), pp. 327-339. Feb. 2012. 
%COPYRIGHT 2012, DUKE UNIVERSITY 
%Please contact Rolando Estrada who developed the code under the supervision of Prof. Sina Farsiu and Prof. Carlo Tomasi    if you have questions about the code and dataset.
%restrada@cs.duke.edu
if nargin == 1
    k = 20;
    sx = 10;
    sy = 10;
    t = 0.3;
    t2 = 0.95;
    E = zeros(size(I));
elseif nargin == 2
    sx = 10;
    sy = 10;
    t = 0.3;
    t2 = 0.95;
    E = zeros(size(I));    
elseif nargin == 3
    sx = 10;
    sy = 10; 
    t2 = 0.95;
    E = zeros(size(I));
elseif nargin == 6
    E = zeros(size(I));
end

t2 = min(t2,max(max(I)));
t = min(t,max(max(I)));
I2 = I;
m = max(max(I));
p = zeros(k,2);
p3 = [];
p2 = [];
cm = [];
j = 1;

if sum(sum(E)) > 0
    E3 = imdilate(E,strel('disk',max(sx,sy)));
    I(E3 > 0) = max(max(I));
end

p2 = [];
p3 = [];
cm = [];
cp = [];
for i = 1:k
    [cx,cy] = find(I == min(min(I)),1);
    cmt = min(min(I))/(max(max(I)));
    I1 = I(max(cx-sx,1):min(cx+sx,size(I,1)),max(cy-sy,1):min(cy+sy,size(I,2)));
    B1 = I1 < t2;
    I1(B1 == 1) = m;
    p(i,:) = [cx,cy];
    if cmt < t
        p2(j,:) = [cx,cy];
        p3(j) = sub2ind(size(I),cx,cy);
        cm(j) = cmt;
        cp(j) = I(cx,cy);
        j = j+1;
    end
    I(max(cx-sx,1):min(cx+sx,size(I,1)),max(cy-sy,1):min(cy+sy,size(I,2))) = I1;
    I2(cx,cy) = 2.5*m;
end
