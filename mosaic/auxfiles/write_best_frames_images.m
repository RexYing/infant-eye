function write_best_frames_images(V,dname,sname,h,p,n,r)

if nargin == 5
    n = 10;
    r = -1;
elseif nargin == 6
    r = -1;
end

mkdir(dname);

h2 = sortrows([h,p],r);
size(h2)

for i = 1:n
    if i < 10
        imwrite(V{i}.frames(1).cdata,strcat(dname,sname,'0',num2str(i),'.jpg'));
    elseif i >= 10
        imwrite(V{i}.frames(1).cdata,strcat(dname,sname,num2str(i),'.jpg'));
    end
end
