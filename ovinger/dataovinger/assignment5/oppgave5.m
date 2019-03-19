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

%assigning each signal their own plotting color
color_original = [0, 0, 0];
color_noised1 = [0, 0, 0.9];
color_noised2 = [0, 0.75, 0.25];
color_noised3 = [0.9, 0, 0];

%plotting of the raw ecg, and the noised signals.
figure('Name', 'All signals');
subplot(4, 1, 1);
plot(ecg_t_single_periode, ecg_raw(ecg_T), 'color', color_original);
grid minor
title('ECG signal without noise');

subplot(4, 1, 2);
plot(ecg_t_single_periode, ecg_noised1(ecg_T), 'color', color_noised1);
grid minor
title('1. ECG signal with noise[easy]');

subplot(4, 1, 3);
plot(ecg_t_single_periode, ecg_noised2(ecg_T), 'color', color_noised2);
grid minor
title('2. ECG signal with noise[medium]');

subplot(4, 1, 4);
plot(ecg_t_single_periode, ecg_noised3(ecg_T), 'color', color_noised3);
grid minor
title('3. ECG signal with noise[hard(?)]');

%Performing a DFT of the signals

%from assignment 2 we know that we need approximately N=60 for the DFT to
%accurately reconstruct the ECG signal.
DFT_ecg_raw = fft(ecg_raw(ecg_T), 120);
DFT_ecg_noised1 = fft(ecg_noised1(ecg_T));
DFT_ecg_noised2 = fft(ecg_noised2(ecg_T));
DFT_ecg_noised3 = fft(ecg_noised3(ecg_T));

%%%%%%%%%%%%%%%%%% 1. Noised signal %%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% DFT analysis %%%%%%%%%%%%%%%%%%%

%DFT analysis of the first signal
sig1_ABS = abs(DFT_ecg_noised1)/length(ecg_T);
sig1_ANG = angle(DFT_ecg_noised1);

for i = 1:length(ecg_T)
    if(sig1_ABS(i) < (max(sig1_ABS)/50))
        sig1_ANG(i) = 0;
    end
end

%Showing the DFT results from the first signal:
figure('Name', 'DFT components of 1. ECG signal');
subplot(2, 1, 1);
stem(ecg_T, sig1_ABS, 'color', color_noised1);
title('Absolute value of signal');

subplot(2, 1, 2);
stem(ecg_T, sig1_ANG, 'color', color_noised1);
title('Phase of signal');

%From reading the components of the DFT, identified manually
DFT_ecg_noised1(463) = 0;
DFT_ecg_noised1(51) = 0;

%%%%%%%%%%%%%%%%%% FILTER %%%%%%%%%%%%%%%%%%%

%applying the designed filter to the first signal.
%the filter was designed with the noise parameters estimated to be about
%A=0.1 and T_s = 0.02.
if(length(lowpass_designfilt) < length(ecg_t))
   pad_length = length(ecg_t) - length(lowpass_designfilt);
   lowpass_designfilt = [lowpass_designfilt zeros(1, pad_length)];  
end

%       ecg_noised1_lowpass_filtered = filter(lowpass_designfilt, ecg_noised1(ecg_T));
ecg_noied1_lowpass_filtered = freqz(lowpass_designfilt, ecg_noised1);

%Canceling the delay caused by the filtering
ecg_noised1_lowpass_filtered_shifted = negate_filter_delay(lowpass_designfilt, ecg_t, ecg_noised1_lowpass_filtered);


%plotting the results of the filtering
figure('Name', ' 1. ECG signal processing');

subplot(5, 1, 1);
plot(ecg_t_single_periode, ecg_raw(ecg_T), 'color', color_original);
grid minor
title('Signal without noise');

subplot(5, 1, 2);
plot(ecg_t_single_periode, ecg_noised1(ecg_T), 'color', color_noised1);
grid minor
title('Signal with noise');

subplot(5, 1, 3);
plot(ecg_t_single_periode, ecg_noised1_lowpass_filtered(ecg_T), 'color', color_noised1);
grid minor
title('Lowpass filtered, non-shifted signal');

subplot(5, 1, 4);
plot(ecg_t_single_periode, ecg_noised1_lowpass_filtered_shifted(ecg_T), 'color', color_noised1);
grid minor
title('Lowpass filtered and shifted signal');

subplot(5, 1, 5);
plot(ecg_t_single_periode, ifft(DFT_ecg_noised1), 'color', color_noised1);
grid minor
title('DFT reconstructed signal, n = 51 = 463 = 0');


%%%%%%%%%%%%%%%%%% 2. Noised signal %%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% DFT analysis %%%%%%%%%%%%%%%%%%%

