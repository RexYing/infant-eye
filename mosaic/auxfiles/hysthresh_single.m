function aboveT1 = hysthresh_single(im, T1)

T1 = median_sans_zeros(im)*T1;
aboveT1 = im > T1;                                           
