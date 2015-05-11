function [I2,B0,E] = border_extend(I,s,w,p)
%CODE FOR THE PAPER
%"Exploratory Dijkstra forest based automatic vessel segmentation: applications in video indirect ophthalmoscopy (VIO)",
%R. Estrada, C. Tomasi, M. T. Cabrera, D.K. Wallace, S.F. Freedman, S. Farsiu
%Biomedical Optics Express, 3(2), pp. 327-339. Feb. 2012. 
%COPYRIGHT 2012, DUKE UNIVERSITY 
%Please contact Rolando Estrada who developed the code under the supervision of Prof. Sina Farsiu and Prof. Carlo Tomasi    if you have questions about the code and dataset.
%restrada@cs.duke.edu
if nargin == 1
    s = 10;
    w = 1;
    p = 5;
end

I0 = zeros(size(I,1),size(I,2),'uint8');
for i = 1:size(I,3)
    I0 = max(I0,I(:,:,i));
end
B = bwperim(I0 > 0);
B = hue_clean(B); B0 = B;
B = uint8(B);
se = strel('disk',1);
se2 = strel('disk',p);
B3 = uint8(imdilate(B,se2));
B4 = uint8(imfill(B3,'holes'));
B4 = B4 - B3; B4(B4 < 0) = 0;
B = bwperim(B4);
I2 = I;
E = B;
for i = 1:s
    [fi,fj] = find(E);
    for j = 1:length(fi)
        M = I2(max(1,fi(j)-w):min(size(I,1),fi(j)+w),max(1,fj(j)-w):min(size(I,2),fj(j)+w),:);
        for k = 1:size(M,3)
            m = median_sans_zeros(M(:,:,k));
            I2(fi(j),fj(j),k) = m;
        end
    end
    B2 = uint8(imfill(E,'holes'));
    B3 = uint8(imdilate(E,se));    
    E = B3 - B2;
end
    