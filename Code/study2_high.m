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

%%%HIGH DEGREE FILTER%%%

%%Ideal filter (rectangle)%%
H_hd = linspace(0,1,N);
H_hd(1:0.1*N) = 1;
H_hd(0.1*N+1:0.9*N) = 0;
H_hd(0.9*N+1:N) = 1;

%%Filtered signal%%
Y_hd = X.*H_hd;
y_hd = ifft(Y_hd);

%%Theoretical Results%%
R_hd_th = 5*abs(H_hd).^2;
r_hd_th = 10*2*2*0.1*sinc(2*0.1*nn);

%%Estimated Results%%
r_hd_es = 2*acf(y_hd);
R_hd_es = 0.5*abs(fft(r_hd_es));

%%Improved functions%%

%Averaged PSDs
[R_hd_av_l, f_hd_av_l] = averaging_low(y_hd);
[R_hd_av_m, f_hd_av_m] = averaging_medium(y_hd);
[R_hd_av_h, f_hd_av_h] = averaging_high(y_hd);

%Rectangular window
r_hd_re = window_re(r_hd_es, 'acf');
R_hd_re = window_re(R_hd_es, 'psd');

%Triangular window
r_hd_tr = window_tr(r_hd_es, 'acf');
R_hd_tr = window_tr(R_hd_es, 'psd');

%Hamming window
r_hd_ha = window_ha(r_hd_es, 'acf');
R_hd_ha = window_ha(R_hd_es, 'psd');

%Bartlett window
r_hd_ba = window_ba(r_hd_es, 'acf');
R_hd_ba = window_ba(R_hd_es, 'psd');

%Blackmanharris window
r_hd_bl = window_bl(r_hd_es, 'acf');
R_hd_bl = window_bl(R_hd_es, 'psd');

%%%PLOT ZONE%%%

%Improved ACF Plotted
figure;
subplot(6,1,1);
plot(nn, r_hd_re, 'b'); axis tight;
title('Improved ACF (Rectangular Window)');
subplot(6,1,2);
plot(nn, r_hd_tr, 'c'); axis tight;
title('Improved ACF (Triangular Window)');
subplot(6,1,3);
plot(nn, r_hd_ha, 'g'); axis tight;
title('Improved ACF (Hamming Window)');
subplot(6,1,4);
plot(nn, r_hd_ba, 'y'); axis tight;
title('Improved ACF (Bartlett Window)');
subplot(6,1,5);
plot(nn, r_hd_bl, 'm'); axis tight;
title('Improved ACF (Blackman-Harris Window)');
subplot(6,1,6);
plot(nn, r_hd_th, 'r'); axis tight;
title('Theoretical ACF');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/acf_hd_plot','-dpng');

%Improved ACF Stemed
figure;
subplot(6,1,1);
stem(nn, r_hd_re, 'b');xlim([-20,20]);
title('Improved ACF (Rectangular Window)');
subplot(6,1,2);
stem(nn, r_hd_tr, 'c');xlim([-20,20]);
title('Improved ACF (Triangular Window)');
subplot(6,1,3);
stem(nn, r_hd_ha, 'g');xlim([-20,20]);
title('Improved ACF (Hamming Window)');
subplot(6,1,4);
stem(nn, r_hd_ba, 'y');xlim([-20,20]);
title('Improved ACF (Bartlett Window)');
subplot(6,1,5);
stem(nn, r_hd_bl, 'm');xlim([-20,20]);
title('Improved ACF (Blackman-Harris Window)');
subplot(6,1,6);
stem(nn, r_hd_th, 'r'); xlim([-20,20]);
title('Theoretical ACF');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/acf_hd_stem','-dpng');

%Improved PSD
figure;
subplot(6,1,1);
plot(ff, R_hd_re, 'b'); xlim([0,1]);
title('Improved PSD (Rectangular Window)');
subplot(6,1,2);
plot(ff, R_hd_tr, 'c'); xlim([0,1]);
title('Improved PSD (Triangular Window)');
subplot(6,1,3);
plot(ff, R_hd_ha, 'g'); xlim([0,1]);
title('Improved PSD (Hamming Window)');
subplot(6,1,4);
plot(ff, R_hd_ba, 'y'); xlim([0,1]);
title('Improved PSD (Bartlett Window)');
subplot(6,1,5);
plot(ff, R_hd_bl, 'm'); xlim([0,1]);
title('Improved PSD (Blackman-Harris Window)');
subplot(6,1,6);
plot(ff, R_hd_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/psd_hd_window','-dpng');

%Averaging
figure;
subplot(4,1,1);
plot(f_hd_av_l, R_hd_av_l, 'b'); xlim([0,1]);
title('Averaged PSD (low value)');
subplot(4,1,2);
plot(f_hd_av_m, R_hd_av_m, 'c'); xlim([0,1]);
title('Averaged PSD (medium value)');
subplot(4,1,3);
plot(f_hd_av_h, R_hd_av_h, 'g'); xlim([0,1]);
title('Averaged PSD (high value)');
subplot(4,1,4);
plot(ff, R_hd_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/psd_hd_aver','-dpng');
