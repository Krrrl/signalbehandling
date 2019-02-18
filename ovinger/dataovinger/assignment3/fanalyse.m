function [Xabs, Xang] = fanalyse(signal, N, fs)
%k = 1/N; %koeffisient nummer.. Hva skal k være?

sampled_time = N/fs;
Fs = 1/fs;


t = 0:Fs:(sampled_time-Fs); %Dette blir ikke rett?

%signal = str2func(input('Input function to FFT: '));

%T = t*2*pi;
T = 1:N;

X = fft(signal(T), N);

Xabs = (abs(X)/(N));
Xang = angle(X);

figure;
plot(t, signal(T)), xlabel('t'),
                            ylabel('x(t)'),
                                title('The input signal');

figure;
stem(t, Xabs), xlabel('t'), 
                ylabel('Amplitude'), 
                    title('Absolute values of Signal');

figure;
stem(t, Xang), xlabel('t'),
                ylabel('phase'),
                   title('Phasediagram of Signal');
