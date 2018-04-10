%% STUDY 4: SPECIAL OPERATIONS %%

%Signal processing is an area where many different ways to manipulate signals are used.
%Here I study a two simple manipulations, alternating with +1 and -1, and decimating the signal.

clear;
clc;
close all;

%% ALTERNATING SYSTEM %%

%%Data%%
N = 2^16;                             %Number of samples
Rx = 10;                              %Power Spectral Density of the noise
x=randn(1,N)*sqrt(Rx);                %Random noise with poffer Spectral Density 10
X = fft(x, N);                        %Random noise in the frequency domain

%%Vectors%%
Ts = 1;                               %Step for the vectos
ff= linspace(0,Ts,N);                 %Frequency vector for plotting
tt = 0:Ts:(N)-1;                      %Natural vector for plotting

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

%%SYSTEM%%

%Theoretical PSD
R_th_a = Rx*rectpuls((ff-1/2)/(2*0.1));     %I get this from the book

%Estimated PSD
s_a = ones(1, N);                     %I create an array of ones
s_a = s_a.*(-1).^(tt);                %I multiply it by -1 only every other one
y_a = y.*s_a;                         %I multiply the signal by the array of alternating 1s and -1s
r_es_a = acf(y_a);                    %I use the defined function
R_es_a = abs(fft(r_es_a));            %I go to frequency domain to get the PSD

%%%PLOT ZONE%%%

%Theoretical PSD
figure;
plot(ff, R_th_a, 'b'); xlim([0,1]);
title('Theoretical PSD (Alternating System)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study4/R_th_a','-dpng');

%Comparation of theoretical PSDs
figure;
subplot(2,1,1);
plot(ff, R_th_a, 'b'); xlim([0,1]);
title('Theoretical PSD (Alternating System)');
subplot(2,1,2);
plot(ff, R_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study4/comp_psd_a_th','-dpng');

%Estimated PSD
figure;
plot(ff, R_es_a, 'b'); xlim([0,1]);
title('Estimated PSD (Alternating System)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study4/R_es_a','-dpng');

%Comparation of estimated PSDs
figure;
subplot(2,1,1);
plot(ff, R_es_a, 'b'); xlim([0,1]);
title('Estimated PSD (Alternating System)');
subplot(2,1,2);
plot(ff, R_es, 'r'); xlim([0,1]);
title('Estimated PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study4/comp_psd_a_es','-dpng');

%Comparations
figure;
subplot(2,1,1);
plot(ff, R_es_a, 'b'); xlim([0,1]);
title('Estimated PSD (Alternating System)');
subplot(2,1,2);
plot(ff, R_th_a, 'r'); xlim([0,1]);
title('Theoretical PSD (Alternating System)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study4/comp_psd_a','-dpng');

%% DECIMATING SYSTEM %%

%%Data%%
N = 2^16;                             %Number of samples
Rx = 10;                              %Power Spectral Density of the noise
x=randn(1,N)*sqrt(Rx);                %Random noise with poffer Spectral Density 10
X = fft(x, N);                        %Random noise in the frequency domain
L = 100;                              %Beans value for the historiograms

%%Vectors%%
Ts = 1;                               %Step for the vectos
ff= linspace(0,Ts,N);                 %Frequency vector for plotting
tt = 0:Ts:(N)-1;                      %Natural vector for plotting

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

%%SYSTEM%%

%Theoretical PSD
R_th_d = Rx/4*(rectpuls((ff-1/2)/(2*0.1))) + Rx/4*(rectpuls(ff/(2*0.1))+rectpuls((ff-1)/(2*0.1)));     %I get this from the book

%Estimated PSD
y_d = decimate(y);                    %I use the defined function
r_es_d = acf(y_d);                    %I use the defined function
R_es_d = abs(fft(r_es_d));            %I go to frequency domain to get the PSD

%%%PLOT ZONE%%%

%Theoretical PSD
figure;
plot(ff, R_th_d, 'b'); xlim([0,1]);
title('Theoretical PSD (Decimating System)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study4/R_th_d','-dpng');

%Comparation of theoretical PSDs
figure;
subplot(2,1,1);
plot(ff, R_th_d, 'b'); xlim([0,1]);
title('Theoretical PSD (Decimating System)');
subplot(2,1,2);
plot(ff, R_th, 'r'); xlim([0,1]);
title('Theoretical PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study4/comp_psd_d_th','-dpng');

%Estimated PSD
figure;
plot(ff, R_es_d, 'b'); xlim([0,1]);
title('Estimated PSD (Decimating System)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study4/R_es_d','-dpng');

%Comparation of estimated PSDs
figure;
subplot(2,1,1);
plot(ff, R_es_d, 'b'); xlim([0,1]);
title('Estimated PSD (Decimating System)');
subplot(2,1,2);
plot(ff, R_es, 'r'); xlim([0,1]);
title('Estimated PSD');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study4/comp_psd_d_es','-dpng');

%Comparations
figure;
subplot(2,1,1);
plot(ff, R_es_d, 'b'); xlim([0,1]);
title('Estimated PSD (Decimating System)');
subplot(2,1,2);
plot(ff, R_th_d, 'r'); xlim([0,1]);
title('Theoretical PSD (Decimating System)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study4/comp_psd_d','-dpng');

%% COMPARATIONS %%

figure;
subplot(3,1,1);
plot(ff, R_th_a, 'b'); xlim([0,1]);
title('Theoretical PSD (Alternating System)');
subplot(3,1,2);
plot(ff, R_th_d, 'b'); xlim([0,1]);
title('Theoretical PSD (Decimating System)');
subplot(3,1,3);
plot(ff, R_th, 'r'); xlim([0,1]);
title('Theoretical PSD (Original)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study4/comp_psd_th','-dpng');

figure;
subplot(3,1,1);
plot(ff, R_es_a, 'b'); xlim([0,1]);
title('Estimated PSD (Alternating System)');
subplot(3,1,2);
plot(ff, R_es_d, 'b'); xlim([0,1]);
title('Estimated PSD (Decimating System)');
subplot(3,1,3);
plot(ff, R_es, 'r'); xlim([0,1]);
title('Estimated PSD (Original)');
print('~/Carrera/TSDT14/TSDT14_Labs/Report/images/study4/comp_psd_es','-dpng');
