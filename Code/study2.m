%% STUDY 2: IMPROVING ESTIMATES %%

%The estimated spectra from Study 1 are rough. The aim is to improve those estimates using averaging and smoothing.
%I have divided the study in two scripts so it doesn't take too long to plot each one of the filters.

%For the averaging I have three functions that work the same but with different values. The low one leaves the periodogram still a bit raw,
%the medium value it's the best one, and the highest value becomes inaccurate and the periodogram becomes distorted.

%For the smoothing I will be using five windows: rectangular, triangular, Hamming, Bartlett and Blackman-Harris.

clear;
clc;
close all;

%% HIGH-DEGREE FILTER %%

%%Data%%
N = 2^16;                             %Number of samples
x=randn(1,N)*sqrt(10);                %Random noise with power Spectral Density 10
X = fft(x, N);                        %Random noise in the frequency domain
Rx = 10;                              %Power Spectral Density of the noise

%%Vectors%%
Ts = 1;                               %Step for the vectos
nn = ((-N)/2)+1:Ts:(N)/2;             %Integer vector for plotting
ff= linspace(0,1,N);                  %Frequency vector for plotting

%%High Degree filter%%                %I will approximate an ideal filter with a rectangle
H_hd = linspace(0,1,N);
H_hd(1:0.1*N) = 1;                    %The cut-off frequency is 0.1
H_hd(0.1*N+1:0.9*N) = 0;
H_hd(0.9*N+1:N) = 1;                  %It's digital, so it's periodical, so it goes up again in 1-0.1 = 0.9

%%Filtered signal%%
Y_hd = X.*H_hd;                       %For the frequency domain, I just multiply the input and the filter
y_hd = ifft(Y_hd);                    %To switch to time domain, I use the inverse Fourier Transform

%%Theoretical Results%%
R_hd_th = Rx*abs(H_hd).^2;            %The formula is 0.5*Rx*abs(filter)^2
r_hd_th = Rx*2*0.1*sinc(2*0.1*nn);    %I used the table of Fourier Transforms to calculate this

%%Estimated Results%%
r_hd_es = acf(y_hd);                  %I use the defined function
R_hd_es = abs(fft(r_hd_es));          %I go to frequency domain to get the PSD

%%Improved functions%%

%Averaging
r_hd_av_l = averaging_low(y_hd, N);
R_hd_av_l = abs(fft(r_hd_av_l));

r_hd_av_m = averaging_medium(y_hd, N);
R_hd_av_m = abs(fft(r_hd_av_m));

r_hd_av_h = averaging_high(y_hd, N);
R_hd_av_h = abs(fft(r_hd_av_h));

%Rectangular window
r_hd_re = window_re(r_hd_es);
R_hd_re = abs(fft(r_hd_re));

%Triangular window
r_hd_tr = window_tr(r_hd_es);
R_hd_tr = abs(fft(r_hd_tr));

%Hamming window
r_hd_ha = window_ha(r_hd_es);
R_hd_ha = abs(fft(r_hd_ha));

%Bartlett window
r_hd_ba = window_ba(r_hd_es);
R_hd_ba = abs(fft(r_hd_ba));

%Blackmanharris window
r_hd_bl = window_bl(r_hd_es);
R_hd_bl = abs(fft(r_hd_bl));

%%%PLOT ZONE%%%

%Improved ACF Plotted
figure;
subplot(3,1,1);
plot(nn, r_hd_re, 'b'); axis tight;
title('Improved ACF (Rectangular Window)');
subplot(3,1,2);
plot(nn, r_hd_tr, 'c'); axis tight;
title('Improved ACF (Triangular Window)');
subplot(3,1,3);
plot(nn, r_hd_ha, 'g'); axis tight;
title('Improved ACF (Hamming Window)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/acf_hd_plot1','-dpng');

