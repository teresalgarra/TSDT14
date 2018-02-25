%%%STUDY 1%%%

clear;
clc;
close all;

%Data
N = 16;
x=randn(1,2^N);
X = (1/N)*fft(x);
Rx = 1;

%Vectors
Ts = 1;
nn = ((-2^N)/2)+1:Ts:(2^N)/2;
ff= linspace(0,1,2^N);
tt = 0:Ts:(2^N)-1;

%%%HIGH DEGREE FILTER%%%

%%Theoretical functions%%

%Ideal filter (rectangle)
H_hd_th = linspace(0,1,2^N);
H_hd_th(1:13107) = 1;
H_hd_th(13118:52428) = 0;
H_hd_th(52429:65536) = 1;

h_hd_th = 0.2*sinc(0.2*nn);

%Final signal
Y_hd_th = X.*H_hd_th;

%%Results%%
R_hd_th = abs(H_hd_th).^2;
r_hd_th = 0.2*sinc(0.2*nn);

%%Estimated functions%%

%20th degree filter
[b,a] = butter(10,2*0.2,'low');

%Final signal
y_hd_es = filter(b,a,x);
Y_hd_es = fft(y_hd_es);

%%Results%%
r_hd_es = acf(y_hd_es);
R_hd_es = abs(fft(r_hd_es));

%%%PLOT ZONE%%%
%Noise
figure;     %1
plot(tt, x, 'm'); axis tight;
title('Input noise in Time Domain');

%%High degree filter%%

%Filter absolute value
figure;     %2
plot(ff,abs(H_hd_th), 'b'); axis tight;
title('Filter (absolute value)');
%Theoretical ACF
figure;     %3
plot(nn, r_hd_th, 'm');
title('Theoretical ACF plotted'); axis tight;
figure;     %4
stem(nn,r_hd_th, 'b'); xlim([-20,20]);
title('Theoretical ACF Stemed');
%Theoretical PSD
figure;     %5
plot(ff,abs(H_hd_th), 'c');
title('Theoretical PSD');

%Estimated ACF
figure;     %6
plot(nn, r_hd_es, 'm');
title('Estimated ACF plotted'); axis tight;
figure;     %7
stem(nn,r_hd_es, 'b'); xlim([-20,20]);
title('Estimated ACF Stemed');
%Estimated PSD
figure;     %8
plot(ff,R_hd_es, 'c'); xlim([0,1]);
title('Estimated PSD');