sig2_ABS = abs(DFT_ecg_noised2)/length(ecg_T);
sig2_ANG = angle(DFT_ecg_noised2); 

for i = 1:length(ecg_T)
    if(sig2_ABS(i) < (max(sig2_ABS)/50))
        sig2_ANG(i) = 0;
    end
end

%Showing the DFT results from the second signal:
figure('Name', 'DFT components of 2. ECG signal');
subplot(2, 1, 1);
stem(ecg_T, sig2_ABS, 'color', color_noised2);
title('Absolute value of 2. noised signal');

subplot(2, 1, 2);
stem(ecg_T, sig2_ANG, 'color', color_noised2);
title('Phase of 2. noised signal');

DFT_ecg_noised2(463) = 0;
DFT_ecg_noised2(51) = 0;

DFT_ecg_noised2(473) = 0;
DFT_ecg_noised2(41) = 0;

DFT_ecg_noised2(483) = 0;
DFT_ecg_noised2(31) = 0;

%%%%%%%%%%%%%%%%%% FILTER %%%%%%%%%%%%%%%%%%%

if(length(lowpass_designfilt) < length(ecg_t))
   pad_length = length(ecg_t) - length(lowpass_designfilt);
   lowpass_designfilt = [lowpass_designfilt zeros(1, pad_length)];  
end

%Placeholder
ecg_noised2_lowpass_filtered_shifted = zeros(1, length(ecg_t));



figure('Name', '2. ECG signal processing');
subplot(4, 1, 1);
plot(ecg_t_single_periode, ecg_raw(ecg_T), 'color', color_original);
grid minor
title('ECG signal without noise');

subplot(4, 1, 2);
plot(ecg_t_single_periode, ecg_noised2(ecg_T), 'color', color_noised2);
grid minor
title('2. ECG signal with noise');

subplot(4, 1, 3);
plot(ecg_t_single_periode, ecg_noised2_lowpass_filtered_shifted(ecg_T), 'color', color_noised2);
grid minor
title('Lowpass filtered 2. ECG with noise');

subplot(4, 1, 4);
plot(ecg_t_single_periode, ifft(DFT_ecg_noised2), 'color', color_noised2);
grid minor
title('2. ECG signal reconstructed after DFT component removal');

%%%%%%%%%%%%%%%%%% 3. Noised signal %%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% DFT analysis %%%%%%%%%%%%%%%%%%%

sig3_ABS = abs(DFT_ecg_noised3)/length(ecg_T);
sig3_ANG = angle(DFT_ecg_noised3); 

for i = 1:length(ecg_T)
    if(sig3_ABS(i) < (max(sig3_ABS)/50))
        sig3_ANG(i) = 0;
    end
end

%Showing the DFT results from the third signal:
figure('Name', 'DFT components of 3. ECG signal');
subplot(2, 1, 1);
stem(ecg_T, sig3_ABS, 'color', color_noised3);
title('Absolute value of 3. noised signal');

subplot(2, 1, 2);
stem(ecg_T, sig3_ANG, 'color', color_noised3);
title('Phase of 3. noised signal');

%DFT_ecg_noised3(463) = 0;
%DFT_ecg_noised3(51) = 0;

%DFT_ecg_noised3(473) = 0;
%DFT_ecg_noised3(41) = 0;

%DFT_ecg_noised3(483) = 0;
%DFT_ecg_noised3(31) = 0;

DFT_ecg_noised3(20:490) = 0;

%%%%%%%%%%%%%%%%%% FILTER %%%%%%%%%%%%%%%%%%%

if(length(lowpass_designfilt) < length(ecg_t))
   pad_length = length(ecg_t) - length(lowpass_designfilt);
   lowpass_designfilt = [lowpass_designfilt zeros(1, pad_length)];  
end

%Placeholder
ecg_noised3_lowpass_filtered_shifted = zeros(1, length(ecg_t));



figure('Name', '3. ECG signal processing');
subplot(4, 1, 1);
plot(ecg_t_single_periode, ecg_raw(ecg_T), 'color', color_original);
grid minor
title('ECG signal without noise');

subplot(4, 1, 2);
plot(ecg_t_single_periode, ecg_noised3(ecg_T), 'color', color_noised3);
grid minor
title('3. ECG signal with noise');

subplot(4, 1, 3);
plot(ecg_t_single_periode, ecg_noised3_lowpass_filtered_shifted(ecg_T), 'color', color_noised3);
grid minor
title('Lowpass filtered 3. ECG with noise');

subplot(4, 1, 4);
plot(ecg_t_single_periode, ifft(DFT_ecg_noised3), 'color', color_noised3);
grid minor
title('3. ECG signal reconstructed after DFT component removal');