figure;
subplot(3,1,1);
plot(nn, r_hd_ba, 'y'); axis tight;
title('Improved ACF (Bartlett Window)');
subplot(3,1,2);
plot(nn, r_hd_bl, 'm'); axis tight;
title('Improved ACF (Blackman-Harris Window)');
subplot(3,1,3);
plot(nn, r_hd_th, 'r'); axis tight;
title('Theoretical ACF');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/acf_hd_plot2','-dpng');

%Improved ACF Stemed
figure;
subplot(3,1,1);
stem(nn, r_hd_re, 'b');xlim([-20,20]);
title('Improved ACF (Rectangular Window)');
subplot(3,1,2);
stem(nn, r_hd_tr, 'c');xlim([-20,20]);
title('Improved ACF (Triangular Window)');
subplot(3,1,3);
stem(nn, r_hd_ha, 'g');xlim([-20,20]);
title('Improved ACF (Hamming Window)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/acf_hd_stem1','-dpng');

figure;
subplot(3,1,1);
stem(nn, r_hd_ba, 'y');xlim([-20,20]);
title('Improved ACF (Bartlett Window)');
subplot(3,1,2);
stem(nn, r_hd_bl, 'm');xlim([-20,20]);
title('Improved ACF (Blackman-Harris Window)');
subplot(3,1,3);
stem(nn, r_hd_th, 'r'); xlim([-20,20]);
title('Theoretical ACF');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/acf_hd_stem2','-dpng');

%Improved PSD
figure;
subplot(3,1,1);
plot(ff, R_hd_re, 'b'); xlim([0,1]);
title('Improved PSD (Rectangular Window)');
subplot(3,1,2);
plot(ff, R_hd_tr, 'c'); xlim([0,1]);
title('Improved PSD (Triangular Window)');
subplot(3,1,3);
plot(ff, R_hd_ha, 'g'); xlim([0,1]);
title('Improved PSD (Hamming Window)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/psd_hd_window1','-dpng');

