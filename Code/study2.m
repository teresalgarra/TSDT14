clear;
clc;
close all;

Ts = 1;
N = 16;
dt = Ts/2^N;
fs = 1/dt;
x=randn(1,2^N);
X = (1/N)*fft(x);
Rx = 1;

fc_ld = 0.9;
fc_hd  = 1; %Si no funciona algo, igual aquí es 10

f = linspace(0,Ts,2^N);
t = linspace(0,Ts,2^N);

%Windows
t_w = linspace(0,Ts,65);
w_re = window(@rectwin,65);
w_tr = window(@triang,65);
w_ha = window(@hamming,65);
w_ba = window(@bartlett,65);
w_bl = window(@blackmanharris,65);

%%%HIGH DEGREE FILTER%%%

%%Estimated functions%%

%10th degree filter
wc_hd = 2*pi*fc_hd;
[b,a] = butter(10,2*wc_hd,'s');
H_hd = (polyval(b,f)./polyval(a,f));
h_hd = ifft(H_hd, 'symmetric');

%Final signal
Y_hd = X.*H_hd;
y_hd = ifft(Y_hd,'symmetric');

%%Results%%
r_hd = acf(y_hd);
R_hd = fft(r_hd);

%%Improved functions%%

%%Results%%

%Rectangular window
r_hd_re = window_re(r_hd);
R_hd_re = window_re(R_hd);

%Triangular window
r_hd_tr = window_tr(r_hd);
R_hd_tr = window_tr(R_hd);

%Hamming window
r_hd_ha = window_ha(r_hd);
R_hd_ha = window_ha(R_hd);

%Bartlett window
r_hd_ba = window_ba(r_hd);
R_hd_ba = window_ba(R_hd);

%Blackmanharris window
r_hd_bl = window_bl(r_hd);
R_hd_bl = window_bl(R_hd);

%%%LOW DEGREE FILTER%%%

%%Estimated functions%%

%First order lowpassfilter
wc_ld = 2*pi*fc_ld;
[d,c] = butter(1,2*wc_ld,'s');
H_ld = (polyval(d,f)./polyval(c,f));
h_ld = ifft(H_ld, 'symmetric');

%Final signal
Y_ld = X.*H_ld;
y_ld = ifft(Y_ld,'symmetric');

%Results%
r_ld = acf(y_ld);
R_ld = fft(r_ld);

%%Improved functions%%

%%Results%%

%Rectangular window
r_ld_re = window_re(r_ld);
R_ld_re = window_re(R_ld);

%Triangular window
r_ld_tr = window_tr(r_ld);
R_ld_tr = window_tr(R_ld);

%Hamming window
r_ld_ha = window_ha(r_ld);
R_ld_ha = window_ha(R_ld);

%Bartlett window
r_ld_ba = window_ba(r_ld);
R_ld_ba = window_ba(R_ld);

%Blackmanharris window
r_ld_bl = window_bl(r_ld);
R_ld_bl = window_bl(R_ld);

%%%PLOT ZONE%%%

%%Windows%%

%Rectangular window
figure;     %1
plot(t_w,w_re, 'm');
%Triangular window
figure;     %2
plot(t_w,w_tr, 'b');
%Hamming window
figure;     %3
plot(t_w,w_ha, 'c');
%Bartlett window
figure;     %4
plot(t_w,w_ba, 'g');
%Blackman window
figure;     %5
plot(t_w,w_bl, 'y');

%%High degree filter%%

%Estimations

%Estimated ACF
figure;     %6
plot(t,r_hd, 'm');
figure;     %7
stem(t,r_hd, 'b'); xlim([-20,20]);
%Estimated PSD
figure;     %8
plot(f,R_hd, 'c'); xlim([0,1]);

%Improved functions

