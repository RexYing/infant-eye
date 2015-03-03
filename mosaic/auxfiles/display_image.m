function display_image(I,f)

if nargin < 2
    f = 1;
end

figure(f);
imagesc(I);
colormap(gray);
axis image;axis off;
figure(gcf);
hold all
drawnow();
id = 'MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame';
warning('off',id);
jFrame = get(gcf,'JavaFrame');
jFrame.setMaximized(true);


% function display_image(I,f)
% 
% if nargin < 2
%     f = 1;
% end
% 
% figure(f);
% imagesc(I);
% colormap(gray);
% set(gcf,'Position',[1,31,1365,668]);
% axis image;axis off;
% figure(gcf);