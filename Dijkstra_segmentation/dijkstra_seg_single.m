function [I,v,I3,Ig,I2,P,a,pt2,I4] = dijkstra_seg_single(A,v0,Ig,t,t3,t2,t8,c,t12,I)
%CODE FOR THE PAPER
%"Exploratory Dijkstra forest based automatic vessel segmentation: applications in video indirect ophthalmoscopy (VIO)",
%R. Estrada, C. Tomasi, M. T. Cabrera, D.K. Wallace, S.F. Freedman, S. Farsiu
%Biomedical Optics Express, 3(2), pp. 327-339. Feb. 2012. 
%COPYRIGHT 2012, DUKE UNIVERSITY 
%Please contact Rolando Estrada who developed the code under the supervision of Prof. Carlo Tomasi and Prof. Sina Farsiu if you have questions about the code and dataset.
%restrada@cs.duke.edu
if nargin == 3
    t = 1000;
    t2 = 8*t;
    t3 = 0.2e13;
    c = 1.5;
    I = zeros(size(Ig));
elseif nargin == 4
    t2 = 8*t;
    c = 1.5;
    I = zeros(size(Ig));        
elseif nargin == 9
    I = zeros(size(Ig));
end

Ig0 = Ig;
I2 = I;
I3 = I;
m = max(max(Ig));
k = zeros(1000,1);
Q.path = [];
Q.weights = [];
P = pq_build_empty_heap(t2);
P = pq_push(P,v0,Q,0);
k(1) = 1;
A(v0,:) = 0;
v(1) = v0;
a(1) = 0;
pt2{1} = Q;
l = 2;
i = 1;
I4 = Inf*ones(size(I));
I4(v0) = 0;
while l < t
    if P.m < 1   
        l = t;
    else
        [vt,at,pt,P] = pq_pop(P);
        if I(vt) ~= 1 && I2(vt) ~= 1
            v(l) = vt;
            a(l) = at;            
            pt2{l} = pt;
            k(l) = at;
            if  Ig0(vt) < t8
                I(vt) = 1;
                Ig(vt) = c*m;
            else
                I2(vt) = 1;
            end
            I3(vt) = 1;
            l = l+1;            
            [fi,fj,fv] = find(A(:,vt));
            for j = 1:length(fi)
                fa = fv(j);
                h = max(0,fa+at-t12);
                if h < I4(fi(j)) && h < t3
                    Q.path = [pt.path,vt];
                    Q.weights = [pt.weights,h];
                    P = pq_push(P,fi(j),Q,h);
                    I4(fi(j)) = h;
                end
            end            
        end
    end
    i = i + 1;
end

function A = pq_build_empty_heap(m)

A.a = Inf*ones(1,m);
A.v = zeros(1,m);
A.p = cell(m,1);
A.m = 0;

function A = pq_push(A,v,p,k)

A.m = A.m + 1;
A.a(A.m) = Inf;
A = pq_heap_decrease_key(A,A.m,v,p,k);

function A = pq_heap_decrease_key(A,i,v,p,k)

if k < A.a(i)
    A.a(i) = k;
    A.v(i) = v;
    A.p{i} = p;
    while i > 1 && A.a(floor(i/2)) > A.a(i)
        t1 = A.a(i);
        A.a(i) = A.a(floor(i/2));
        A.a(floor(i/2)) = t1;
        t2 = A.v(i);
        A.v(i) = A.v(floor(i/2));
        A.v(floor(i/2)) = t2;        
        t3 = A.p{i};
        A.p{i} = A.p{floor(i/2)};
        A.p{floor(i/2)} = t3;        
        i = floor(i/2);
    end
end

function [v,a,p,A] = pq_pop(A)

if A.m >= 1
    a = A.a(1);
    v = A.v(1);
    p = A.p{1};
    
    A.a(1) = A.a(A.m);
    A.a(A.m) = Inf;
    
    A.v(1) = A.v(A.m);
    A.v(A.m) = 0;

    A.p{1} = A.p{A.m};
    A.p{A.m} = {};

    A.m = A.m - 1;
    A = pq_min_heapify(A,1);
else
    a = Inf;
    v = 0;
end

function A = pq_min_heapify(A,i)
%
% A = struct with heap array A.a and heap size A.m
% i = index of possibly aberrant item

l = 2*i;
r = 2*i + 1;

if l <= A.m && A.a(l) < A.a(i)
    lar = l;
else
    lar = i;
end

if r <= A.m && A.a(r) < A.a(lar)
    lar = r;
end

if lar ~= i
    t1 = A.a(i);
    A.a(i) = A.a(lar);
    A.a(lar) = t1;

    t2 = A.v(i);
    A.v(i) = A.v(lar);
    A.v(lar) = t2;
    
    t3 = A.p{i};
    A.p{i} = A.p{lar};
    A.p{lar} = t3;

    A = pq_min_heapify(A,lar);
end
