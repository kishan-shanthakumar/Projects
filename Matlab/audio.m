clc
clear all
close all
[x,Fs]=audioread('/home/kishan/Downloads/bensound-summer.mp3');
x = [x;[0 0];[0 0];[0 0];[0 0]];
t=linspace(0,length(x)/Fs,length(x));
subplot(2,2,1);
plot(t,x);
xlabel('Position');
ylabel('Amplitude');
title('Audio');
z=1;
[m,n] = size(x);
if n==2
    y = x(1:z:m,1) + x(1:z:m,2);
    peakAmp = max(abs(y));
    y = y/peakAmp;
    peakL = max(abs(x(:, 1)));
    peakR = max(abs(x(:, 2))); 
    maxPeak = max([peakL peakR]);
    y = y*maxPeak;
else
    y=x;
end
subplot(2,2,2);
plot(t,y);
xlabel("Position");
ylabel("Audio");
title("Mono Audio");
subplot(2,2,3)
plot(abs((fft(y))));
xlim([0 400000])
psdest = psd(spectrum.periodogram,y,'Fs',Fs,'NFFT',length(y));
subplot(2,2,4);
plot(psdest.Frequencies,psdest.Data)
xlim([0 1000])
[~,I] = max(psdest.Data);
fprintf('Maximum occurs at %d Hz.\n',psdest.Frequencies(I));