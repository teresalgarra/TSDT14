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

%Windows
t_w = -32:Ts:32;
w_re = window(@rectwin,65);
w_tr = window(@triang,65);
w_ha = window(@hamming,65);
w_ba = window(@bartlett,65);
w_bl = window(@blackmanharris,65);

%%%LOW DEGREE FILTER%%%

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

%%Improved functions%%

%Averaged PSDs
[R_ld_av_l, f_ld_av_l] = averaging_low(y_ld);
[R_ld_av_m, f_ld_av_m] = averaging_medium(y_ld);
[R_ld_av_h, f_ld_av_h] = averaging_high(y_ld);

%Rectangular window
r_ld_re = window_re(r_ld_es, 'acf');
R_ld_re = window_re(R_ld_es, 'psd');

%Triangular window
r_ld_tr = window_tr(r_ld_es, 'acf');
R_ld_tr = window_tr(R_ld_es, 'psd');

%Hamming window
r_ld_ha = window_ha(r_ld_es, 'acf');
R_ld_ha = window_ha(R_ld_es, 'psd');

%Bartlett window
r_ld_ba = window_ba(r_ld_es, 'acf');
R_ld_ba = window_ba(R_ld_es, 'psd');

%Blackmanharris window
r_ld_bl = window_bl(r_ld_es, 'acf');
R_ld_bl = window_bl(R_ld_es, 'psd');

%%%PLOT ZONE%%%

%%Windows%%
figure;
subplot(5,1,1);
plot(t_w, w_re, 'b'); axis tight;
title('Rectangular Window');
subplot(5,1,2);
plot(t_w, w_tr, 'c'); axis tight;
title('Triangular Window');
subplot(5,1,3);
plot(t_w, w_ha, 'g'); axis tight;
title('Hamming Window');
subplot(5,1,4);
plot(t_w, w_ba, 'y'); axis tight;
title('Bartlett Window');
subplot(5,1,5);
plot(t_w, w_bl, 'm'); axis tight;
title('Blackman-Harris Window');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/windows','-dpng');

%% LOW DEGREE FILTER %%

%Improved ACF Plotted
figure;
subplot(6,1,1);
plot(nn, r_ld_re, 'b'); axis tight;
title('Improved ACF (Rectangular Window)');
subplot(6,1,2);
plot(nn, r_ld_tr, 'c'); axis tight;
title('Improved ACF (Triangular Window)');
subplot(6,1,3);
plot(nn, r_ld_ha, 'g'); axis tight;
title('Improved ACF (Hamming Window)');
subplot(6,1,4);
plot(nn, r_ld_ba, 'y'); axis tight;
title('Improved ACF (Bartlett Window)');
subplot(6,1,5);
plot(nn, r_ld_bl, 'm'); axis tight;
title('Improved ACF (Blackman-Harris Window)');
subplot(6,1,6);
plot(nn, r_ld_th, 'r'); axis tight;
title('Theoretical ACF');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/acf_ld_plot','-dpng');

%Improved ACF Stemed
figure;
subplot(6,1,1);
stem(nn, r_ld_re, 'b');xlim([-20,20]);
title('Improved ACF (Rectangular Window)');
subplot(6,1,2);
stem(nn, r_ld_tr, 'c');xlim([-20,20]);
title('Improved ACF (Triangular Window)');
subplot(6,1,3);
stem(nn, r_ld_ha, 'g');xlim([-20,20]);
title('Improved ACF (Hamming Window)');
subplot(6,1,4);
stem(nn, r_ld_ba, 'y');xlim([-20,20]);
title('Improved ACF (Bartlett Window)');
subplot(6,1,5);
stem(nn, r_ld_bl, 'm');xlim([-20,20]);
title('Improved ACF (Blackman-Harris Window)');
subplot(6,1,6);
stem(nn, r_ld_th, 'r'); xlim([-20,20]);
title('Theoretical ACF');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/acf_ld_stem','-dpng');

%Improved PSD
figure;
subplot(6,1,1);
plot(ff, R_ld_re, 'b'); xlim([0,1]);
title('Improved PSD (Rectangular Window)');
subplot(6,1,2);
plot(ff, R_ld_tr, 'c'); xlim([0,1]);
title('Improved PSD (Triangular Window)');
subplot(6,1,3);
plot(ff, R_ld_ha, 'g'); xlim([0,1]);
title('Improved PSD (Hamming Window)');
subplot(6,1,4);
plot(ff, R_ld_ba, 'y'); xlim([0,1]);
title('Improved PSD (Bartlett Window)');
subplot(6,1,5);
plot(ff, R_ld_bl, 'm'); xlim([0,1]);
title('Improved PSD (Blackman-Harris Window)');
subplot(6,1,6);
plot(ff, R_ld_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/psd_ld_window','-dpng');

%Averaging
figure;
subplot(4,1,1);
plot(f_ld_av_l, R_ld_av_l, 'b'); xlim([0,1]);
title('Averaged PSD (low value)');
subplot(4,1,2);
plot(f_ld_av_m, R_ld_av_m, 'c'); xlim([0,1]);
title('Averaged PSD (medium value)');
subplot(4,1,3);
plot(f_ld_av_h, R_ld_av_h, 'g'); xlim([0,1]);
title('Averaged PSD (high value)');
subplot(4,1,4);
plot(ff, R_ld_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/psd_ld_aver','-dpng');
