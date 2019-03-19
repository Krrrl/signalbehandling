%Loading of the ecgdata
ecgdata = load('ecgdata2.dat', '-mat');

%Set verbose ~nan if DFT visualization is wanted.
verbose_dft = nan;
verbose_all_comp = nan;

%extracting the ecgdata into seperate workspace entities
ecg_raw = ecgdata.ecg3;
ecg_noised1 = ecgdata.sig1;
ecg_noised2 = ecgdata.sig2;
ecg_noised3 = ecgdata.sig3;
ecg_t = ecgdata.t;
fs = 512;
ecg_t_single_periode = ecg_t(1:fs);
ecg_T = 1:fs;

%assigning each signal their own plotting color
color_original = [0, 0, 0];
color_noised1 = [0, 0, 0.9];
color_noised2 = [0.5686, 0.1176, 0.7059];
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
title('3. ECG signal with noise[hard]');

%%%%%%%%%%%%%%%%%% 1. Noised signal %%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% DFT analysis %%%%%%%%%%%%%%%%%%%

%DFT analysis of the first signal
[DFT_ABS_noised1, DFT_ANG_noised1] = fanalyse(ecg_noised1(ecg_T), length(ecg_T), fs, verbose_dft);
DFT_ecg_noised1 = DFT_ABS_noised1 .* exp(1i * DFT_ANG_noised1);
%DFT_ecg_noised1_single_periode = DFT_ecg_noised1(1:length(ecg_T);

%From reading the components of the DFT, identified manually
DFT_ecg_noised1(463) = 0;
DFT_ecg_noised1(51) = 0;

%%%%%%%%%%%%%%%%%% FIR FILTER %%%%%%%%%%%%%%%%%%%

%applying the designed filter to the first signal.
%the filter was designed with the noise parameters estimated to be about
%A=0.1 and T_s = 0.02.

lowpass_designfilt = designfilt('lowpassfir', 'PassbandFrequency', 13, 'StopbandFrequency', 25, 'PassbandRipple', 1, 'StopbandAttenuation', 30, 'SampleRate', 512);

ecg_noised1_lowpass_filtered = filter(lowpass_designfilt, ecg_noised1);

%Canceling the delay caused by the filtering
ecg_noised1_lowpass_filtered_shifted = negate_filter_delay(lowpass_designfilt, ecg_t, ecg_noised1_lowpass_filtered);


if ~isnan(verbose_all_comp)
    %plotting the results of the filtering compared to manual DFT processing.
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
    plot(ecg_t_single_periode, real(ifft(DFT_ecg_noised1(ecg_T))), 'color', color_noised1);
    grid minor
    title('DFT reconstructed signal, n = 51 = 463 = 0');
end

%%%%%%%%%%%%%%%%%% 2. Noised signal %%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% DFT analysis %%%%%%%%%%%%%%%%%%%

[DFT_ABS_noised2, DFT_ANG_noised2] = fanalyse(ecg_noised2(ecg_T), length(ecg_T), fs, verbose_dft);
DFT_ecg_noised2 = DFT_ABS_noised2 .* exp(1i * DFT_ANG_noised2);

DFT_ecg_noised2(463) = 0;
DFT_ecg_noised2(51) = 0;

DFT_ecg_noised2(473) = 0;
DFT_ecg_noised2(41) = 0;

DFT_ecg_noised2(483) = 0;
DFT_ecg_noised2(31) = 0;

%%%%%%%%%%%%%%%%%% FIR FILTER %%%%%%%%%%%%%%%%%%%

ecg_noised2_lowpass_filtered = filter(lowpass_designfilt, ecg_noised2);

ecg_noised2_lowpass_filtered_shifted = negate_filter_delay(lowpass_designfilt, ecg_t, ecg_noised2_lowpass_filtered);

if ~isnan(verbose_all_comp)
    figure('Name', '2. ECG signal processing');
    subplot(5, 1, 1);
    plot(ecg_t_single_periode, ecg_raw(ecg_T), 'color', color_original);
    grid minor
    title('ECG signal without noise');

    subplot(5, 1, 2);
    plot(ecg_t_single_periode, ecg_noised2(ecg_T), 'color', color_noised2);
    grid minor
    title('2. ECG signal with noise');

    subplot(5, 1, 3);
    plot(ecg_t_single_periode, ecg_noised2_lowpass_filtered(ecg_T), 'color', color_noised2);
    grid minor
    title('Lowpass filtered, non-shifted signal');

    subplot(5, 1, 4);
    plot(ecg_t_single_periode, ecg_noised2_lowpass_filtered_shifted(ecg_T), 'color', color_noised2);
    grid minor
    title('Lowpass filtered and shifted signal');

    subplot(5, 1, 5);
    plot(ecg_t_single_periode, real(ifft(DFT_ecg_noised2(ecg_T))), 'color', color_noised2);
    grid minor
    title('2. ECG signal reconstructed after DFT component removal');
end

%%%%%%%%%%%%%%%%%% 3. Noised signal %%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% DFT analysis %%%%%%%%%%%%%%%%%%%

[DFT_ABS_noised3, DFT_ANG_noised3] = fanalyse(ecg_noised3(ecg_T), length(ecg_T), fs, verbose_dft);
DFT_ecg_noised3 = DFT_ABS_noised3 .* exp(1i * DFT_ANG_noised3);

%DFT_ecg_noised3(463) = 0;
%DFT_ecg_noised3(51) = 0;

%DFT_ecg_noised3(473) = 0;
%DFT_ecg_noised3(41) = 0;

%DFT_ecg_noised3(483) = 0;
%DFT_ecg_noised3(31) = 0;

DFT_ecg_noised3(20:490) = 0;

%%%%%%%%%%%%%%%%%% FIR FILTER %%%%%%%%%%%%%%%%%%%

ecg_noised3_lowpass_filtered = filter(lowpass_designfilt, ecg_noised3);

%Canceling the delay caused by the filtering
ecg_noised3_lowpass_filtered_shifted = negate_filter_delay(lowpass_designfilt, ecg_t, ecg_noised3_lowpass_filtered);

if ~isnan(verbose_all_comp)
    figure('Name', '3. ECG signal processing');
    subplot(5, 1, 1);
    plot(ecg_t_single_periode, ecg_raw(ecg_T), 'color', color_original);
    grid minor
    title('ECG signal without noise');

    subplot(5, 1, 2);
    plot(ecg_t_single_periode, ecg_noised3(ecg_T), 'color', color_noised3);
    grid minor
    title('3. ECG signal with noise');

    subplot(5, 1, 3);
    plot(ecg_t_single_periode, ecg_noised3_lowpass_filtered(ecg_T), 'color', color_noised3);
    grid minor
    title('Lowpass filtered, non-shifted signal');

    subplot(5, 1, 4);
    plot(ecg_t_single_periode, ecg_noised3_lowpass_filtered_shifted(ecg_T), 'color', color_noised3);
    grid minor
    title('Lowpass filtered and shifted signal');

    subplot(5, 1, 5);
    plot(ecg_t_single_periode, real(ifft(DFT_ecg_noised3(ecg_T))), 'color', color_noised3);
    grid minor
    title('3. ECG signal reconstructed after DFT component removal');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Final result plotting %%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%% 1. signal %%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'Final result 1. signal[easy]');
