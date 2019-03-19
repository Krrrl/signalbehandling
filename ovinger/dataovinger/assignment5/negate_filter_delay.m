function [shifted_time, shifted_signal] = negate_filter_delay(numeric_filter, t_signal, delayed_signal)

delay = mean(grpdelay(numeric_filter));

shifted_signal = delayed_signal;
shifted_signal(1:delay) = [];

if length(shifted_signal) < length(t_signal)
    pad_length = length(t_signal) - length(shifted_signal);
    shifted_signal = [shifted_signal zeros(1, pad_length)];
end
        
%ecg_noised1_lowpass_filtered_shifted = [ecg_noised1_lowpass_filtered_shifted zeros(1, 111)];
%t_shifted = ecg_t(1:end-delay);
shifted_time = t_signal(1:end-delay);


end
