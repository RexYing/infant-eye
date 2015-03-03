function display_compact(I,f)

if nargin < 2
    f = 1;
end

figure(f);
imagesc(I);
colormap(gray);
set(gcf,'Position',[594,49,764,640]);
axis image;axis off;
figure(gcf);