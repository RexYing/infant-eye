function I3 = log_scales(I,sm,tmn,tmx,dt,m)
%CODE FOR THE PAPER
%"Exploratory Dijkstra forest based automatic vessel segmentation: applications in video indirect ophthalmoscopy (VIO)",
%R. Estrada, C. Tomasi, M. T. Cabrera, D.K. Wallace, S.F. Freedman, S. Farsiu
%Biomedical Optics Express, 3(2), pp. 327-339. Feb. 2012. 
%COPYRIGHT 2012, DUKE UNIVERSITY 
%Please contact Rolando Estrada who developed the code under the supervision of Prof. Sina Farsiu and Prof. Carlo Tomasi    if you have questions about the code and dataset.
%restrada@cs.duke.edu
if nargin == 1
    sm = 26;    
    tmn = 0.1;
    tmx = 2;
    dt = 0.1;
    m = 'max';
elseif nargin == 2
    tmn = 0.1;
    tmx = 2;
    dt = 0.1;
    m = 'max';
elseif nargin == 3
    tmn = 0.1;
    tmx = 2;
    dt = 0.1;    
    m = 'max';
end

I = double(I);

sm2 = [sm+5,sm+5];
I = padarray(I,sm2,'replicate');

if strcmp(m,'max')
    I3 = -Inf*ones(size(I));
elseif strcmp(m,'min');
    I3 = Inf*ones(size(I));
end

    for t = tmn:dt:tmx
        h = fspecial('log',[sm,sm],t);
        I2 = imfilter(I,h,1);
        if strcmp(m,'max')
            I3 = normalize_image(max(normalize_image(I3,1),normalize_image(I2,1)),1);
        elseif strcmp(m,'min')
            I3 = min(I3,I2);
        end        
    end
if strcmp(m,'max')
    I3 = max(max(I3)) - I3;
end

I3 = I3 - min(min(I3));

I3 = I3((sm2(1)+1):size(I3,1)-sm2(1),(sm2(2)+1):size(I3,2)-sm2(2));
