function [Im,G,gb,as] = gabor_convolve_wb(I,bank_size,sigma_x,sigma_y,freq,sc,sg)

if nargin == 1
    bank_size = 4;
    sigma_x = 10;
    sigma_y = 10;
    freq = 0.05;
    sc = 60;
    sg = 1;
end

I = padarray(I,[30,30],max(max(I)));

[gb,as] = gabor_bank(bank_size,sigma_x,sigma_y,freq,sc);

if sg ~= 1
    for i = 1:length(gb)
        gb{i} = imresize(gb{i},sg);
    end
end

I = double(I);
hh = waitbar(0,'Filtering mosaic: step 4 of 4');
if size(I,3) == 1
    Im = Inf*ones(size(I));
    lgb = length(gb);
    for i = 1:lgb
        G{i} = conv2(I,gb{i},'same');
        Im = min(Im,G{i});
        waitbar(i/lgb);
    end
elseif size(I,3) == 3
    Im = zeros(size(I));
    for j = 1:size(I,3)
        Im1 = Inf*ones(size(I,1),size(I,2));
        lgb = length(gb);
        for i = 1:lgb
            G{j,i} = conv2(I(:,:,j),gb{i},'same');
            Im1 = min(Im1,G{j,i});
            waitbar(i/lgb);
        end
        Im(:,:,j) = Im1;
    end
end
close(hh);

Im = Im(31:size(Im,1)-30,31:size(Im,2)-30);
