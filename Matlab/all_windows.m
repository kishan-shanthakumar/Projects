clc;
clear all;
close all;

disp('1. Hanning Window')
disp('2. Hamming Window')
disp('3. Blackman Window')
disp('4. Exact Blackmann')
disp('5. Minimum 3- term Window')
disp('6. 3-term Window')
disp('7. Minimum 4- term Window')
disp('8. 4-term Window')
disp('9. 3-Term with Continuous Third Derivative Window')
disp('10. 3-Term with Continuous First Derivative Window')
disp('11. 4-Term with Continuous Fifth Derivative Window')
disp('12. 4-Term with Continuous Third Derivative Window')
disp('13. 4-Term with Continuous First Derivative Window')
ch=input('Enter your choice ');

f=input("Enter the frequency range ");

L = 1/f;

n=0:1/(100*f):L;

a0=0;a1=0;a2=0;a3=0;

if ch==1
    % Hanning Window
    a0 = 0.5;
    a1 = 0.5;
end

if ch==2
    % Hamming Window
    a0 = 0.53836;
    a1 = 1 - 0.53836;
end

if ch==3
    % Blackman Window
    a0 = 0.42;
    a1 = 0.5;
    a2 = 0.08;
end

if ch==4
    % Exact Blackman Window
    a0 = 7938/18608;
    a1 = 9240/18608;
    a2 = 1430/18608;
end

if ch==5
    % Minimum 3-term Window
    a0 = 0.42323;
    a1 = 0.49755;
    a2 = 0.07922;
end

if ch==6
    % 3-term Window
    a0 = 0.44959;
    a1 = 0.49364;
    a2 = 0.05677;
end

if ch==7
    % Minimum 4-term Window
    a0 = 0.35875;
    a1 = 0.48829;
    a2 = 0.14128;
    a3 = 0.01168;
end

if ch==8
    % 4-term Window
    a0 = 0.40217;
    a1 = 0.49703;
    a2 = 0.09892;
    a3 = 0.00188;
end

if ch==9
    % 3-Term with Continuous Third Derivative Window
    a0 = 0.375;
    a1 = 0.5;
    a2 = 0.125;
end

if ch==10
    % 3-Term with Continuous First Derivative Window
    a0 = 0.40897;
    a1 = 0.5;
    a2 = 0.09103;
end

if ch==11
    % 4-Term with Continuous Fifth Derivative Window
    a0 = 10/32;
    a1 = 15/32;
    a2 = 6/32;
    a3 = 1/32;
end

if ch==12
    % 4-Term with Continuous Third Derivative Window
    a0 = 0.338946;
    a1 = 0.481973;
    a2 = 0.161054;
    a3 = 0.018027;
end

if ch==13
    % 4-Term with Continuous First Derivative Window
    a0 = 0.355768;
    a1 = 0.487396;
    a2 = 0.144232;
    a3 = 0.012604;
end

y1 = a0 - a1 * (cos(2*pi*n/L)) + a2 * (cos(4*pi*n/L)) - a3 * (cos(6*pi*n/L));

plot(db(abs(fft(y1,100*f))));axis([0 100*f/2 -100 100]);
wvtool(y1)