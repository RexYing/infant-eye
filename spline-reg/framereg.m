Options.Similarity='mi';
Options.Penalty = 1e-3;
Imoving=im2double(imread('images/prostate1.png'));
Istatic=im2double(imread('images/prostate2.png'));
reg = image_registration(Imoving, Istatic, Options);
figure
subplot(2,2,1), imshow(Istatic); title('moving image');
subplot(2,2,2), imshow(Imoving); title('static image');
subplot(2,2,3), imshow(reg); title('registerd moving image');
