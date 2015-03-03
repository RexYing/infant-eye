function V = write_best_frames2(fname,dname,sname,h,p,n,r,ext)

if nargin == 5
    n = 10;
    r = -1;
    ext = '.wmv';
elseif nargin == 6
    r = -1;
    ext = '.wmv';
end

mkdir(dname);
dr = dir(strcat(fname,'*',ext));
vname = strcat(fname,dr(1).name);
h2 = sortrows([h,p],r);
size(h2)

V = cell(n,1);
for i = 1:n
    V{i} = mmread_silent(vname,h2(i,2),[],false,true);
    if i < 10
        imwrite(V{i}.frames(1).cdata,strcat(dname,sname,'0',num2str(i),'.jpg'));
    elseif i >= 10
        imwrite(V{i}.frames(1).cdata,strcat(dname,sname,num2str(i),'.jpg'));
    end
end
