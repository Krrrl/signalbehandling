load('ecgdata.dat','-mat');

%Task 1a and 1b

figure();
[x1,y1] = sumcos(rectkoeff, 6, 512, 1);

xlabel('t');
ylabel('amplitude');
title('Comparison of synthesized squarepulse signals');
plot(x1, y1);
hold on;

[x2,y2] = sumcos(rectkoeff, 15, 512, 1);

xlabel('t');
ylabel('amplitude');
title('Comparison of synthesized squarepulse signals');
plot(x2, y2);
hold on;

[x3,y3] = sumcos(rectkoeff, 100, 512, 1);

xlabel('t');
ylabel('amplitude');
title('Comparison of synthesized squarepulse signals');
plot(x3, y3);
hold off;

%Task 1c and 1d
figure();
[x4,y4] = sumcos(ecgkoeff, 15, 512, 1);

xlabel('t');
ylabel('amplitude');
title('Comparison of synthesized ECG signals');
plot(x4, y4);
hold on;

[x5,y5] = sumcos(ecgkoeff, 5, 512, 1);

xlabel('t');
ylabel('amplitude');
title('Comparison of synthesized ECG signals');
plot(x5, y5);
hold on;

[x6,y6] = sumcos(ecgkoeff, 60, 512, 1);

xlabel('t');
ylabel('amplitude');
title('Comparison of synthesized ECG signals');
plot(x6, y6);
hold on;

t = 0:1/512:(1-(1/512));
plot(t, ecg);
hold off;

disp('Around 60 coefficients is enough to synthesize the ECG properly');


