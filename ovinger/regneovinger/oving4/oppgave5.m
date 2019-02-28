%Regneøving 4, oppgave 5.

x = @(t) 2*cos(2*pi*50*t + pi/2) + cos(2*pi*150*t);
max_sampl = 3000; %Samplingshastighet høy nok til å garantere korrekt gjenngivelse av signalet.
max_freq = 1/max_sampl;
t_cont = linspace(0,(1-max_freq), max_sampl);
figure(1);
plot(t_cont,x(t_cont));
xlabel('time');
ylabel('amplitude')
title('Input signal x(t) drawn at 3000 Hz');
%^Creates a expression for x based on a symbolic t, to be given later.

%a) 
%Shannon-Nyquist teoremet forteller oss da at [fs >= 300 Hz]
min_sampl = 300;
min_freq = 1/min_sampl;
t_disc_min = (0:min_freq:(1-min_freq));
figure(2);
plot_signal = plot(t_cont, x(t_cont), 'b');
xlabel('time');
ylabel('amplitude')
title('Signal and signal sampled at 300 Hz')

hold on
plot_sampled = stem(t_disc_min, x(t_disc_min), 'r');
hold off
legend([plot_sampled, plot_signal],'Signal sampled at 300 Hz', 'Input signal drawn at 3000 Hz');

%b)
f = 250; %samples per sekund
fs = (1/f); %samplingshastighet

t_250freq = 0:fs:(1-fs);

x_250freq = x(t_250freq);

X_sum = (fft(x_250freq)/f);
X_abs = abs(X_sum);
X_ang = angle(X_sum);

for i = 1:f
    if(X_abs(i) < (max(X_abs)/100))
        X_ang(i) = 0;
    end
end

figure(3);
plot_250abs = stem((0:249),X_abs, 'b');
hold on
plot_250ang = stem((0:249),X_ang, 'r');
hold off
xlabel('coefficient number');
ylabel('amplitude');
title('Absolute value and phase from DFT of 250 Hz signal');
legend([plot_250abs, plot_250ang], 'Absolute value', 'Angle');

figure(4);
plot_signal = plot(t_cont, x(t_cont), 'b');
xlabel('time');
ylabel('amplitude');
title('Input signal and signal sampled at 250 Hz');
hold on
plot_250freq = stem(t_250freq, x_250freq, 'r');
hold off
legend([plot_signal, plot_250freq], 'Input signal drawn at 3000 Hz', 'Input signal sampled at 250 Hz');

%^Noe blir ikke helt rett i b).
%c)