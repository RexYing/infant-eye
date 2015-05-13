function [I,B5,B,B2,Ir] = remove_retinal_buffer(I,b,d,r)
%CODE FOR THE PAPER
%"Exploratory Dijkstra forest based automatic vessel segmentation: applications in video indirect ophthalmoscopy (VIO)",
%R. Estrada, C. Tomasi, M. T. Cabrera, D.K. Wallace, S.F. Freedman, S. Farsiu
%Biomedical Optics Express, 3(2), pp. 327-339. Feb. 2012. 
%COPYRIGHT 2012, DUKE UNIVERSITY 
%Please contact Rolando Estrada who developed the code under the supervision of Prof. Sina Farsiu and Prof. Carlo Tomasi    if you have questions about the code and dataset.
%restrada@cs.duke.edu
if nargin == 1
    b(1) = 0.1;
    b(2) = 0.9;
    b(3) = -1;
    b(4) = 2;
    b(5) = 0.1;
    b(6) = 2;    
    d = 1;
    r = 10;
end

Ir = zeros(size(I,1)+(r*2),size(I,2)+(r*2),size(I,3),'uint8');
Ir((r*2+1):size(I,1)+(r*2),(r*2+1):size(I,2)+(r*2),:) = I;
Ir = hue_zero_out(Ir,b(1),b(2),b(3),b(4),b(5),b(6),d);

B = bwperim(Ir(:,:,2) > 0);
B = hue_clean(B);

se = strel('disk',r);
B2 = imdilate(B,se);
B2(B2 > 0) = 1;
B2 = uint8(B2);

B3 = uint8(imfill(B,'holes'));
B3 = uint8(B3 - B2);
B3 = B3((r*2+1):size(I,1)+(r*2),(r*2+1):size(I,2)+(r*2));
B2 = B2((r*2+1):size(I,1)+(r*2),(r*2+1):size(I,2)+(r*2));

B4 = max(max(B2)) - B2;
for i = 1:size(I,3)
    I(:,:,i) = I(:,:,i).*B3;
    I(:,:,i) = I(:,:,i).*B4;
end

B = bwperim(B3);
se3 = strel('disk',2*r);
B5 = imdilate(B,se3);
B5(B5 > 0) = 1;
