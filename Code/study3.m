%% STUDY 3: NON-LTI SYSTEMS %%

%I am given a series of non-linear systems: a squarer, a half-wave rectifier
%and a AM-SC Modulator. I will compare them to the filtered signal I get from
%the ideal filter through the PSD.

clear;
clc;
close all;

%% SQUARER %%

%%Data%%
N = 2^16;                             %Number of samples
Rx = 10;                              %Power Spectral Density of the noise
x=randn(1,N)*sqrt(Rx);                %Random noise with poffer Spectral Density 10
X = fft(x, N);                        %Random noise in the frequency domain
L = 100;                              %Beans value for the historiograms

%%Vectors%%
Ts = 1;                               %Step for the vectos
ff= linspace(0,Ts,N);                 %Frequency vector for plotting

%%LINEAR FILTER%%

%%High Degree filter%%                %I will approximate an ideal filter with a rectangle
H = linspace(0,1,N);
H(1:0.1*N) = 1;                       %The cut-off frequency is 0.1
H(0.1*N+1:0.9*N) = 0;
H(0.9*N+1:N) = 1;                     %It's digital, so it's periodical, so it goes up again in 1-0.1 = 0.9

%%Filtered signal%%
Y = X.*H;                             %For the frequency domain, I just multiply the input and the filter
y = ifft(Y);                          %To switch to time domain, I use the inverse Fourier Transform

%%Theoretical Results%%
R_th = Rx*abs(H).^2;                  %The formula is 0.5*Rx*abs(filter)^2

%%Estimated Results%%
r_es = acf(y);                        %I use the defined function
R_es = abs(fft(r_es));                %I go to frequency domain to get the PSD

%%SQUARER%%

%Theoretical PSD
R_th_sq = 4*Rx*(tripuls(ff/(4*0.1))+tripuls((ff-1)/(4*0.1)));     %I get this from the tables in the book

%Estimated PSD
y_sq = real(y.^2);                    %I square the whole filtered signal
r_es_sq = acf(y_sq);                  %I use the defined function
R_es_sq = abs(fft(r_es_sq));          %I go to frequency domain to get the PSD

%%%PLOT ZONE%%%

%Theoretical PSD
figure;
plot(ff, R_th_sq, 'b'); xlim([0,1]);
title('Theoretical PSD (Squarer)');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/R_th_sq','-dpng');