figure;
subplot(3,1,1);
plot(ff, R_hd_ba, 'y'); xlim([0,1]);
title('Improved PSD (Bartlett Window)');
subplot(3,1,2);
plot(ff, R_hd_bl, 'm'); xlim([0,1]);
title('Improved PSD (Blackman-Harris Window)');
subplot(3,1,3);
plot(ff, R_hd_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/psd_hd_window2','-dpng');

%Averaged PSD
figure;
subplot(4,1,1);
plot(ff, R_hd_av_l, 'b'); xlim([0,1]);
title('Averaged PSD (2^4)');
subplot(4,1,2);
plot(ff, R_hd_av_m, 'c'); xlim([0,1]);
title('Averaged PSD (2^6)');
subplot(4,1,3);
plot(ff, R_hd_av_h, 'g'); xlim([0,1]);
title('Averaged PSD (2^8)');
subplot(4,1,4);
plot(ff, R_hd_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/psd_hd_aver','-dpng');

%Averaged ACF Plotted
figure;
subplot(4,1,1);
plot(nn, r_hd_av_l, 'b'); axis tight;
title('Averaged ACF (2^4)');
subplot(4,1,2);
plot(nn, r_hd_av_m, 'c'); axis tight;
title('Averaged ACF (2^6)');
subplot(4,1,3);
plot(nn, r_hd_av_h, 'g'); axis tight;
title('Averaged ACF (2^8)');
subplot(4,1,4);
plot(nn, r_hd_th, 'r'); axis tight;
title('Theoretical ACF');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/acf_hd_aver_plot','-dpng');

%Averaged ACF Stemed
figure;
subplot(4,1,1);
stem(nn, r_hd_av_l, 'b'); xlim([-20,20]);
title('Averaged ACF (2^4)');
subplot(4,1,2);
stem(nn, r_hd_av_m, 'c'); xlim([-20,20]);
title('Averaged ACF (2^6)');
subplot(4,1,3);
stem(nn, r_hd_av_h, 'g'); xlim([-20,20]);
title('Averaged ACF (2^8)');
subplot(4,1,4);
stem(nn, r_hd_th, 'r'); xlim([-20,20]);
title('Theoretical ACF');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/acf_hd_aver_stem','-dpng');

%% LOW-DEGREE FILTER %%

%%Data%%
N = 2^16;                             %Number of samples
x=randn(1,N)*sqrt(10);                %Random noise with power Spectral Density 10
X = fft(x, N);                        %Random noise in the frequency domain
Rx = 10;                              %Power Spectral Density of the noise

%%Vectors%%
Ts = 1;                               %Step for the vectos
nn = ((-N)/2)+1:Ts:(N)/2;             %Integer vector for plotting
ff= linspace(0,1,N);                  %Frequency vector for plotting
tt = 0:Ts:(N)-1;                      %Natural vector for plotting

%Windows
t_w = -32:Ts:32;                      %Vector for plotting the windows (length=65)
w_re = window(@rectwin,65);           %Rectangular window
w_tr = window(@triang,65);            %Triangular window
w_ha = window(@hamming,65);           %Hamming window
w_ba = window(@bartlett,65);          %Bartlett window
w_bl = window(@blackmanharris,65);    %Blackman-Harris window

%%Low Degree Filter%%
H_ld = 0.5*(1+exp(-1i*2*pi*ff));      %This filter is easier than the Butterworth definition, there are no fractions

%%Filtered signal%%
Y_ld = X.*H_ld;                       %For the frequency domain, I just multiply the input and the filter
y_ld = ifft(Y_ld);                    %To switch to time domain, I use the inverse Fourier Transform

%%Theoretical Results%%
R_ld_th = abs(5.*(1+cos(2*pi*ff)));   %I used Euler's theorem to turn the exponential into trigonometric functions

r_ld_th = zeros(1,N);                 %Checking the table of Fourier Transforms, the ACF is three impulses, two for
r_ld_th(1, N/2) = 5;                  %the cosine and one fot the independent term
r_ld_th(1,N/2-1) = 2.5;
r_ld_th(1,N/2+1) = 2.5;

%%Estimated Results%%
r_ld_es = acf(y_ld);                  %I use the defined function
R_ld_es = abs(fft(r_ld_es));          %I go to frequency domain to get the PSD

%%Improved functions%%

%Averaging
r_ld_av_l = averaging_low(y_ld, N);
R_ld_av_l = abs(fft(r_ld_av_l));

r_ld_av_m = averaging_medium(y_ld, N);
R_ld_av_m = abs(fft(r_ld_av_m));

r_ld_av_h = averaging_high(y_ld, N);
R_ld_av_h = abs(fft(r_ld_av_h));

%Rectangular window
r_ld_re = window_re(r_ld_es);
R_ld_re = abs(fft(r_ld_re));

%Triangular window
r_ld_tr = window_tr(r_ld_es);
R_ld_tr = abs(fft(r_ld_tr));

%Hamming window
r_ld_ha = window_ha(r_ld_es);
R_ld_ha = abs(fft(r_ld_ha));

%Bartlett window
r_ld_ba = window_ba(r_ld_es);
R_ld_ba = abs(fft(r_ld_ba));

%Blackmanharris window
r_ld_bl = window_bl(r_ld_es);
R_ld_bl = abs(fft(r_ld_bl));

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

%Improved ACF Plotted
figure;
subplot(3,1,1);
plot(nn, r_ld_re, 'b'); axis tight;
title('Improved ACF (Rectangular Window)');
subplot(3,1,2);
plot(nn, r_ld_tr, 'c'); axis tight;
title('Improved ACF (Triangular Window)');
subplot(3,1,3);
plot(nn, r_ld_ha, 'g'); axis tight;
title('Improved ACF (Hamming Window)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/acf_ld_plot1','-dpng');

figure;
subplot(3,1,1);
plot(nn, r_ld_ba, 'y'); axis tight;
title('Improved ACF (Bartlett Window)');
subplot(3,1,2);
plot(nn, r_ld_bl, 'm'); axis tight;
title('Improved ACF (Blackman-Harris Window)');
subplot(3,1,3);
plot(nn, r_ld_th, 'r'); axis tight;
title('Theoretical ACF');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/acf_ld_plot2','-dpng');

%Improved ACF Stemed
figure;
subplot(3,1,1);
stem(nn, r_ld_re, 'b'); xlim([-20,20]);
title('Improved ACF (Rectangular Window)');
subplot(3,1,2);
stem(nn, r_ld_tr, 'c'); xlim([-20,20]);
title('Improved ACF (Triangular Window)');
subplot(3,1,3);
stem(nn, r_ld_ha, 'g'); xlim([-20,20]);
title('Improved ACF (Hamming Window)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/acf_ld_stem1','-dpng');

figure;
subplot(3,1,1);
stem(nn, r_ld_ba, 'y'); xlim([-20,20]);
title('Improved ACF (Bartlett Window)');
subplot(3,1,2);
stem(nn, r_ld_bl, 'm'); xlim([-20,20]);
title('Improved ACF (Blackman-Harris Window)');
subplot(3,1,3);
stem(nn, r_ld_th, 'r'); xlim([-20,20]);
title('Theoretical ACF');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/acf_ld_stem2','-dpng');

%Improved PSD
figure;
subplot(3,1,1);
plot(ff, R_ld_re, 'b'); xlim([0,1]);
title('Improved PSD (Rectangular Window)');
subplot(3,1,2);
plot(ff, R_ld_tr, 'c'); xlim([0,1]);
title('Improved PSD (Triangular Window)');
subplot(3,1,3);
plot(ff, R_ld_ha, 'g'); xlim([0,1]);
title('Improved PSD (Hamming Window)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/psd_ld_window1','-dpng');

figure;
subplot(3,1,1);
plot(ff, R_ld_ba, 'y'); xlim([0,1]);
title('Improved PSD (Bartlett Window)');
subplot(3,1,2);
plot(ff, R_ld_bl, 'm'); xlim([0,1]);
title('Improved PSD (Blackman-Harris Window)');
subplot(3,1,3);
plot(ff, R_ld_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/psd_ld_window2','-dpng');

%Averaged PSD
figure;
subplot(4,1,1);
plot(ff, R_ld_av_l, 'b'); xlim([0,1]);
title('Averaged PSD (2^4)');
subplot(4,1,2);
plot(ff, R_ld_av_m, 'c'); xlim([0,1]);
title('Averaged PSD (2^6)');
subplot(4,1,3);
plot(ff, R_ld_av_h, 'g'); xlim([0,1]);
title('Averaged PSD (2^8)');
subplot(4,1,4);
plot(ff, R_ld_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/psd_ld_aver','-dpng');

%Averaged ACF Plotted
figure;
subplot(4,1,1);
plot(nn, r_ld_av_l, 'b'); axis tight;
title('Averaged ACF (2^4)');
subplot(4,1,2);
plot(nn, r_ld_av_m, 'c'); axis tight;
title('Averaged ACF (2^6)');
subplot(4,1,3);
plot(nn, r_ld_av_h, 'g'); axis tight;
title('Averaged ACF (2^8)');
subplot(4,1,4);
plot(nn, r_ld_th, 'r'); axis tight;
title('Theoretical ACF');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/acf_ld_aver_plot','-dpng');

%Averaged ACF Stemed
figure;
subplot(4,1,1);
stem(nn, r_ld_av_l, 'b'); xlim([-20,20]);
title('Averaged ACF (2^4)');
subplot(4,1,2);
stem(nn, r_ld_av_m, 'c'); xlim([-20,20]);
title('Averaged ACF (2^6)');
subplot(4,1,3);
stem(nn, r_ld_av_h, 'g'); xlim([-20,20]);
title('Averaged ACF (2^8)');
subplot(4,1,4);
stem(nn, r_ld_th, 'r'); xlim([-20,20]);
title('Theoretical ACF');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study2/acf_ld_aver_stem','-dpng');
