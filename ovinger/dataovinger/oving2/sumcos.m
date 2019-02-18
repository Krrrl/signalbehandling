function [sig t] = sumcos(koeff, N, fs, f1)

[rows, cols] = size(koeff);

Fs = 1/fs;

if N > rows
    N = rows;
end

t = 0:Fs:(1-fs)/fs;

sig = koeff(1,1);

for i = 2:N
    amplitude = koeff(i,i);
    f = (i-1)*f1;
    fase = koeff(i,2);
    subsig = amplitude*cos(2*pi*f*t + fase);
    sig = sig + subsig;
end

end
