function m = median_sans_zeros(I)

[i,j,v] = find(I);

m = median(v);