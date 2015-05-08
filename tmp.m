[ mask ] = crop( eyeregion );
er =  255 - contrast_adjust(double(eyeregion(:, :, 1)));
er = er .* mask;

%%
Fs = 0.1;
sigma = 3;
gaborFilter(base(:, :, 1), Fs, sigma);
colormap gray

%% Trt Fusion
f1 = squeeze(stack(1, :, :, :));
f2 = squeeze(stack(2, :, :, :));
XFUS = wfusimg(f1,f2,'sym4',5,'max','max');

subplot(221), imagesc(f1), axis square,  
title('Catherine 1') 
subplot(222), imshow(f2), axis square,  
title('Catherine 2') 
subplot(223), imagesc(XFUS), axis square,  
title('Synthesized image')