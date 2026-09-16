funcprot(0);
function [x, y]=ModiEuler_ode(f, xinit, yinit, h, N)
x(1)=xinit
y(1)=yinit
for j=1:N
x(j+1)=x(j)+h
y(j+1)=y(j)+h*f(x(j),y(j))
y(j+1)=y(j)+(h/2)*(f(x(j),y(j))+f(x(j+1),y(j)+h*f(x(j),y(j))))
end
endfunction
deff('[y]=f(x,y)','y=1+(y/x)')
xinit=1
yinit=2;
h=0.2;
N=2;
[x,y]=ModiEuler_ode(f,xinit,yinit,h,N)


