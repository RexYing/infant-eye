function [V,dname2,bi3,hbsf,hbf,hf,bf,pf,hs,h,p,bi,bi2] = frame_selection_fast6(dname,dname2,info,sk,n,t,bi,bi2,bi3,d,ext,offset,sz,it)

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
elseif nargin == 12
    sz = 20;    
    it = 0.15;    
end

a = 0.2;

% Environment stuff (comment out if not needed).
% addpath 'mmread'
% load str_patient
% fftw('wisdom', str_patient);

s = [info.height,info.width];
dname2 = strcat(dname,dname2,'\');
mkdir(dname2);
[V,hbsf,hbf,hf,bf,pf,hs,h,p] = frame_selection_skip_step7(dname,dname2,s,sk,n,t,bi,d,ext,a,offset,sz);
