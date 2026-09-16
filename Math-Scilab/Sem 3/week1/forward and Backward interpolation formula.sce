clc;clear;
clc;
  n=input("enter No.of data points");
 for i=1:n
  x(i)=input("enter x");
  y(i)=input("enter y");
   end
  xval=input("enter x value at which y is required");
    h=x(2)-x(1);//interval
//calculation of 1st order difference
  for i=1:n-1
    dy(i,1)=y(i+1)-y(i);
    printf("1st difference %d\n",dy(i,1));
   end
//calculation of second and higher order differences
for j=2:n-1
 for i=1:n-j    
    dy(i,j)=dy(i+1,j-1)-dy(i,j-1);
    printf("%d difference %d\n",j,dy(i,j));
 end
end
//p value
  p=(xval-x(1))/h;
//apply to formula
    yval=y(1);
    pnxt=p;
    disp("main result");
    for i=1:n-1
    nxterm=pnxt*dy(1,i)/factorial(i);
    yval=yval+nxterm;
    pnxt=pnxt*(p-i);
        end
printf("\n\n The value of y at %f is %f",xval,yval);
