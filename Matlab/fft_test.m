clc;
clear all;
close all;
t=0:0.001:1;
x=sin(2*3.1415926535*60*t)+sin(2*3.1415926535*400*t)+sin(2*3.1415926535*250*t);
subplot(2,1,1)
plot(x)
Fs=1000;
psdest = psd(spectrum.periodogram,x,'Fs',Fs,'NFFT',length(x));
[~,I] = max(psdest.Data);
fprintf('Maximum occurs at %d Hz.\n',psdest.Frequencies(I));
subplot(2,1,2)
plot(psdest.Frequencies,psdest.Data)