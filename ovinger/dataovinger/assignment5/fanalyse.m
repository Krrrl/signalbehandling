function [sig_ABS, sig_ANG] = fanalyse(signal, N, fs, printout)

if ~exist('printout', 'var')
    printout = nan;
end

dft_signal = fft(signal, N);

t_signal = 1:length(signal);
T_signal = ((fs*t_signal)/N);

sig_ABS = abs(dft_signal)/length(N);
sig_ANG = angle(dft_signal);

for i = 1:N
    if(sig_ABS(i) < (max(sig_ABS)/100))
        sig_ANG(i) = 0;
    end
end

if ~isnan(printout)
    %Showing the DFT results from the signal:
    figure('Name', 'DFT components of signal');
    subplot(2, 1, 1);
    stem(T_signal, sig_ABS);
    title('Absolute value of signal');

    subplot(2, 1, 2);
    stem(T_signal, sig_ANG);
    title('Phase of signal');
end

end
