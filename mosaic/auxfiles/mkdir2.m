function dname = mkdir2(dname)

if exist(dname,'dir') == 0
    mkdir(dname);
end
