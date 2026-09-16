clear;
deff('g=f(x,y)','g=-2*y^2*x')
xo=input("Enter initial value of xo:0")
yo=input("Enter the value of yo:0")
h=input("Enter value of h:0.2")
xn=input("Enter Final value of xn:1")
n=(xn-xo)/h
for i=1:n
    k1=h*f(xo,yo)
    k2=h*f(xo+(h/2),yo+(k1/2))
    k3=h*f(xo+(h/2),yo+(k2/2))
    k4=h*f(xo+h,yo+k3)
    y1=yo+(1/6)*(k1+2*k2+2*k3+k4)
    xo=xo+h
    disp([xo y1])
    yo=y1
end
