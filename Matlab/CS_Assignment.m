% clc;
% clear all;
% close all;
% num=1;
% deno=[1 3 2 0 0];
% sys=tf(num,deno);
% step(sys)
% 
% clc;
% clear all;
% close all;
% num=1;
% deno=[1 3 2 0 0];
% sys=tf(num,deno);
% step(sys)
% 
% clc;
% clear all;
% close all;
% num=4;
% deno=[1 3 6 12 8 0];
% sys=tf(num,deno);
% step(sys)
% 
% clc;
% clear all;
% close all;
% num=20;
% deno=[1 3 6 12 8 0];
% sys=tf(num,deno);
% step(sys);
% 
% clc;
% clear all;
% close all;
% num=1.5;
% deno=[1 0.5 1.5];
% sys=tf(num,deno);
% step(sys);
% 
% clc;
% clear all;
% close all;
% num=[-1 3];
% deno=[3 1.5 4.5];
% sys=tf(num,deno);
% step(sys);
% 
% clc;
% clear all;
% close all;
% num=[1 3];
% deno=[3 1.5 4.5];
% sys=tf(num,deno);
% step(sys);
% title("Step response of the system");
% 
% clc;
% clear all;
% close all;
% num=25;
% deno=[1 8 32 25];
% sys=tf(num,deno);
% step(sys);
% title("Step response of the system");
% 
% clc;
% clear all;
% close all;
% num=25;
% deno=[1 1];
% sys=tf(num,deno);
% step(sys);
% title("Step response of the system");
% 
% clc;
% clear all;
% close all;
% num=[27.8 25.02];
% deno=[1 8 32 25];
% sys=tf(num,deno);
% step(sys);
% title("Step response of the system");
% 
% clc;
% clear all;
% close all;
% syms s;
% %Since we dont have a inbuilt ramp response generator, we use step response
% %by multiplying one 's' term in the denominator.
% num=sym2poly(10+1.79*s);
% deno=sym2poly(s*(s^2+3.179*s+10));
% sys=tf(num,deno);
% figure;
% step(sys)
% 
% clc;
% clear all;
% close all;
% syms s;
% %Since we dont have a inbuilt ramp response generator, we use step response
% %by multiplying one 's' term in the denominator.
% num=sym2poly(10+10*s);
% deno=sym2poly(s*(s^2+20*s+10));
% sys=tf(num,deno)
% figure;
% step(sys)
% 
% clc;
% clear all;
% close all;
% syms s;
% num=sym2poly(s+30);
% deno=sym2poly((s+1)*(s^2+20*s+116));
% sys=tf(num,deno);
% figure;
% rlocus(sys)
% 
% clc;
% clear all;
% close all;
% num=[1 32 60];
% deno=[1 21 136 116];
% sys=tf(num,deno);
% rlocus(sys)
% 
% clc;
% clear all;
% close all;
% num=[1 30];
% deno=[1 23 178 388 232];
% sys=tf(num,deno);
% rlocus(sys)
% 
% clc;
% clear all;
% close all;
% num=[1 28 -60];
% deno=[1 21 136 116];
% sys=tf(num,deno);
% rlocus(sys)
% 
% clc;
% clear all;
% close all;
% syms s;
% num=sym2poly(2*(s+0.25));
% deno=sym2poly(s^2*(s+1)*(s+0.5));
% sys=tf(num,deno);
% [gm pm wcp wcf]=margin(sys);
% bode(sys)
% 
% clc;
% clear all;
% close all;
% syms s;
% num=sym2poly(s-1);
% deno=sym2poly((s+1)*(s+2));
% sys=tf(num,deno);
% figure;
% rlocus(sys)
% figure;
% nyquist(sys)
% 
% clc;
% clear all;
% close all;
% syms s;
% T=1;
% num1=1;
% deno1=sym2poly(s+1);
% G=tf(num1,deno1)
% num2=10;
% deno2=sym2poly(s);
% H=tf(num2,deno2);
% sys=feedback(G*T,H)
% nyquist(sys)
% 
% clc;
% clear all;
% close all;
% syms s;
% T=tf(sym2poly(s+0.05),1);
% num1=1;
% deno1=sym2poly(s+1);
% G=tf(num1,deno1);
% num2=10;
% deno2=sym2poly(s);
% H=tf(num2,deno2);
% sys=feedback(G*T,H);
% nyquist(sys)
% 
% clc;
% clear all;
% close all;
% syms s;
% num=400;
% deno=sym2poly(s^2+30*s+200);
% sys=tf(num,deno);
% step(sys)
% 
% clc;
% clear all;
% close all;
% syms s;
% num=400;
% deno=sym2poly(s^2+30*s+200);
% sys=tf(num,deno);
% rlocus(sys)
% 
% clc;
% clear all;
% close all;
% syms s;
% num=400;
% deno=sym2poly(s^2+30*s+200);
% sys=tf(num,deno);
% bode(sys)
% [gm pm wcp wcf]=margin(sys)
% 
% clc;
% clear all;
% close all;
% syms s;
% num=sym2poly(40+0.5*s^2+9*s);
% deno=sym2poly(s*(s^2+30*s+200));
% sys=tf(num,deno);
% bode(sys)
% [gm pm wcp wcf]=margin(sys)
% 
% clc;
% clear all;
% close all;
% syms s;
% num=sym2poly(400*(40+0.5*s^2+9*s));
% deno=sym2poly(s*(s^2+30*s+200));
% sys=tf(num,deno);
% step(sys)