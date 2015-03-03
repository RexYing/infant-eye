function [V,hbsf,hbf,hf,bf,pf,hs,h,p] = frame_selection_skip_step7(fname,dname2,s,sk,n,t,b1,d,ext,a,offset,sz)

if nargin == 1
    sk = 30;
    n = 1000;
    t = 10;
    b1(1) = 0.1;
    b1(2) = 0.9;
    b1(3) = 0.25;
    b1(4) = 0.75;
    b1(5) = 0.3;
    b1(6) = 0.9;
    d = 0;    
    ext = '.wmv';
    a = 0.5;
elseif nargin == 2
    n = 1000;
    t = 10;
    b1(1) = 0.1;
    b1(2) = 0.9;
    b1(3) = 0.25;
    b1(4) = 0.75;
    b1(5) = 0.3;
    b1(6) = 0.9;
    d = 0;    
    ext = '.wmv';
    a = 0.5;
elseif nargin == 3
    t = 10;
    b1(1) = 0.1;
    b1(2) = 0.9;
    b1(3) = 0.25;
    b1(4) = 0.75;
    b1(5) = 0.3;
    b1(6) = 0.9;
    d = 0;    
    ext = '.wmv';
    a = 0.5;
elseif nargin == 4
    b1(1) = 0.1;
    b1(2) = 0.9;
    b1(3) = 0.25;
    b1(4) = 0.75;
    b1(5) = 0.3;
    b1(6) = 0.9;
    d = 0;    
    ext = '.wmv';
    a = 0.5;
elseif nargin == 5
    d = 0;    
    ext = '.wmv';
    a = 0.5;
elseif nargin == 6
    ext = '.wmv';
    a = 0.5;
elseif nargin == 7
    a = 0.5;
end

if n == 0
    n = Inf;
end

vname = ext;
f1 = 0.3;
k1 = 0.5;
f2 = 0.125;
k2 = 1;

G1 = normalize1(gaussian_skew2([s(1),s(2)],f1,k1),1);
G2 = normalize1(gaussian_skew2([s(1),s(2)],f2,k2),1);

j = 1;
l = 1;
h = zeros(round(6000/sk),1);
b = zeros(round(6000/sk),1);
p = zeros(round(6000/sk),1);
j0 = 500;
j2 = 500;
j3 = 1;

hh = waitbar(0,'Determining best frames: step 1 of 3');
M = mmread_silent(vname,(1+offset):(n+offset),[],false,true);
waitbar(1);
close(hh);
hh = waitbar(0,'Determining best frames: step 2 of 3');
n = length(M.frames);
for j = 1:sk:n
    C1 = M.frames(j).cdata;
    h(l) = hsv_score_fast5(C1,b1,d);
    p(l) = j;
    l = l + 1;
    if ~isinf(n)
       waitbar(j/n);
    else
        waitbar(j / 6000);
    end  
end
close(hh);

if l < length(h)
    h = h(1:l-1);
    p = p(1:l-1);
end

hs = sortrows([h,p],-1);

hs(1:sz,:)
    
t = t*0.01;
tp = round(length(h)*t);
r2 = round(sk/3);
m2 = p(end);
l = 1;
hf = zeros(sk*tp,1);
bf = zeros(sk*tp,1);
pf = zeros(sk*tp,1);
hh = waitbar(0,'Determining best frames: step 3 of 3');
for i = 1:tp
    k = max(1,(hs(i,2)-r2)):min(m2,(hs(i,2)+r2));
    for j = 1:length(k)
        C2 = M.frames(k(j)).cdata;
        hf(l) = hsv_score_fast5(C2,b1,d);
        bf(l) = focusing_score_slim_green_fft(C2(:,:,2),G1,G2);
        pf(l) = k(j);
        l = l + 1;
    end
    waitbar(i/tp);
end
close(hh);

if l < length(hf)
    hf = hf(1:l-1);
    bf = bf(1:l-1);
    pf = pf(1:l-1);
end

ha1 = sortrows([hf,pf],-1);
ha1(1:sz,:)
ha1 = sortrows([bf,pf],-1);
ha1(1:sz,:)

hbf = a*normalize1(hf,1) + (1-a)*normalize1(bf,1);

hbsf = sortrows([hbf,pf],-1);

hbsf(1:sz,:)

sname = 'best_frames_hb_';
V = cell(sz,1);
for i = 1:sz
    V{i}.frames(1).cdata = M.frames(hbsf(i,2)).cdata;
    if i < 10
        imwrite(V{i}.frames(1).cdata,strcat(dname2,sname,'0',num2str(i),'.jpg'));
    elseif i >= 10
        imwrite(V{i}.frames(1).cdata,strcat(dname2,sname,num2str(i),'.jpg'));
    end
end
