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
figure;
plot(tt, x, 'm'); axis tight;
title('Input noise in Time Domain');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/x','-dpng');

%%High degree filter%%

%Filter absolute value
figure;
plot(ff, abs(H_hd_th), 'b'); axis tight;
title('Filter (absolute value)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/abs(H_hd_th)','-dpng');
%Theoretical ACF
figure;
plot(nn, r_hd_th, 'm');
title('Theoretical ACF Plotted'); axis tight;
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_hd_th_plot','-dpng');
figure;
stem(nn, r_hd_th, 'b'); xlim([-20,20]);
title('Theoretical ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_hd_th_stem','-dpng');
%Theoretical PSD
figure;
plot(ff, R_hd_th, 'c'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/R_hd_th','-dpng');

%Estimated ACF
figure;
plot(nn, r_hd_es, 'm');
title('Estimated ACF Plotted'); axis tight;
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_hd_es_plot','-dpng');
figure;
stem(nn, r_hd_es, 'b'); xlim([-20,20]);
title('Estimated ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_hd_es_stem','-dpng');
%Estimated PSD
figure;
plot(ff, R_hd_es, 'c'); xlim([0,1]);
title('Estimated PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/R_hd_es','-dpng');

%%Low degree filter%%

%Filter absolute value
figure;
plot(ff, abs(H_ld_th), 'b'); axis tight;
title('Filter (absolute value)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/abs(H_ld_th)','-dpng');
%Theoretical ACF
figure;
plot(nn, r_ld_th, 'm');
title('Theoretical ACF Plotted'); axis tight;
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_ld_th_plot','-dpng');
figure;
stem(nn, r_ld_th, 'b'); xlim([-20,20]);
title('Theoretical ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_ld_th_stem','-dpng');
%Theoretical PSD
figure;
plot(ff, abs(H_ld_th), 'c');
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/R_ld_th','-dpng');

%Estimated ACF
figure;
plot(nn, r_ld_es, 'm');
title('Estimated ACF Plotted'); axis tight;
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_ld_es_plot','-dpng');
figure;
stem(nn, r_ld_es, 'b'); xlim([-20,20]);
title('Estimated ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_ld_es_stem','-dpng');
%Estimated PSD
figure;
plot(ff, R_ld_es, 'c'); xlim([0,1]);
title('Estimated PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/R_ld_es','-dpng');

%%%STUDY 2%%%

%Windows
t_w = -32:Ts:32;
w_re = window(@rectwin,65);
w_tr = window(@triang,65);
w_ha = window(@hamming,65);
w_ba = window(@bartlett,65);
w_bl = window(@blackmanharris,65);

%%%HIGH DEGREE FILTER%%%

%%Improved Functions%%

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

%%%LOW-DEGREE FILTER%%%

%%Improved functions%%

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

%Rectangular window
figure;
plot(t_w, w_re, 'm'); axis tight;
title('Rectangular Window');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/w_re','-dpng');
%Triangular window
figure;
plot(t_w, w_tr, 'b'); axis tight;
title('Triangular Window');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/w_tr','-dpng');
%Hamming window
figure;
plot(t_w, w_ha, 'c'); axis tight;
title('Hamming Window');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/w_ha','-dpng');
%Bartlett window
figure;
plot(t_w, w_ba, 'g'); axis tight;
title('Bartlett Window');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/w_ba','-dpng');
%Blackman window
figure;
plot(t_w, w_bl, 'y'); axis tight;
title('Blackman-Harris Window');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/w_bl','-dpng');

%%High degree filter%%

%Improved functions

%Rectangular window
%Improved ACF
figure;
subplot(2,1,1);
plot(nn, r_hd_re, 'b'); axis tight;
subplot(2,1,2);
plot(nn, r_hd_es, 'r'); axis tight;
title('Improved ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_re_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_hd_re, 'b'); xlim([-20,20]);
subplot(2,1,2);
stem(nn, r_hd_es, 'r'); xlim([-20,20]);
title('Improved ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_re_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_hd_re, 'b'); xlim([0,1]);
subplot(2,1,2);
plot(ff, R_hd_th, 'r'); xlim([0,1]);
title('Improved PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_hd_re','-dpng');

%Triangular window
%Improved ACF
figure;
subplot(2,1,1);
plot(nn, r_hd_tr, 'b'); axis tight;
subplot(2,1,2);
plot(nn, r_hd_es, 'r'); axis tight;
title('Improved ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_tr_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_hd_tr, 'b'); xlim([-20,20]);
subplot(2,1,2);
stem(nn, r_hd_es, 'r'); xlim([-20,20]);
title('Improved ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_tr_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_hd_tr, 'b'); xlim([0,1]);
subplot(2,1,2);
plot(ff, R_hd_th, 'r'); xlim([0,1]);
title('Improved PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_hd_tr','-dpng');

%Hamming window
%Improved ACF
figure;
subplot(2,1,1);
plot(nn, r_hd_ha, 'b'); axis tight;
subplot(2,1,2);
plot(nn, r_hd_es, 'r'); axis tight;
title('Improved ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_ha_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_hd_ha, 'b'); xlim([-20,20]);
subplot(2,1,2);
stem(nn, r_hd_es, 'r'); xlim([-20,20]);
title('Improved ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_ha_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_hd_ha, 'b'); xlim([0,1]);
subplot(2,1,2);
plot(ff, R_hd_th, 'r'); xlim([0,1]);
title('Improved PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_hd_ha','-dpng');

%Bartlett window
%Improved ACF
figure;
subplot(2,1,1);
plot(nn, r_hd_ba, 'b'); axis tight;
subplot(2,1,2);
plot(nn, r_hd_es, 'r'); axis tight;
title('Improved ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_ba_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_hd_ba, 'b');xlim([-20,20]);
subplot(2,1,2);
stem(nn, r_hd_es, 'r'); xlim([-20,20]);
title('Improved ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_ba_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_hd_ba, 'b'); xlim([0,1]);
subplot(2,1,2);
plot(ff, R_hd_th, 'r'); xlim([0,1]);
title('Improved PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_hd_ba','-dpng');

%Blackmanharris window
%Improved ACF
figure;
subplot(2,1,1);
plot(nn, r_hd_bl, 'bb'); axis tight;
subplot(2,1,2);
plot(nn, r_hd_es, 'r'); axis tight;
title('Improved ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_bl_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_hd_bl, 'b');xlim([-20,20]);
subplot(2,1,2);
stem(nn, r_hd_es, 'r'); xlim([-20,20]);
title('Improved ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_bl_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_hd_bl, 'b'); xlim([0,1]);
subplot(2,1,2);
plot(ff, R_hd_th, 'r'); xlim([0,1]);
title('Improved PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_hd_bl','-dpng');


%%Low degree filter%%

%Improved functions

%Rectangular window
%Improved ACF
figure;
subplot(2,1,1);
plot(nn, r_ld_re, 'b'); axis tight;
subplot(2,1,2);
plot(nn, r_hd_es, 'r'); axis tight;
title('Improved ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_re_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_ld_re, 'b');xlim([-20,20]);
subplot(2,1,2);
stem(nn, r_hd_es, 'r'); xlim([-20,20]);
title('Improved ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_re_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_ld_re, 'b'); xlim([0,1]);
subplot(2,1,2);
plot(ff, R_ld_th, 'r'); xlim([0,1]);
title('Improved PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_ld_re','-dpng');

%Triangular window
%Improved ACF
figure;
subplot(2,1,1);
plot(nn, r_ld_tr, 'b'); axis tight;
subplot(2,1,2);
plot(nn, r_hd_es, 'r'); axis tight;
title('Improved ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_tr_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_ld_tr, 'b');xlim([-20,20]);
subplot(2,1,2);
stem(nn, r_hd_es, 'r'); xlim([-20,20]);
title('Improved ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_tr_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_ld_tr, 'b'); xlim([0,1]);
subplot(2,1,2);
plot(ff, R_ld_th, 'r'); xlim([0,1]);
title('Improved PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_ld_tr','-dpng');

%Hamming window
%Improved ACF
figure;
subplot(2,1,1);
plot(nn, r_ld_ha, 'b'); axis tight;
subplot(2,1,2);
plot(nn, r_hd_es, 'r'); axis tight;
title('Improved ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_ha_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_ld_ha, 'b');xlim([-20,20]);
subplot(2,1,2);
stem(nn, r_hd_es, 'r'); xlim([-20,20]);
title('Improved ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_ha_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_ld_ha, 'b'); xlim([0,1]);
subplot(2,1,2);
plot(ff, R_ld_th, 'r'); xlim([0,1]);
title('Improved PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_ld_ha','-dpng');

%Bartlett window
%Improved ACF
figure;
subplot(2,1,1);
plot(nn, r_ld_ba, 'b'); axis tight;
subplot(2,1,2);
plot(nn, r_hd_es, 'r'); axis tight;
title('Improved ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_ba_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_ld_ba, 'b');xlim([-20,20]);
subplot(2,1,2);
stem(nn, r_hd_es, 'r'); xlim([-20,20]);
title('Improved ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_ba_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_ld_ba, 'b'); xlim([0,1]);
subplot(2,1,2);
plot(ff, R_ld_th, 'r'); xlim([0,1]);
title('Improved PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_ld_ba','-dpng');

%Blackmanharris window
%Improved ACF
figure;
subplot(2,1,1);
plot(nn, r_ld_bl, 'b'); axis tight;
subplot(2,1,2);
plot(nn, r_hd_es, 'r'); axis tight;
title('Improved ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_bl_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_ld_bl, 'b');xlim([-20,20]);
subplot(2,1,2);
stem(nn, r_hd_es, 'r'); xlim([-20,20]);
title('Improved ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_bl_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_ld_bl, 'b'); xlim([0,1]);
subplot(2,1,2);
plot(ff, R_ld_th, 'r'); xlim([0,1]);
title('Improved PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_ld_bl','-dpng');
