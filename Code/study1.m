%% HIGH DEGREE FILTER %%

clear;
clc;
close all;

%%Data%%
N = 2^16;
x=randn(1,N)*sqrt(10);
X = fft(x, N);
Rx = 10;

%%Vectors%%
Ts = 1;
nn = ((-N)/2)+1:Ts:(N)/2;
ff= linspace(0,1,N);
tt = 0:Ts:(N)-1;

%%Ideal filter (rectangle)%%
H_hd = linspace(0,1,N);
H_hd(1:0.1*N) = 1;
H_hd(0.1*N+1:0.9*N) = 0;
H_hd(0.9*N+1:N) = 1;

%%Filtered signal%%
Y_hd = X.*H_hd;
y_hd = ifft(Y_hd);

%%Theoretical Results%%
R_hd_th = 10*abs(H_hd).^2;
r_hd_th = 10*2*2*0.1*sinc(2*0.1*nn);

%%Estimated Results%%
r_hd_es = 2*acf(y_hd);
R_hd_es = 0.5*abs(fft(r_hd_es));

%% LOW DEGREE FILTER %%

%%Filter%%
H_ld = 0.5*(1+exp(-1i*2*pi*ff));

%%Filtered signal%%
Y_ld = X.*H_ld;
y_ld = ifft(Y_ld);

%%Theoretical Results%%
R_ld_th = abs(5.*(1+cos(2*pi*ff)));

r_ld_th = zeros(1,N);
r_ld_th(1, N/2) = 5;
r_ld_th(1,N/2-1) = 2.5;
r_ld_th(1,N/2+1) = 2.5;

%%Estimated Results%%
r_ld_es = acf(y_ld);
R_ld_es = abs(fft(r_ld_es));

%% PLOT ZONE %%

%% High Degree Filter %%

%Filter absolute value
figure;
plot(ff, abs(H_hd), 'b'); axis tight;
title('Filter (absolute value)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/H_hd_th','-dpng');

%Theoretical ACF
figure;
plot(nn, r_hd_th, 'b'); axis tight;
title('Theoretical ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_hd_th_plot','-dpng');
figure;
stem(nn, r_hd_th, 'b'); xlim([-20,20]);
title('Theoretical ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_hd_th_stem','-dpng');

figure;
subplot(2,1,1);
plot(nn, r_hd_th, 'b'); axis tight;
title('Theoretical ACF Plotted');
subplot(2,1,2);
stem(nn, r_hd_th, 'b'); xlim([-20,20]);
title('Theoretical ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_hd_th','-dpng');

%Theoretical PSD
figure;
plot(ff, R_hd_th, 'b'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/R_hd_th','-dpng');

%Estimated ACF
figure;
plot(nn, r_hd_es, 'b');
title('Estimated ACF Plotted'); axis tight;
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_hd_es_plot','-dpng');
figure;
stem(nn, r_hd_es, 'b'); xlim([-20,20]);
title('Estimated ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_hd_es_stem','-dpng');

figure;
subplot(2,1,1);
plot(nn, r_hd_es, 'b'); axis tight;
title('Estimated ACF Plotted');
subplot(2,1,2);
stem(nn, r_hd_es, 'b'); xlim([-20,20]);
title('Estimated ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_hd_es','-dpng');

%Estimated PSD
figure;
plot(ff, R_hd_es, 'b'); xlim([0,1]);
title('Estimated PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/R_hd_es','-dpng');

%Comparations
figure;
subplot(2,1,1);
plot(nn, r_hd_th, 'b'); axis tight;
title('Theoretical ACF Plotted');
subplot(2,1,2);
plot(nn, r_hd_es, 'b'); axis tight;
title('Estimated ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/comp_r_hd_plot','-dpng');

figure;
subplot(2,1,1);
stem(nn, r_hd_th, 'b'); xlim([-20,20]);
title('Theoretical ACF Stemed');
subplot(2,1,2);
stem(nn, r_hd_es, 'b'); xlim([-20,20]);
title('Estimated ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/comp_r_hd_stem','-dpng');

figure;
subplot(2,1,1);
plot(ff, R_hd_th, 'b'); xlim([0,1]);
title('Theoretical PSD');
subplot(2,1,2);
plot(ff, R_hd_es, 'b'); xlim([0,1]);
title('Estimated PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/comp_R_hd','-dpng');

%% Low Degree Filter %%

%Filter absolute value
figure;
plot(ff, abs(H_ld), 'b'); axis tight;
title('Filter (absolute value)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/H_ld_th','-dpng');

%Theoretical ACF
figure;
plot(nn, r_ld_th, 'b'); axis tight;
title('Theoretical ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_ld_th_plot','-dpng');
figure;
stem(nn, r_ld_th, 'b'); xlim([-20,20]);
title('Theoretical ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_ld_th_stem','-dpng');

figure;
subplot(2,1,1);
plot(nn, r_ld_th, 'b'); axis tight;
title('Theoretical ACF Plotted');
subplot(2,1,2);
stem(nn, r_ld_th, 'b'); xlim([-20,20]);
title('Theoretical ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_ld_th','-dpng');

%Theoretical PSD
figure;
plot(ff, R_ld_th, 'b'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/R_ld_th','-dpng');

%Estimated ACF
figure;
plot(nn, r_ld_es, 'b'); axis tight;
title('Estimated ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_ld_es_plot','-dpng');
figure;
stem(nn, r_ld_es, 'b'); xlim([-20,20]);
title('Estimated ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_ld_es_stem','-dpng');

figure;
subplot(2,1,1);
plot(nn, r_ld_es, 'b'); axis tight;
title('Estimated ACF Plotted');
subplot(2,1,2);
stem(nn, r_ld_es, 'b'); xlim([-20,20]);
title('Estimated ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_ld_es','-dpng');

%Estimated PSD
figure;
plot(ff, R_ld_es, 'b'); xlim([0,1]);
title('Estimated PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/R_ld_es','-dpng');

%Comparations
figure;
subplot(2,1,1);
plot(nn, r_ld_th, 'b'); axis tight;
title('Theoretical ACF Plotted');
subplot(2,1,2);
plot(nn, r_ld_es, 'b'); axis tight;
title('Estimated ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/comp_r_ld_plot','-dpng');

figure;
subplot(2,1,1);
stem(nn, r_ld_th, 'b'); xlim([-20,20]);
title('Theoretical ACF Stemed');
subplot(2,1,2);
stem(nn, r_ld_es, 'b'); xlim([-20,20]);
title('Estimated ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/comp_r_ld_stem','-dpng');

figure;
subplot(2,1,1);
plot(ff, R_ld_th, 'b'); xlim([0,1]);
title('Theoretical PSD');
subplot(2,1,2);
plot(ff, R_ld_es, 'b'); xlim([0,1]);
title('Estimated PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/comp_R_ld','-dpng');
