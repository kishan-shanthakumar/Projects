//NFIF
x = [1951 1961 1971 1981 1991]
y = [19.96 39.65 58.81 77.21 94.61]
h = 10
c = 1;
for i = 1:4
    d1(c) = y(i+1) - y(i);
    c = c + 1; 
end
c = 1;
for i = 1:3
    d2(c) = d1(i+1) - d1(i);
    c = c + 1; 
end
c = 1
for i = 1:2
    d3(c) = d2(i+1) - d2(i);
    c = c + 1; 
end
c = 1
for i = 1:1
    d4(c) = d3(i+1) - d3(i);
    c = c + 1; 
end
d = [d1(1)d2(1)d3(1)d4(1)];
x0 = 1955;
pp = 1;
y_x = y(1);
p = (x0-1951)/h;
for i = 1:4
    pp = 1;
    for j = 1:i
        pp=pp*(p-(j-1))
    end
    y_x = y_x +(pp*d(i))/factorial(i);
end
printf("Value of function at %f is : %f ", x0,y_x);
