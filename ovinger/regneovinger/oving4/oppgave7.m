%Oppgave 7

x1 = @(n) cos(0.8*pi*n + 0.2*pi);
x2 = @(n) cos(-2.8*pi*n + 0.2*pi);
x3 = @(n) x1(n) + x2(n);
x4 = @(n) cos(5.2*pi*n - 0.2*pi);
x5 = @(n) x1(n) + cos(-7.1*pi*n - 0.1*pi);

t = 0:(1/(7.1*pi*10)):(20/7.1*pi);

figure(1);
subplot(5, 1, 1);
plot(t, x1(t), 'b');
grid minor
title('cos(0.8pi*n + 0.2pi)')


subplot(5, 1, 2);
plot(t, x2(t));
grid minor
title('cos(-2.8pi*n + 0.2pi)')


subplot(5, 1, 3);
plot(t, x3(t));
grid minor
title('cos(0.8pi n + 0.2pi) + cos(-2.8pi*n + 0.2pi)')


subplot(5, 1, 4);
plot(t, x4(t));
grid minor
title('cos(5.2pi*n - 0.2pi)')


subplot(5, 1, 5);
plot(t, x5(t));
grid minor
title('cos(0.8pi n + 0.2pi) + cos(-7.1*pi*n - 0.1*pi)')

