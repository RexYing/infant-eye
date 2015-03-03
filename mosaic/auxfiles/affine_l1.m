function s = affine_l1(x,A,b)

s = sum(abs(A*x - b));