org_1 = plot(ecg_t_single_periode, ecg_raw(ecg_T), 'color', color_original);
hold on
grid minor
lp_s1 = plot(ecg_t_single_periode, ecg_noised1_lowpass_filtered_shifted(ecg_T), 'r');
hold on
dft_r1 = plot(ecg_t_single_periode, real(ifft(DFT_ecg_noised1(ecg_T))), 'b');
hold off
legend([org_1, lp_s1, dft_r1], 'Original signal', 'Lowpass shifted signal', 'Manual DFT reconstruction');

%%%%%%%%%%%%%%%% 2. signal %%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'Final result 2. signal[medium]');
org_2 = plot(ecg_t_single_periode, ecg_raw(ecg_T), 'color', color_original);
hold on
grid minor
lp_s2 = plot(ecg_t_single_periode, ecg_noised2_lowpass_filtered_shifted(ecg_T), 'r');
hold on
dft_r2 = plot(ecg_t_single_periode, real(ifft(DFT_ecg_noised2(ecg_T))), 'b');
hold off
legend([org_2, lp_s2, dft_r2], 'Original signal', 'Lowpass shifted signal', 'Manual DFT reconstruction');

%%%%%%%%%%%%%%%% 1. signal %%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'Final result 3. signal[hard]');
org_3 = plot(ecg_t_single_periode, ecg_raw(ecg_T), 'color', color_original);
hold on
grid minor
lp_s3 = plot(ecg_t_single_periode, ecg_noised3_lowpass_filtered_shifted(ecg_T), 'r');
hold on
dft_r3 = plot(ecg_t_single_periode, real(ifft(DFT_ecg_noised3(ecg_T))), 'b');
hold off
legend([org_3, lp_s3, dft_r3], 'Original signal', 'Lowpass shifted signal', 'Manual DFT reconstruction');