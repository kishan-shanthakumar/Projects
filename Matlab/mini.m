clc;
clear all;
close all;

f0=input("Enter the cutoff frequency ");

% 4 term window
a0 = 0.40217;
a1 = 0.49703;
a2 = 0.09892;
a3 = 0.00188;

syms f
syms t

subplot(3,3,5);
fplot((piecewise(-f0<f<f0,1,0)),[-1.5*f0 1.5*f0]);
title('Ideal Low Pass Filter');

subplot(3,3,6);
fplot(db(piecewise(-f0<f<f0,1,0)),[-1.5*f0 1.5*f0]);
title('Ideal Low Pass FIlter');

ft=int(exp(1i*2*pi*f*t),f,-f0,f0);

subplot(3,3,4);
fplot(ft);
xlim([-2/f0 2/f0]);
title('x(t)');

L=1/f0;

win = piecewise((-1/f0)<t<(1/f0),a0 - a1 * (cos(pi*(t-1/(f0))*f0)) + a2 * (cos(2*pi*(t-1/(f0))*f0)) - a3 * (cos(3*pi*(t-1/(f0))*f0)),0);

subplot(3,3,1);
fplot(win);
xlim([-2/f0 2/f0]);
title('Window Function')

wf=int((a0 - a1 * (cos(pi*(t-1/(f0))*f0)) + a2 * (cos(2*pi*(t-1/(f0))*f0)) - a3 * (cos(3*pi*(t-1/(f0))*f0)))*exp(-1i*2*pi*t*f),t,-f0,f0);
subplot(3,3,2);
fplot(wf);
xlim([-5*f0 5*f0]);
title("Frequency Response of Window");
subplot(3,3,3);
fplot(db(wf));
xlim([-5*f0 5*f0]);
title('Frequency Response of Window');

ff=win*ft;

subplot(3,3,7);
fplot(ff);
xlim([-5/f0 5/f0]);
title('Modified time domain function');

fr=int(ff*exp(-1i*2*pi*t*f),t,-1/f0,1/f0);

subplot(3,3,8);
fplot(fr,[-15*f0 15*f0]);
title('Practical Low Pass Filter');
subplot(3,3,9);
fplot(db(fr),[-15*f0 15*f0]);
title('Practical Low Pass Filter');