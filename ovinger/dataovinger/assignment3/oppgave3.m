


load('ecgdata.dat', '-mat');

fanalyse(ecg, 512, 512);

ecg3 = [ecg, ecg, ecg];

fanalyse(ecg3, 1536, 512);
