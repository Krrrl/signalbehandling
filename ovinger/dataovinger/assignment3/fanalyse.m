function [Xabs, Xang] = fanalyse(signal, N, fs)
k = N; %koeffisient nummer.. Hva skal k være?

Fs = (fs*k)/N;

t = 0:(1/N):(1-(1/N)); %<-- can only handle looking into a 1 second period of the signal(smushes all in there).

%signal = str2func(input('Input function to FFT: '));

%T = t*2*pi;
T = 1:N;

X = fft(signal(T), N);

Xabs = (abs(X)/(N));
Xang = angle(X);

for i = 1:N
    if(Xabs(i) < (max(Xabs)/100))
        Xang(i) = 0;
    end
end

figure;
plot(t, signal(T)), xlabel('t'),
                            ylabel('x(t)'),
                                title('The input signal');

figure;
stem(T, Xabs), xlabel('sample[n]'), 
                ylabel('Amplitude'), 
                    title('Absolute values of Signal');

figure;
stem(T, Xang), xlabel('sample[n]'),
                ylabel('phase'),
                   title('Phasediagram of Signal');
