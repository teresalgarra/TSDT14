%% STUDY 2: IMPROVING ESTIMATES %%
%% First part: Low Degree Filter %%

%The estimated spectra from Study 1 are rough. The aim is to improve those estimates using averaging and smoothing.
%I have divided the study in two scripts so it doesn't take too long to plot each one of the filters.

%For the averaging I have three functions that work the same but with different values. The low one leaves the periodogram still a bit raw,
%the medium value it's the best one, and the highest value becomes inaccurate and the periodogram becomes distorted.

%For the smoothing I will be using five windows: rectangular, triangular, Hamming, Bartlett and Blackman-Harris.

clear;
clc;
close all;

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

%%%LOW DEGREE FILTER%%%               %This is taken from study 1.

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
