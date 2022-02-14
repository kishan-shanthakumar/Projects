clc;clear;close
deff('y=f(x)','y=(1/(1+x^2))')
a=input("Enter the Lower limit:");
b=input("Enter the Upper limit:");
n=input("Enter the no. of intervals:");
if(modulo(n,2)==0)
    then
h=(b-a)/n
add1=0
add2=0
add3=0
for i=0:n
    x=a+i*h
    y=f(x)
    disp([x y])
    if(i==0)|(i==n)
        then
        add1=add1+y
    else if(modulo(i,2)==0) then
            add2=add2+y
               else
        add3=add3+y
                end
end
end
I=(h/3)*(add1+2*add2+4*add3)
disp(I,"Integration by Simpsons (1-3)rd Rule is:")
else
    disp("can not be solved by simpsons (1-8) rule")
end
