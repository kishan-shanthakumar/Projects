A=[1 2 0 1;0 1 1 0;1 2 0 1];
//A=[1 3 3 2;2 6 9 7;-1 -3 3 4];
disp(A, 'A=');
[m, n]=size (A) ;
disp(m, 'm=');
disp(n, 'n=');
[v,pivot]=rref(A);
disp(rref(A));
disp(v);
r=length(pivot);
disp(r, 'rank=')
cs=A(:,pivot);
disp(cs,'Column Spaces');
ns=kernel(A);
disp(ns,'Null Space=');
rs=v(1:r,:)';
disp (rs,'Row Space =');
lns=kernel(A');
disp(lns,'Left Null Space');
