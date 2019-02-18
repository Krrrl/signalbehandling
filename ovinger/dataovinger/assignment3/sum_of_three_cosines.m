function p = sum_of_three_cosines(f1, fs, p1, p2, p3)

%default values if function is run with less than spesified arguments

if nargin == 0
    f1 = 1;
    fs = 512;
    Fs = 1/fs;
    t = 0:(Fs):(1-Fs);
    p1 = 5*cos(6*pi*f1*t+pi);
    p2 = 3*cos(2*pi*f1*t);
    p3 = 3*cos(50*pi*f1*t + (pi/4));
    p = p1 + p2 + p3;
    plot(t, p), xlabel('t'), ylabel('p(t)'), title('Sum of three cosines');
elseif nargin == 1
    fs = 512;
    Fs = 1/fs;
    t = 0:(Fs):(1-Fs);
    p1 = 5*cos(6*pi*f1*t+pi);
    p2 = 3*cos(2*pi*f1*t);
    p3 = 3*cos(50*pi*f1*t + (pi/4));
    p = p1 + p2 + p3;
    plot(t, p), xlabel('t'), ylabel('p(t)'), title('Sum of three cosines');
elseif nargin == 2
    Fs = 1/fs;
    t = 0:(Fs):(1-Fs);
    p1 = 5*cos(6*pi*f1*t+pi);
    p2 = 3*cos(2*pi*f1*t);
    p3 = 3*cos(50*pi*f1*t + (pi/4));
    p = p1 + p2 + p3;
    plot(t, p), xlabel('t'), ylabel('p(t)'), title('Sum of three cosines');
elseif nargin == 3
    Fs = 1/fs;
    t = 0:(Fs):(1-Fs);
    p2 = 3*cos(2*pi*f1*t);
    p3 = 3*cos(50*pi*f1*t + (pi/4));
    p = eval(p1) + p2 + p3;
    plot(t, p), xlabel('t'), ylabel('p(t)'), title('Sum of three cosines');
elseif nargin == 4
    Fs = 1/fs;
    t = 0:(Fs):(1-Fs);
    p3 = 3*cos(50*pi*f1*t + (pi/4));
    p = eval(p1) + eval(p2) + p3;
    plot(t, p), xlabel('t'), ylabel('p(t)'), title('Sum of three cosines');
elseif nargin == 5
    Fs = 1/fs;
    t = 0:(Fs):(1-Fs);
    p = eval(p1) + eval(p2) + eval(p3);
    plot(t, p), xlabel('t'), ylabel('p(t)'), title('Sum of three cosines');
end

