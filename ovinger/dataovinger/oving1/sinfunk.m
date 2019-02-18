function x = sinfunk(f1)
x=sinfunk(f1)
%
%Denne funksjonen lager et sinusformet signal med frekvens f1.
%Samplingsfrekvensen er 8000Hz, f1 må derfor være mindre enn
%4000Hz.
%
%Eksempel: x = sinfunk(440)


Fs = 8000; %Samplinger per sekund
Ts = 1/Fs; %Samplingsfrekvens
t = 0:Ts:5; 
x = sin(2*pi*f1*t);
plot(t(1:1000), x(1:1000)), xlabel('t'), ylabel('x(t)'), title('sin(2*pi*440*t)');
soundsc(x,Fs);