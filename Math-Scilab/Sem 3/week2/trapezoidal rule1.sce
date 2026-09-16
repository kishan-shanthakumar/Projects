clc;clear;close;
deff('y=f(x)','y=1/(1+x^2)')
a=input("Enter Lower limit:")
b=input("Enter Upper limit:")
n=input("Enter number of sub intervals:")
h=(b-a)/n
add1=0
add2=0
for i=0:n
x=a+i*h
y=f(x)
disp([x y])
if  (i==0)|(i==n)
    add1=add1+y
   else
    add2=add2+y
   end
end
I=(h/2)*(add1+2*add2)
disp(I,"Integration by Trapezoidal Rule is:")
i=integrate('1/(1+x^2)','x',0,6)
disp(i,"Direct integration value:")
