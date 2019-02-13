Fs = 8000; %Samplinger per sekund
Ts = 1/Fs; %Samplingsfrekvens
t = 0:Ts:5; 
x1 = sin(2*pi*440*t);
plot(t,x);
plot(t(1:1000), x(1:1000)), xlabel('t'), ylabel('x(t)'), title('sin(2*pi*440*t)');
