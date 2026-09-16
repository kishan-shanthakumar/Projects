clc;
clear all;
close all;

syms t;
syms f0;

f = input('Enter cutoff frequency ');
L = 1/f;

res=20;

% Hanning Window

n = -L:1/(f*res):L;

a0 = 0.40217;
a1 = 0.49703;
a2 = 0.09892;
a3 = 0.00188;

y1 = a0 - a1 * (cos(pi*(n-1/(f))*f)) + a2 * (cos(2*pi*(n-1/(f))*f)) - a3 * (cos(3*pi*(n-1/(f))*f));
wf = db(abs(fft(y1,2*res*f)));

subplot(3,2,1);
plot(n,y1);

subplot(3,2,2)
plot(wf);axis([-15*f 15*f -100 100]);

fr = 0:f/res:f;
idf = ones(1,res+1);

ft=int(exp(1i*2*pi*f0*t),f0,-f,f);
subplot(3,2,3);
fplot(ft);
ylim([-1 1])

subplot(3,2,4)
plot(fr,idf);
xlim([-0.5*f f*1.5]);
ylim([0.5 1.5]);

subplot(3,2,6)
plot(conv(idf,wf));
xlim([0 10*f]);

subplot(3,2,5)
plot(db(ifft(conv(idf,db2mag(wf)))));
xlim([-L L]);

function [Xk]=calcdft(xn)
L=length(xn);
N=L;
x1=xn;
for k=0:1:N-1
    for n=0:1:N-1
        p=exp(-1i*2*pi*n*k/N);
        T(k+1,n+1)=p;
    end
end
Xk=T*x1.';
end

function [xn]=calcidft(Xk)
N=length(Xk);
for k=0:1:N-1;
    for n=0:1:N-1
        p=exp(1i*2*pi*n*k/N);
        IT(k+1,n+1)=p;
    end
end
xn=(IT*(Xk.'))./N;
end

function [y]=calcconv(x,h)
l1=length(x);
l2=length(h);
N = l1+l2-1;
for n=1:1:N
    y(n)=0;
    for k=1:1:l1
        if(n-k+1>=1 & n-k+1<=(min(l1,l2)^2))
            y(n)=y(n)+x(k)*h(n-k+1);
        end
    end
end
end