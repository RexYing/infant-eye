function [Im,Gv,G,gb,as] = gabor_convolve(I,bank_size,sigma_x,sigma_y,freq,sc,sg)
%CODE FOR THE PAPER
%"Exploratory Dijkstra forest based automatic vessel segmentation: applications in video indirect ophthalmoscopy (VIO)",
%R. Estrada, C. Tomasi, M. T. Cabrera, D.K. Wallace, S.F. Freedman, S. Farsiu
%Biomedical Optics Express, 3(2), pp. 327-339. Feb. 2012. 
%COPYRIGHT 2012, DUKE UNIVERSITY 
%Please contact Rolando Estrada who developed the code under the supervision of Prof. Sina Farsiu and Prof. Carlo Tomasi    if you have questions about the code and dataset.
%restrada@cs.duke.edu
if nargin == 1
    bank_size = 10;
    sigma_x = 10;
    sigma_y = 10;
    freq = 0.05;
    sc = 60;
    sg = 0.5;
end

I = padarray(I,[30,30],max(max(I)));

[gb,as] = gabor_bank(bank_size,sigma_x,sigma_y,freq,sc);

if sg ~= 1
    for i = 1:length(gb)
        gb{i} = imresize(gb{i},sg);
    end
end

I = double(I);
Gv2 = zeros(size(I,1),size(I,2),length(gb));
if size(I,3) == 1
    Im = Inf*ones(size(I));
    for i = 1:length(gb)
        G{i} = conv2(I,gb{i},'same');
        Gv2(:,:,i) = G{i};
        Im = min(Im,G{i});
    end
elseif size(I,3) == 3
    Im = zeros(size(I));
    for j = 1:size(I,3)
        Im1 = Inf*ones(size(I,1),size(I,2));
        for i = 1:length(gb)
            G{j,i} = conv2(I(:,:,j),gb{i},'same');
            Im1 = min(Im1,G{j,i});
        end
        Im(:,:,j) = Im1;
    end
end

Gv = Gv2(31:size(Im,1)-30,31:size(Im,2)-30,:);
Im = Im(31:size(Im,1)-30,31:size(Im,2)-30);
