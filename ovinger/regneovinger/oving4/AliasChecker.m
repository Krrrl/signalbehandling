function [alias_points] = AliasChecker(y1, y2, fs)

%y1 and y2 are two cosines given on the form [amplitude frequency phase]
%for example: 5cos(2*pi90t + pi/2) is given as [5 2*pi*90 pi/2]

%First, we check if the lowest of the two frequencies is a 2*pi multiplum
%of the highest frequency

if(y1(2) >= y2(2))
    high_freq = y1(2);
    low_freq = y2(2);
else
    high_freq = y2(2);
    low_freq = y1(2);
end

%setting up analogue and discrete time axis
tn = 0:1/fs:20/fs;%(low_freq/(2*pi*fs));
ta = 0:1/(fs*16):20/fs;%(low_freq/(2*pi*fs));

%function for checking if a number is a positive integer:
pos_int_test = @(x) ((rem(x,1)==0) && (x > 0));

%sjekker om frekvensene "går opp" i hverandre
eq_sol1 = ((high_freq - low_freq)/(2*pi));
eq_sol2 = ((high_freq + low_freq)/(2*pi));

if(pos_int_test(eq_sol1))
    
elseif(pos_int_test(eq_sol2))
    
end

%reconstruction of inputted cosines
x1 = @(t) y1(1)*cos(y1(2)*t + y1(3));
x2 = @(t) y2(1)*cos(y2(2)*t + y2(3));

fig1 = figure(1);
subplot(2,1,1);
plot(ta, x1(ta), 'b');
hold on
stem(tn, x1(tn), 'filled', 'g');
hold off

subplot(2,1,2);
plot(ta, x2(ta), 'b');
hold on
stem(tn, x2(tn), 'filled', 'g');

waitfor(fig1);

%high_freq_mod = mod(high_freq, 2*pi);
%low_freq_mod = mod(low_freq, 2*pi);

%if(high_freq < 0)
%    high_freq_mod = -high_freq_mod;
%end

%if(low_freq < 0)
%    low_freq_mod = -low_freq_mod;
%end

%for i = 0:1:(high_freq+2*pi)
%    if(high_freq == (low_freq + 2*pi*i))
%        a(i) = 1;
%    elseif(high_freq == (2*pi*i - low_freq))
%        b(i) = 1;
%    end
%end

%if(~(isempty(a) && isempty(b)))
    
end

