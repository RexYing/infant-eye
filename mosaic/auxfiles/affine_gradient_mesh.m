function [g,G,V] = affine_gradient_mesh(A,x,b,s,ds)

if nargin == 3
    s = 0.2;
    ds = 0.1;
end

t = -s:ds:s;

V = zeros(length(x),length(t));
G = zeros(length(x),1);
for i = 1:length(x)
    k = 1;
    for j = (x(i)-s):ds:(x(i)+s)
        x2 = x;
        x2(i) = j;
        V(i,k) = affine_l1(x2,A,b);
        k = k+1;
    end
end

G = gradient(V);
if mod(size(G,2),2) == 1
    g = G(:,ceil(size(G,2)/2));
else
    g1 = G(:,round(size(G,2)/2));
    g2 = G(:,round(size(G,2)/2)+1);
    g = (g1+g2)./2;
end
