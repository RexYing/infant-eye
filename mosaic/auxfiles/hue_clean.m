function B = hue_clean(B)

L = bwlabel(B);
p = regionprops(L,'Area');

m = p(1).Area;
mx = 1;
for i = 1:length(p)
    if p(i).Area > m
        mx = i;
        m = p(i).Area;
    end
end

B(L ~= mx) = 0;
