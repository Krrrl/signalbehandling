function [t, sig] = sumcos(koeff, N, fs, f1)

[rows, cols] = size(koeff);

Fs = 1/fs;

if N > rows
    N = rows;
end

t = 0:1/fs:(fs-1)/fs;

sig = koeff(1,1);

for i = 2:N
    amplitude = koeff(i,1);
    f = (i-1)*f1;
    fase = koeff(i,2);
    subsig = amplitude*cos(2*pi*f*t + fase);
    sig = sig + subsig;
end

%xlabel('t');
%ylabel('amplitude');
%title('synthesized signal');
%plot(t, sig);

end
