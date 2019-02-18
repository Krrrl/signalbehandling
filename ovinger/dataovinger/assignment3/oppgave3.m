


load('ecgdata.dat', '-mat');

fanalyse(ecg, 512, 512);

ecg3 = [ecg, ecg, ecg];

fanalyse(ecg3, 1536, 512);

%her er det noe galt, ettersom absoluttverdi plottene ikke gjennspeiler
%antallet koeffisienter man trenger for å rekonstruere signalet. Ref øving
%2.