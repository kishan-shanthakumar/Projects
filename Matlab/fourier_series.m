disp("1.Sine Wave");
disp("2.Triangle Wave");
disp("3.Square Function");
ch = input("Select a function ");

if ch==1
    %Sine Wave
    f=input("Enter the frequency of the wave ");
    syms t;
    fplot(sin(2*pi*f*t),[-10 10]);
end

if ch==2
    %Sawtooth Wave
    f=input("Enter the frequency of the wave ");
    syms t;
    plot(mod((-10:1/f:10),1))
end

if ch==3
    %Square Wave
    f=input("Enter the frequency of the wave ");
    syms t;
    fplot(ceil(sin(2*pi*f*t)),[-10 10])
end