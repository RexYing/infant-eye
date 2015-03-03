function [V,hbsf,hbf,hf,bf,pf,hs,h,p,bi,bi2,dname2] = frame_selection_fast3(dname,dname2,id,sk,n,t,pi,d,ext,a,sz,it)

if nargin == 1
    dname2 = 'frames';
    id = 1;
    sk = 10;
    n = 1200;
    t = 20;
    d = 0;    
    ext = '.wmv';
    a = 0.5;
    sz = 20;
    it = 0.15;
elseif nargin == 2
    id = 1;
    sk = 10;
    n = 1200;
    t = 20;
    d = 0;    
    ext = '.wmv';
    a = 0.5;
    sz = 20;
    it = 0.15;
elseif nargin == 3
    sk = 10;
    n = 1200;
    t = 20;
    d = 0;    
    ext = '.wmv';
    a = 0.5;
    sz = 20;    
    it = 0.15;
elseif nargin == 4
    n = 1200;
    t = 20;
    d = 0;    
    ext = '.wmv';
    a = 0.5;
    sz = 20;    
    it = 0.15;
elseif nargin == 5
    t = 20;
    d = 0;    
    ext = '.wmv';
    a = 0.5;
    sz = 20;    
    it = 0.15;
elseif nargin == 7
    d = 0;    
    ext = '.wmv';
    a = 0.5;
    sz = 20;    
    it = 0.15;
elseif nargin == 8
    ext = '.wmv';
    a = 0.5;
    sz = 20;    
    it = 0.15;    
elseif nargin == 9
    a = 0.5;
    sz = 20;    
    it = 0.15;    
end

a = 0.3;

% Environment stuff (comment out if not needed).
% addpath 'mmread'
% load str_patient
% fftw('wisdom', str_patient);

% Select representative pixel
dr = dir(strcat(dname,'*','.jpg'));
iname = strcat(dname,dr(id).name);
I = imread(iname);
bi = hsv_interval2_5(I,it,pi);
it2 = 0.2;
bi2 = hsv_interval2_5(I,it2,pi);

[hbsf,hbf,hf,bf,pf,hs,h,p] = frame_selection_skip_step5(dname,sk,n,t,bi,d,ext,a);

dname2 = strcat(dname,dname2,'\');
sname = 'best_frames_hb_';
V = write_best_frames2(dname,dname2,sname,hbf,pf,sz,-1,ext);
