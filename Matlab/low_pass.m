clc;

f0=input("Enter the cutoff frequency ");

% 4 term window
a0 = 0.40217;
a1 = 0.49703;
a2 = 0.09892;
a3 = 0.00188;

syms f
syms t

subplot(3,2,4);
fplot(rectangularPulse(-f0,f0,f),[-1.5*f0 1.5*f0]);
title('Ideal Low Pass Filter');

ft=int(exp(1i*2*pi*f*t),f,-f0,f0);

subplot(3,2,3);
fplot(ft);
xlim([-5/f0 5/f0]);
ylim([-100 100])
title('x(t)');

L=1/f0;

win = a0 - a1 * (cos(pi*(t-1/(f0))*f0)) + a2 * (cos(2*pi*(t-1/(f0))*f0)) - a3 * (cos(3*pi*(t-1/(f0))*f0));

subplot(3,2,1);
fplot(win);
xlim([-1/f0 1/f0]);
title('Window Function')

wf=int(win*exp(-1i*2*pi*t*f),t,-f0,f0);
subplot(3,2,2);
fplot(db(wf));
xlim([-10/f0 10/f0]);
title('Frequency Response of window');

ff=win*ft;

subplot(3,2,5);
fplot(ff);
xlim([-5/f0 5/f0]);
ylim([-100 100])
title('Modified time domain function');

fr=int(ff*exp(-1i*2*pi*t*f),t,-1/f0,1/f0);

subplot(3,2,6);
fplot(db(fr),[-15*f0 15*f0]);
title('Practical Low Pass Filter');