%Rectangular window
%Improved ACF
figure;     %9
plot(t, r_hd_re, 'm');
figure;     %10
stem(t,r_hd_re, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %11
plot(f, R_hd_re, 'c'); xlim([0,1]);

%Triangular window
%Improved ACF
figure;     %12
plot(t, r_hd_tr, 'm');
figure;     %13
stem(t,r_hd_tr, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %14
plot(f, R_hd_tr, 'c'); xlim([0,1]);

%Hamming window
%Improved ACF
figure;     %15
plot(t, r_hd_ha, 'm');
figure;     %16
stem(t,r_hd_ha, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %17
plot(f, R_hd_ha, 'c'); xlim([0,1]);

%Bartlett window
%Improved ACF
figure;     %18
plot(t, r_hd_ba, 'm');
figure;     %19
stem(t,r_hd_ba, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %20
plot(f, R_hd_ba, 'c'); xlim([0,1]);

%Blackmanharris window
%Improved ACF
figure;     %21
plot(t, r_hd_bl, 'm');
figure;     %22
stem(t,r_hd_bl, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %23
plot(f, R_hd_bl, 'c'); xlim([0,1]);


%%Low degree filter%%

%Estimations

%Estimated ACF
figure;     %24
plot(t,r_ld, 'm');
figure;     %25
stem(t,r_ld, 'b'); xlim([-20,20]);
%Estimated PSD
figure;     %26
plot(f,R_ld, 'c'); xlim([0,1]);

%Improved functions

%Rectangular window
%Improved ACF
figure;     %27
plot(t, r_ld_re, 'm');
figure;     %28
stem(t,r_ld_re, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %29
plot(f, R_ld_re, 'c'); xlim([0,1]);

%Triangular window
%Improved ACF
figure;     %30
plot(t, r_ld_tr, 'm');
figure;     %31
stem(t,r_ld_tr, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %32
plot(f, R_ld_tr, 'c'); xlim([0,1]);

%Hamming window
%Improved ACF
figure;     %33
plot(t, r_ld_ha, 'm');
figure;     %34
stem(t,r_ld_ha, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %35
plot(f, R_ld_ha, 'c'); xlim([0,1]);

%Bartlett window
%Improved ACF
figure;     %36
plot(t, r_ld_ba, 'm');
figure;     %37
stem(t,r_ld_ba, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %38
plot(f, R_ld_ba, 'c'); xlim([0,1]);

%Blackmanharris window
%Improved ACF
figure;     %39
plot(t, r_ld_bl, 'm');
figure;     %40
stem(t,r_ld_bl, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %41
plot(f, R_ld_bl, 'c'); xlim([0,1]);

%% 


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

%% 




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
title('Improved ACF Plotted');
subplot(2,1,2);
plot(nn, r_hd_es, 'r'); axis tight;
title('Theoretical ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_re_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_hd_re, 'b'); xlim([-20,20]);
title('Improved ACF Stemed');
subplot(2,1,2);
stem(nn, r_hd_es, 'r'); xlim([-20,20]);
title('Theoretical ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_re_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_hd_re, 'b'); xlim([0,1]);
title('Improved PSD');
subplot(2,1,2);
plot(ff, R_hd_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_hd_re','-dpng');

%Triangular window
%Improved ACF
figure;
subplot(2,1,1);
plot(nn, r_hd_tr, 'b'); axis tight;
title('Improved ACF Plotted');
subplot(2,1,2);
plot(nn, r_hd_es, 'r'); axis tight;
title('Theoretical ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_tr_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_hd_tr, 'b'); xlim([-20,20]);
title('Improved ACF Stemed');
subplot(2,1,2);
stem(nn, r_hd_es, 'r'); xlim([-20,20]);
title('Theoretical ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_tr_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_hd_tr, 'b'); xlim([0,1]);
title('Improved PSD');
subplot(2,1,2);
plot(ff, R_hd_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_hd_tr','-dpng');

%Hamming window
%Improved ACF
figure;
subplot(2,1,1);
plot(nn, r_hd_ha, 'b'); axis tight;
title('Improved ACF Plotted');
subplot(2,1,2);
plot(nn, r_hd_es, 'r'); axis tight;
title('Theoretical ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_ha_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_hd_ha, 'b'); xlim([-20,20]);
title('Improved ACF Stemed');
subplot(2,1,2);
stem(nn, r_hd_es, 'r'); xlim([-20,20]);
title('Theoretical ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_ha_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_hd_ha, 'b'); xlim([0,1]);
title('Improved PSD');
subplot(2,1,2);
plot(ff, R_hd_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_hd_ha','-dpng');

%Bartlett window
%Improved ACF
figure;
subplot(2,1,1);
plot(nn, r_hd_ba, 'b'); axis tight;
title('Improved ACF Plotted');
subplot(2,1,2);
plot(nn, r_hd_es, 'r'); axis tight;
title('Theoretical ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_ba_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_hd_ba, 'b');xlim([-20,20]);
title('Improved ACF Stemed');
subplot(2,1,2);
stem(nn, r_hd_es, 'r'); xlim([-20,20]);
title('Theoretical ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_ba_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_hd_ba, 'b'); xlim([0,1]);
title('Improved PSD');
subplot(2,1,2);
plot(ff, R_hd_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_hd_ba','-dpng');

%Blackmanharris window
%Improved ACF
figure;
subplot(2,1,1);
plot(nn, r_hd_bl, 'b'); axis tight;
title('Improved ACF Plotted');
subplot(2,1,2);
plot(nn, r_hd_es, 'r'); axis tight;
title('Theoretical ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_bl_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_hd_bl, 'b');xlim([-20,20]);
title('Improved ACF Stemed');
subplot(2,1,2);
stem(nn, r_hd_es, 'r'); xlim([-20,20]);
title('Theoretical ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_hd_bl_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_hd_bl, 'b'); xlim([0,1]);
title('Improved PSD');
subplot(2,1,2);
plot(ff, R_hd_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_hd_bl','-dpng');


%%Low degree filter%%

%Improved functions

%Rectangular window
%Improved ACF
figure;
subplot(2,1,1);
plot(nn, r_ld_re, 'b'); axis tight;
title('Improved ACF Plotted');
subplot(2,1,2);
plot(nn, r_ld_es, 'r'); axis tight;
title('Theoretical ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_re_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_ld_re, 'b');xlim([-20,20]);
title('Improved ACF Stemed');
subplot(2,1,2);
stem(nn, r_ld_es, 'r'); xlim([-20,20]);
title('Theoretical ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_re_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_ld_re, 'b'); xlim([0,1]);
title('Improved PSD');
subplot(2,1,2);
plot(ff, R_ld_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_ld_re','-dpng');

%Triangular window
%Improved ACF
figure;
subplot(2,1,1);
plot(nn, r_ld_tr, 'b'); axis tight;
title('Improved ACF Plotted');
subplot(2,1,2);
plot(nn, r_ld_es, 'r'); axis tight;
title('Theoretical ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_tr_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_ld_tr, 'b');xlim([-20,20]);
title('Improved ACF Stemed');
subplot(2,1,2);
stem(nn, r_ld_es, 'r'); xlim([-20,20]);
title('Theoretical ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_tr_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_ld_tr, 'b'); xlim([0,1]);
title('Improved PSD');
subplot(2,1,2);
plot(ff, R_ld_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_ld_tr','-dpng');

%Hamming window
%Improved ACF
figure;
subplot(2,1,1);
plot(nn, r_ld_ha, 'b'); axis tight;
title('Improved ACF Plotted');
subplot(2,1,2);
plot(nn, r_ld_es, 'r'); axis tight;
title('Theoretical ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_ha_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_ld_ha, 'b');xlim([-20,20]);
title('Improved ACF Stemed');
subplot(2,1,2);
stem(nn, r_ld_es, 'r'); xlim([-20,20]);
title('Theoretical ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_ha_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_ld_ha, 'b'); xlim([0,1]);
title('Improved PSD');
subplot(2,1,2);
plot(ff, R_ld_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_ld_ha','-dpng');

%Bartlett window
%Improved ACF
figure;
subplot(2,1,1);
plot(nn, r_ld_ba, 'b'); axis tight;
title('Improved ACF Plotted');
subplot(2,1,2);
plot(nn, r_ld_es, 'r'); axis tight;
title('Theoretical ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_ba_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_ld_ba, 'b');xlim([-20,20]);
title('Improved ACF Stemed');
subplot(2,1,2);
stem(nn, r_ld_es, 'r'); xlim([-20,20]);
title('Theoretical ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_ba_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_ld_ba, 'b'); xlim([0,1]);
title('Improved PSD');
subplot(2,1,2);
plot(ff, R_ld_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_ld_ba','-dpng');

%Blackmanharris window
%Improved ACF
figure;
subplot(2,1,1);
plot(nn, r_ld_bl, 'b'); axis tight;
title('Improved ACF Plotted');
subplot(2,1,2);
plot(nn, r_ld_es, 'r'); axis tight;
title('Theoretical ACF Plotted');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_bl_plot','-dpng');
figure;
subplot(2,1,1);
stem(nn, r_ld_bl, 'b');xlim([-20,20]);
title('Improved ACF Stemed');
subplot(2,1,2);
stem(nn, r_ld_es, 'r'); xlim([-20,20]);
title('Theoretical ACF Stemed');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/r_ld_bl_stem','-dpng');
%Improved PSD
figure;
subplot(2,1,1);
plot(ff, R_ld_bl, 'b'); xlim([0,1]);
title('Improved PSD');
subplot(2,1,2);
plot(ff, R_ld_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/R_ld_bl','-dpng');
