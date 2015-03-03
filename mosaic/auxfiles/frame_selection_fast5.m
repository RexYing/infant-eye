function [V,dname2,bi3,hbsf,hbf,hf,bf,pf,hs,h,p,bi,bi2] = frame_selection_fast5(I,dname,dname2,info,sk,n,t,pi,d,ext,sz,it)

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
    sz = 20;    
    it = 0.15;    
elseif nargin == 10
    sz = 20;    
    it = 0.15;    
end

a = 0.3;

% Environment stuff (comment out if not needed).
% addpath 'mmread'
% load str_patient
% fftw('wisdom', str_patient);

bi = hsv_interval2_5(I,it,pi);
it2 = 0.2;
bi2 = hsv_interval2_5(I,it2,pi);
it3 = 0.3;
bi3 = hsv_interval2_5(I,it3,pi);

s = [info.height,info.width];
[hbsf,hbf,hf,bf,pf,hs,h,p] = frame_selection_skip_step6(dname,s,sk,n,t,bi,d,ext,a);

dname2 = strcat(dname,dname2,'\');
sname = 'best_frames_hb_';
V = write_best_frames2(dname,dname2,sname,hbf,pf,sz,-1,ext);
