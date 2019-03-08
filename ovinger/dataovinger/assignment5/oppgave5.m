%Loading of the ecgdata
ecgdata = load('ecgdata2.dat', '-mat');

%extracting the ecgdata into seperate workspace entities
ecg_raw = ecgdata.ecg3;
ecg_noised1 = ecgdata.sig1;
ecg_noised2 = ecgdata.sig2;
ecg_noised3 = ecgdata.sig3;
ecg_t = ecgdata.t;
ecg_t_single_periode = ecg_t(1:512);
ecg_T = 1:512;

%plotting of the raw ecg, and the noised signals.
figure(1);
subplot(4, 1, 1);
plot(ecg_t_single_periode, ecg_raw(ecg_T));
grid minor
title('ECG without noise');

subplot(4, 1, 2);
plot(ecg_t_single_periode, ecg_noised1(ecg_T));
grid minor
title('1. ECG with noise[easy]');

subplot(4, 1, 3);
plot(ecg_t_single_periode, ecg_noised2(ecg_T));
grid minor
title('2. ECG with noise[medium]');

subplot(4, 1, 4);
plot(ecg_t_single_periode, ecg_noised3(ecg_T));
grid minor
title('3. ECG with noise[hard(?)]');

%Performing a DFT of the signals

%from assignment 2 we know that we need approximately N=60 for the DFT to
%accurately reconstruct the ECG signal.
DFT_ecg_raw = fft(ecg_raw(ecg_T), 120);
DFT_ecg_noised1 = fft(ecg_noised1(ecg_T));
DFT_ecg_noised2 = fft(ecg_noised2(ecg_T));
DFT_ecg_noised3 = fft(ecg_noised3(ecg_T));



%Working on the first of the noised signals

%applying the designed filter to the first signal.
%the filter was designed with the noise parameters estimated to be about
%A=0.1 and T_s = 0.02.
ecg_noised1_lowpass_filtered = filter(lowpass_designfilt, ecg_noised1);

%Canceling the delay caused by the filtering
delay = mean(grpdelay(lowpass_designfilt));
%From the above we see that the delay is 111, which is half the order of
%the filter.
ecg_noised1_lowpass_filtered_shifted = ecg_noised1_lowpass_filtered;
ecg_noised1_lowpass_filtered_shifted(1:delay) = [];
%ecg_noised1_lowpass_filtered_shifted = [ecg_noised1_lowpass_filtered_shifted zeros(1, 111)];
ecg_T_shifted = ecg_t(1:end-delay);



%plotting the results of the filtering
figure(2);
subplot(4, 1, 1);
plot(ecg_t_single_periode, ecg_raw(ecg_T));
grid minor
title('ECG signal without noise');

subplot(4, 1, 2);
plot(ecg_t_single_periode, ecg_noised1(ecg_T));
grid minor
title('1. ECG signal with noise');

subplot(4, 1, 3);
plot(ecg_t_single_periode, ecg_noised1_lowpass_filtered_shifted(ecg_T));
grid minor
title('Lowpass filtered 1. ECG with noise');

subplot(4, 1, 4);
plot(ecg_t_single_periode, ifft(DFT_ecg_noised1));
grid minor
title('1. ECG signal reconstructed after filtering');




