[ mask ] = crop( eyeregion );
er =  255 - contrast_adjust(double(eyeregion(:, :, 1)));
er = er .* mask;

%%
Fs = 0.1;
sigma = 3;
gaborFilter(base(:, :, 1), Fs, sigma);