%% STUDY 2: IMPROVING ESTIMATES %%
%% Second part: High Degree Filter %%

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

%%%HIGH DEGREE FILTER%%%              %This is taken from study 1.

%%High Degree filter%%                %I will approximate an ideal filter with a rectangle
H_hd = linspace(0,1,N);
H_hd(1:0.1*N) = 1;                    %The cut-off frequency is 0.1
H_hd(0.1*N+1:0.9*N) = 0;
H_hd(0.9*N+1:N) = 1;                  %It's digital, so it's periodical, so it goes up again in 1-0.1 = 0.9

%%Filtered signal%%
Y_hd = X.*H_hd;                       %For the frequency domain, I just multiply the input and the filter
y_hd = ifft(Y_hd);                    %To switch to time domain, I use the inverse Fourier Transform

%%Theoretical Results%%
R_hd_th = 5*abs(H_hd).^2;             %The formula is 0.5*Rx*abs(filter)^2
r_hd_th = 10*2*2*0.1*sinc(2*0.1*nn);  %I used the table of Fourier Transforms to calculate this

%%Estimated Results%%
r_hd_es = 2*acf(y_hd);                %I use the double of the defined function so it fits the theoretical results
R_hd_es = 0.5*abs(fft(r_hd_es));      %I come back to half of the function and then go to frequency domain.

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
