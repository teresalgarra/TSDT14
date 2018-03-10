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
H_hd_th(1:6553) = 1;
H_hd_th(6554:58982) = 0;
H_hd_th(58983:65536) = 1;

%Final signal
Y_hd_th = X.*H_hd_th;

%%Results%%
R_hd_th = abs(H_hd_th).^2;
r_hd_th = 2*0.1*sinc(2*0.1*nn);

%%Estimated functions%%

%20th degree filter
[b,a] = butter(20,2*0.1,'low');

%Final signal
y_hd_es = filter(b,a,x);
Y_hd_es = fft(y_hd_es);

%%Results%%
r_hd_es = acf(y_hd_es);
R_hd_es = abs(fft(r_hd_es));

%%%LOW DEGREE FILTER%%%

%%Theoretical functions%%

%Theoretical filter
H_ld_th = 1./(1-0.9*exp(-1i*2*pi*ff));

%Final signal
Y_ld_th = X.*H_ld_th;

%%Results%%
R_ld_th = abs(H_ld_th).^2;
r_ld_th = 2*(1-0.78)/(1+0.78).*0.78.^(abs(nn));

%%Estimated functions%%

%1st degree filter
[d,c] = butter(1,2*0.1);

%Final signal
y_ld_es = filter(d,c,x);
Y_ld_es = fft(y_ld_es);

%%Results%%
r_ld_es = acf(y_ld_es);
R_ld_es = abs(fft(r_ld_es));

%%%PLOT ZONE%%%

%Noise
figure;     %1
plot(tt, x, 'm'); axis tight;
title('Input noise in Time Domain');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/x','-dpng');

%%High degree filter%%

%Filter absolute value
figure;     %2
plot(ff, abs(H_hd_th), 'b'); axis tight;
title('Filter (absolute value)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/abs(H_hd_th)','-dpng');
%Theoretical ACF
figure;     %3
plot(nn, r_hd_th, 'm');
title('Theoretical ACF plotted'); axis tight;
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_hd_th_plot','-dpng');
figure;     %4
stem(nn, r_hd_th, 'b'); xlim([-20,20]);
title('Theoretical ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_hd_th_stem','-dpng');
%Theoretical PSD
figure;     %5
plot(ff, R_hd_th, 'c'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/R_hd_th','-dpng');

%Estimated ACF
figure;     %6
plot(nn, r_hd_es, 'm');
title('Estimated ACF plotted'); axis tight;
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_hd_es_plot','-dpng');
figure;     %7
stem(nn, r_hd_es, 'b'); xlim([-20,20]);
title('Estimated ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_hd_es_stem','-dpng');
%Estimated PSD
figure;     %8
plot(ff, R_hd_es, 'c'); xlim([0,1]);
title('Estimated PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/R_hd_es','-dpng');

%%Low degree filter%%

%Filter absolute value
figure;     %9
plot(ff, abs(H_ld_th), 'b'); axis tight;
title('Filter (absolute value)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/abs(H_ld_th)','-dpng');
%Theoretical ACF
figure;     %10
plot(nn, r_ld_th, 'm');
title('Theoretical ACF plotted'); axis tight;
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_ld_th_plot','-dpng');
figure;     %11
stem(nn, r_ld_th, 'b'); xlim([-20,20]);
title('Theoretical ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_ld_th_stem','-dpng');
%Theoretical PSD
figure;     %12
plot(ff, abs(H_ld_th), 'c');
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/R_ld_th','-dpng');

%Estimated ACF
figure;     %13
plot(nn, r_ld_es, 'm');
title('Estimated ACF plotted'); axis tight;
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_ld_es_plot','-dpng');
figure;     %14
stem(nn, r_ld_es, 'b'); xlim([-20,20]);
title('Estimated ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_ld_es_stem','-dpng');
%Estimated PSD
figure;     %15
plot(ff, R_ld_es, 'c'); xlim([0,1]);
title('Estimated PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/R_ld_es','-dpng');