%Comparation of theoretical PSDs
figure;
subplot(2,1,1);
plot(ff, R_th_sq, 'b'); xlim([0,1]);
title('Theoretical PSD (Squarer)');
xlabel('\theta');
ylabel('Rx(\theta)');
subplot(2,1,2);
plot(ff, R_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/comp_psd_sq_th','-dpng');

%Estimated PSD
figure;
plot(ff, R_es_sq, 'b'); xlim([0,1]);
title('Estimated PSD (Squarer)');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/R_es_sq','-dpng');

%Estimated PSD Close Up
figure;
plot(ff, R_es_sq, 'b'); xlim([0,1]); ylim([0,200]);
title('Estimated PSD (Squarer), details');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/R_es_sq_zoom','-dpng');

%Comparation of estimated PSDs
figure;
subplot(2,1,1);
plot(ff, R_es_sq, 'b'); xlim([0,1]); ylim([0,200]);
title('Estimated PSD (Squarer)');
xlabel('\theta');
ylabel('Rx(\theta)');
subplot(2,1,2);
plot(ff, R_es, 'r'); xlim([0,1]);
title('Estimated PSD');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/comp_psd_sq_es','-dpng');

%Comparations
figure;
subplot(3,1,1);
plot(ff, R_es_sq, 'b'); xlim([0,1]);
title('Estimated PSD (Squarer)');
xlabel('\theta');
ylabel('Rx(\theta)');
subplot(3,1,2);
plot(ff, R_es_sq, 'b'); xlim([0,1]); ylim([0,200]);
title('Estimated PSD (Squarer), details');
xlabel('\theta');
ylabel('Rx(\theta)');
subplot(3,1,3);
plot(ff, R_th_sq, 'r'); xlim([0,1]);
title('Theoretical PSD (Squarer)');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/comp_psd_sq','-dpng');

%Histogram
figure;
hist(y_sq, L, 'b');  xlim([-0.05,30]);
title('Histogram (Squarer)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/hist_sq','-dpng');

%% HALF-WAVE RECTIFIER %%

%%Data%%
N = 2^16;                             %Number of samples
Rx = 10;                              %Power Spectral Density of the noise
x=randn(1,N)*sqrt(Rx);                %Random noise with poffer Spectral Density 10
X = fft(x, N);                        %Random noise in the frequency domain
L = 100;                              %Beans value for the historiograms

%%Vectors%%
Ts = 1;                               %Step for the vectos
ff= linspace(0,Ts,N);                 %Frequency vector for plotting

%%LINEAR FILTER%%

%%High Degree filter%%                %I will approximate an ideal filter with a rectangle
H = linspace(0,1,N);
H(1:0.1*N) = 1;                       %The cut-off frequency is 0.1
H(0.1*N+1:0.9*N) = 0;
H(0.9*N+1:N) = 1;                     %It's digital, so it's periodical, so it goes up again in 1-0.1 = 0.9

%%Filtered signal%%
Y = X.*H;                             %For the frequency domain, I just multiply the input and the filter
y = ifft(Y);                          %To switch to time domain, I use the inverse Fourier Transform

%%Theoretical Results%%
R_th = Rx*abs(H).^2;                  %The formula is 0.5*Rx*abs(filter)^2

%%Estimated Results%%
r_es = acf(y);                        %I use the defined function
R_es = abs(fft(r_es));                %I go to frequency domain to get the PSD

%%HALF-WAVE RECTIFIER%%

%Theoretical PSD
R_th_hw = Rx/(4*pi)*(tripuls(ff/(4*0.1))+tripuls((ff-1)/(4*0.1)))+Rx/4*(rectpuls(ff/(2*0.1))+rectpuls((ff-1)/(2*0.1)));     %I get this from the tables in the book
R_th_hw(1) = R_th_hw(1) + 0.5*Rx/(2*pi);

%Estimated PSD
y_hw = real(hw_rectifier(y, N));      %I use the defined function
r_es_hw = acf(y_hw);                  %I use the defined function
R_es_hw = abs(fft(r_es_hw));          %I go to frequency domain to get the PSD

%%%PLOT ZONE%%%

%Theoretical PSD
figure;
plot(ff, R_th_hw, 'b'); xlim([0,1]);
title('Theoretical PSD (Half-Wave Rectifier)');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/R_th_hw','-dpng');

%Comparation of theoretical PSDs
figure;
subplot(2,1,1);
plot(ff, R_th_hw, 'b'); xlim([0,1]);
title('Theoretical PSD (Half-Wave Rectifier)');
xlabel('\theta');
ylabel('Rx(\theta)');
subplot(2,1,2);
plot(ff, R_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/comp_psd_hw_th','-dpng');

%Estimated PSD
figure;
plot(ff, R_es_hw, 'b'); xlim([0,1]);
title('Estimated PSD (Half-Wave Rectifier)');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/R_es_hw','-dpng');

%Estimated PSD Close Up
figure;
plot(ff, R_es_hw, 'b'); xlim([0,1]); ylim([0,30]);
title('Estimated PSD (Half-Wave Rectifier), details');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/R_es_hw_zoom','-dpng');

%Comparation of estimated PSDs
figure;
subplot(2,1,1);
plot(ff, R_es_hw, 'b'); xlim([0,1]); ylim([0,30]);
title('Estimated PSD (Half-Wave Rectifier)');
xlabel('\theta');
ylabel('Rx(\theta)');
subplot(2,1,2);
plot(ff, R_es, 'r'); xlim([0,1]);
title('Estimated PSD');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/comp_psd_hw_es','-dpng');

%Comparations
figure;
subplot(3,1,1);
plot(ff, R_es_hw, 'b'); xlim([0,1]);
title('Estimated PSD (Half-Wave Rectifier)');
xlabel('\theta');
ylabel('Rx(\theta)');
subplot(3,1,2);
plot(ff, R_es_hw, 'b'); xlim([0,1]); ylim([0,30]);
title('Estimated PSD (Half-Wave Rectifier), details');
xlabel('\theta');
ylabel('Rx(\theta)');
subplot(3,1,3);
plot(ff, R_th_hw, 'r'); xlim([0,1]);
title('Theoretical PSD (Half-Wave Rectifier)');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/comp_psd_hw','-dpng');

%Histogram
figure;
hist(y_hw, L, 'b'); xlim([-0.05,5]);
title('Histogram (Half-Wave Rectifier)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/hist_hw','-dpng');

%% AM-SC MODULATOR %%

%%Data%%
N = 2^16;                             %Number of samples
Rx = 10;                              %Power Spectral Density of the noise
x=randn(1,N)*sqrt(Rx);                %Random noise with poffer Spectral Density 10
X = fft(x, N);                        %Random noise in the frequency domain
L = 100;                              %Beans value for the historiograms

%%Vectors%%
Ts = 1;                               %Step for the vectos
ff = linspace(0,Ts,N);                %Frequency vector for plotting
nn = linspace(0,N,N);                 %Vector for the carrier

%%LINEAR FILTER%%

%%High Degree filter%%                %I will approximate an ideal filter with a rectangle
H = linspace(0,1,N);
H(1:0.1*N) = 1;                       %The cut-off frequency is 0.1
H(0.1*N+1:0.9*N) = 0;
H(0.9*N+1:N) = 1;                     %It's digital, so it's periodical, so it goes up again in 1-0.1 = 0.9

%%Filtered signal%%
Y = X.*H;                             %For the frequency domain, I just multiply the input and the filter
y = ifft(Y);                          %To switch to time domain, I use the inverse Fourier Transform

%%Theoretical Results%%
R_th = Rx*abs(H).^2;                  %The formula is 0.5*Rx*abs(filter)^2

%%Estimated Results%%
r_es = acf(y);                        %I use the defined function
R_es = abs(fft(r_es));                %I go to frequency domain to get the PSD

%%AM-SC MODULATOR%%

%Theoretical PSD
R_th_am = Rx*1/4*(rectpuls((ff-0.25)/(0.2))+rectpuls((ff-1-0.25)/(0.2))) + Rx*1/4*(rectpuls((ff+0.25)/(0.2))+rectpuls((ff-1+0.25)/(0.2)));     %I get this from the tables in the book

%Estimated PSD
carrier = cos(nn*2*pi*0.25);          %I define a carrier for our modulation
y_am = real(y.*carrier);              %I modulate multiplying the signal and the carrier
r_es_am = acf(y_am);                  %I use the defined function
R_es_am = abs(fft(r_es_am));          %I go to frequency domain to get the PSD

%%%PLOT ZONE%%%

%Theoretical PSD
figure;
plot(ff, R_th_am, 'b'); xlim([0,1]);
title('Theoretical PSD (AM-SC Modulator)');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/R_th_am','-dpng');

%Comparation of theoretical PSDs
figure;
subplot(2,1,1);
plot(ff, R_th_am, 'b'); xlim([0,1]);
title('Theoretical PSD (AM-SC Modulator)');
xlabel('\theta');
ylabel('Rx(\theta)');
subplot(2,1,2);
plot(ff, R_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/comp_psd_am_th','-dpng');

%Estimated PSD
figure;
plot(ff, R_es_am, 'b'); xlim([0,1]);
title('Estimated PSD (AM-SC Modulator)');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/R_es_am','-dpng');

%Comparation of estimated PSDs
figure;
subplot(2,1,1);
plot(ff, R_es_am, 'b'); xlim([0,1]);
title('Estimated PSD (AM-SC Modulator)');
xlabel('\theta');
ylabel('Rx(\theta)');
subplot(2,1,2);
plot(ff, R_es, 'r'); xlim([0,1]);
title('Estimated PSD');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/comp_psd_am_es','-dpng');

%Comparations
figure;
subplot(2,1,1);
plot(ff, R_es_am, 'b'); xlim([0,1]);
title('Estimated PSD (AM-SC Modulator)');
xlabel('\theta');
ylabel('Rx(\theta)');
subplot(2,1,2);
plot(ff, R_th_am, 'r'); xlim([0,1]);
title('Theoretical PSD (AM-SC Modulator)');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/comp_psd_am','-dpng');

%Histogram
figure;
hist(y_am, L, 'b');
title('Histogram (AM-SC Modulator)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/hist_am','-dpng');

%% COMPARATIONS %%

figure;
subplot(4,1,1);
plot(ff, R_th_sq, 'b'); xlim([0,1]);
title('Theoretical PSD (Squarer)');
xlabel('\theta');
ylabel('Rx(\theta)');
subplot(4,1,2);
plot(ff, R_th_hw, 'b'); xlim([0,1]);
title('Theoretical PSD (Half-wave rectifier)');
xlabel('\theta');
ylabel('Rx(\theta)');
subplot(4,1,3);
plot(ff, R_th_am, 'b'); xlim([0,1]);
title('Theoretical PSD (AM-SC Modulator)');
xlabel('\theta');
ylabel('Rx(\theta)');
subplot(4,1,4);
plot(ff, R_th, 'r'); xlim([0,1]);
title('Theoretical PSD (Original)');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/comp_psd_th','-dpng');

figure;
subplot(4,1,1);
plot(ff, R_es_sq, 'b'); xlim([0,1]); ylim([0,200]);
title('Estimated PSD (Squarer)');
xlabel('\theta');
ylabel('Rx(\theta)');
subplot(4,1,2);
plot(ff, R_es_hw, 'b'); xlim([0,1]); ylim([0,30]);
title('Estimated PSD (Half-wave rectifier)');
xlabel('\theta');
ylabel('Rx(\theta)');
subplot(4,1,3);
plot(ff, R_es_am, 'b'); xlim([0,1]); ylim([0,50]);
title('Estimated PSD (AM-SC Modulator)');
xlabel('\theta');
ylabel('Rx(\theta)');
subplot(4,1,4);
plot(ff, R_es, 'r'); xlim([0,1]);
title('Estimated PSD (Original)');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/comp_psd_es','-dpng');

figure;
subplot(4,1,1);
hist(y_sq, L, 'b'); xlim([-0.05,30]);
title('Histogram (Squarer)');
subplot(4,1,2);
hist(y_hw, L, 'b'); xlim([-0.05,5]);
title('Histogram (Half-wave rectifier)');
subplot(4,1,3);
hist(y_am, L, 'b');
title('Histogram (AM-SC Modulator)');
subplot(4,1,4);
hist(real(y), L, 'r');
title('Histogram (Original)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study3/comp_hist','-dpng');
