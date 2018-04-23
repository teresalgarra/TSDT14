%% STUDY 1: MODELLING SIGNALS %%

%By filtering white noise, the task is to obtain a signal with known power spectral density,
%filter it with a simple low degree low-pass filter and a low-pass ideal filter and then
%obtain the power spectral densities and auto correlation functions of the outputs both
%theoretically and with estimations.

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

%%%PLOT ZONE%%%

%Filter absolute value
figure;
plot(ff, abs(H_hd), 'b'); axis tight;
title('Filter (absolute value)');
xlabel('\theta');
ylabel('|H(\theta)|');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/H_hd_th','-dpng');

%Theoretical ACF
figure;
subplot(2,1,1);
plot(nn, r_hd_th, 'b'); axis tight;
title('Theoretical ACF Plotted');
xlabel('k');
ylabel('rx[k]');
subplot(2,1,2);
stem(nn, r_hd_th, 'b'); xlim([-20,20]);
title('Theoretical ACF Stemed');
xlabel('k');
ylabel('rx[k]');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_hd_th','-dpng');

%Theoretical PSD
figure;
plot(ff, R_hd_th, 'b'); xlim([0,1]);
title('Theoretical PSD');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/R_hd_th','-dpng');

%Estimated ACF
figure;
subplot(2,1,1);
plot(nn, r_hd_es, 'b'); axis tight;
title('Estimated ACF Plotted');
xlabel('k');
ylabel('rx[k]');
subplot(2,1,2);
stem(nn, r_hd_es, 'b'); xlim([-20,20]);
title('Estimated ACF Stemed');
xlabel('k');
ylabel('rx[k]');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_hd_es','-dpng');

%Estimated PSD
figure;
plot(ff, R_hd_es, 'b'); xlim([0,1]);
title('Estimated PSD');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/R_hd_es','-dpng');

%Comparations
figure;
subplot(2,1,1);
plot(nn, r_hd_th, 'b'); axis tight;
title('Theoretical ACF Plotted');
xlabel('k');
ylabel('rx[k]');
subplot(2,1,2);
plot(nn, r_hd_es, 'b'); axis tight;
title('Estimated ACF Plotted');
xlabel('k');
ylabel('rx[k]');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/comp_r_hd_plot','-dpng');

figure;
subplot(2,1,1);
stem(nn, r_hd_th, 'b'); xlim([-20,20]);
title('Theoretical ACF Stemed');
xlabel('k');
ylabel('rx[k]');
subplot(2,1,2);
stem(nn, r_hd_es, 'b'); xlim([-20,20]);
title('Estimated ACF Stemed');
xlabel('k');
ylabel('rx[k]');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/comp_r_hd_stem','-dpng');

figure;
subplot(2,1,1);
plot(ff, R_hd_th, 'b'); xlim([0,1]);
title('Theoretical PSD');
xlabel('\theta');
ylabel('Rx(\theta)');
subplot(2,1,2);
plot(ff, R_hd_es, 'b'); xlim([0,1]);
title('Estimated PSD');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/comp_R_hd','-dpng');

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

%%%PLOT ZONE%%%

%Filter absolute value
figure;
plot(ff, abs(H_ld), 'b'); axis tight;
title('Filter (absolute value)');
xlabel('\theta');
ylabel('|H(\theta)|');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/H_ld_th','-dpng');

%Theoretical ACF
figure;
subplot(2,1,1);
plot(nn, r_ld_th, 'b'); axis tight;
title('Theoretical ACF Plotted');
xlabel('k');
ylabel('rx[k]');
subplot(2,1,2);
stem(nn, r_ld_th, 'b'); xlim([-20,20]);
title('Theoretical ACF Stemed');
xlabel('k');
ylabel('rx[k]');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_ld_th','-dpng');

%Theoretical PSD
figure;
plot(ff, R_ld_th, 'b'); xlim([0,1]);
title('Theoretical PSD');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/R_ld_th','-dpng');

%Estimated ACF
figure;
subplot(2,1,1);
plot(nn, r_ld_es, 'b'); axis tight;
title('Estimated ACF Plotted');
xlabel('k');
ylabel('rx[k]');
subplot(2,1,2);
stem(nn, r_ld_es, 'b'); xlim([-20,20]);
title('Estimated ACF Stemed');
xlabel('k');
ylabel('rx[k]');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/r_ld_es','-dpng');

%Estimated PSD
figure;
plot(ff, R_ld_es, 'b'); xlim([0,1]);
title('Estimated PSD');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/R_ld_es','-dpng');

%Comparations
figure;
subplot(2,1,1);
plot(nn, r_ld_th, 'b'); axis tight;
title('Theoretical ACF Plotted');
xlabel('k');
ylabel('rx[k]');
subplot(2,1,2);
plot(nn, r_ld_es, 'b'); axis tight;
title('Estimated ACF Plotted');
xlabel('k');
ylabel('rx[k]');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/comp_r_ld_plot','-dpng');

figure;
subplot(2,1,1);
stem(nn, r_ld_th, 'b'); xlim([-20,20]);
title('Theoretical ACF Stemed');
xlabel('k');
ylabel('rx[k]');
subplot(2,1,2);
stem(nn, r_ld_es, 'b'); xlim([-20,20]);
title('Estimated ACF Stemed');
xlabel('k');
ylabel('rx[k]');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/comp_r_ld_stem','-dpng');

figure;
subplot(2,1,1);
plot(ff, R_ld_th, 'b'); xlim([0,1]);
title('Theoretical PSD');
xlabel('\theta');
ylabel('Rx(\theta)');
subplot(2,1,2);
plot(ff, R_ld_es, 'b'); xlim([0,1]);
title('Estimated PSD');
xlabel('\theta');
ylabel('Rx(\theta)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study1/comp_R_ld','-dpng');
