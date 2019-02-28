%Oppgave 6

%x(t)
x = @(t) cos(2*pi*15*t) + cos(2*pi*17*t);

%a)
freq_range = -20:1:20;

x_values = [-17, -15, 15, 17];
y_values = [2, 2, 2, 2];
figure(1);
stem(x_values, y_values, 'filled');
grid;
xlim([-20 20]);
ylim([0 2.5]);




%b)
t = 0:1/(50*16):2;

f_center = 16;
f_delta = 1;

x_beat = 2*cos(2*pi*f_delta*t).*cos(2*pi*f_center*t);
x_envl = 2*cos(2*pi*f_delta*t);
x_envl2 = 2*cos(2*pi*f_delta*t + pi);
figure(2);
plot(t,x_beat, 'b');
hold on
plot(t, x_envl, '--r');
hold on
plot(t, x_envl2, '--r');
hold off
grid
xlabel('Tid[t]');
ylabel('Amplitude');
title('Beat notes');
%legend([x_beat, x_envl], 'Beat notes', 'Beat note "Envelope"');


