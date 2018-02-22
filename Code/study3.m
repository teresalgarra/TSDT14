clear;
clc;
close all;

N = 16;
Ts = 1;
dt = Ts/2^N;
fs = 1/dt;
x=randn(1,2^N);
X = (1/N)*fft(x);
Rx = 1;
T = Ts/2^N; %sampling length.
fc  = 1; %Si no funciona algo, igual aquí es 10
wc = 0.1;
fc_hd  = 1;

w = linspace(0, 1, 2^N);
n = linspace(0, 2^N, 2^N);

f = linspace(0,Ts,2^N);
t = linspace(0,Ts,2^N);

%Theoretical Calculations

%Ideal filter (rectangle)
space = linspace(0,99.99,10000);
H_th = zeros(size(X));
H_th(abs(space)<fc_hd) = 1;
h_th = ifft(H_th, 'symmetric');

%Filtered signal
Y_th = X.*H_th;
y_th = ifft(Y_th,'symmetric');

%First PSD
R_th = zeros(1,N);
R_th(abs(w) <wc ) = 1;
R_th(abs(w) >1-wc ) = 1;

%Squarer PSD
R_th_sq = 4*wc*(tripuls(w/(4*wc))+tripuls((w-1)/(4*wc)));
R_th_sq(1) = R_th_sq(1) + 4*wc^2;

%Half-Wave Rectifier PSD
R_th_hw = 1/(4*pi)*(tripuls(w/(4*wc))+tripuls((w-1)/(4*wc)))+...
    +1/4*(rectpuls(w/(2*wc))+rectpuls((w-1)/(2*wc)));
R_th_hw(1) = R_th_hw(1)+wc/pi;

%AM-SC Modulator PSD
t0 = (2*pi*(wc+0.2));
t1=t0/(2*pi);
R_th_am = 1/4*(rectpuls((w-t1)/(2*wc))+rectpuls((w-1-t1)/(2*wc))) + 1/4*(rectpuls((w+t1)/(2*wc))+rectpuls((w-1+t1)/(2*wc)));

%%Estimated functions%%

%10th degree filter
wc = 2*pi*fc;
[b,a] = butter(10,2*wc,'s');
H_es = (polyval(b,f)./polyval(a,f));
h_es = ifft(H_es, 'symmetric');

%Filtered signal
Y_es = X.*H_es;
y_es = ifft(Y_es,'symmetric');

%Squarer PSD
y_es_sq = y_es.^2;
Y_es_sq = abs(fft(y_es_sq));

r_es_sq_ba = es_bartlett(y_es_sq);
R_es_sq_ba = abs(fft(r_es_sq_ba));

r_es_sq_bl = es_blackman(y_es_sq);
R_es_sq_bl = abs(fft(r_es_sq_bl));

%Half-Wave Rectifier PSD
y_es_hw = zeros(1,2^N);
Y_es_hw = abs(fft(y_es_hw));

r_es_hw_ba = es_bartlett(y_es_hw);
R_es_hw_ba = abs(fft(r_es_hw_ba));

r_es_hw_bl = es_blackman(y_es_hw);
R_es_hw_bl = abs(fft(r_es_hw_bl));

%AM-SC Modulator PSD
y_es_am = y_es.*cos(t0*n);
Y_es_am = abs(fft(y_es_am));

r_es_am_ba = es_bartlett(y_es_am);
R_es_am_ba = abs(fft(r_es_am_ba));

r_es_am_bl = es_blackman(y_es_am);
R_es_am_bl = abs(fft(r_es_am_bl));

%%Historiograms%%

L = 100;
l = linspace(0,1,L);

%%%PLOT ZONE%%%

%%Theoretical Calculations%%

%%Systems%%

%Filter
figure;     %1
plot(f,H_es, 'm');
%Filter absolute value
figure;     %2
plot(f,abs(H_es), 'b');
%Filter in time domain
figure;     %3
plot(t,h_es, 'c');

%Filtered signal
figure;     %4
plot(f,Y_th, 'm');
%Filtered signal absolute value
figure;     %5
plot(f,abs(Y_th), 'b');
%Filtered signal in time domain
figure;     %6
plot(t,y_th, 'c');

%Squarer PSD
figure;     %7
plot(f, R_th_sq, 'm'); xlim([0,1]);

%Half-Wave Rectifier PSD
figure;     %8
plot(f, R_th_hw, 'b'); xlim([0,1]);

%AM-SC Modulator PSD
figure;     %9
plot(f, R_th_am, 'c'); xlim([0,1]);

%%Estimated Calculations%%

%Filtered signal
figure;     %10
plot(f,Y_es), 'm';
%Filtered signal absolute value
figure;     %11
plot(f,abs(Y_es), 'b');
%Filtered signal in time domain
figure;     %12
plot(t,y_es, 'c');
%Squarer signal in time domain
figure;     %13
plot(t,y_es_sq, 'm');
%Half-Wave signal in time domain
figure;     %14
plot(t,y_es_hw, 'b');
%AM_SC Modulator signal in time domain
figure;     %15
plot(t,y_es_am, 'c');

%Squarer PSD
figure;     %16
plot(f, R_es_sq_ba, 'm'); xlim([0,1]);
figure;     %17
plot(f, R_es_sq_bl, 'b'); xlim([0,1]);

%Half-Wave Rectifier PSD
figure;     %18
plot(f, R_es_hw_ba, 'm'); xlim([0,1]);
figure;     %19
plot(f, R_es_hw_bl, 'b'); xlim([0,1]);

%AM-SC Modulator PSD
figure;     %20
plot(f, R_es_am_ba, 'm'); xlim([0,1]);
figure;     %21
plot(f, R_es_am_bl, 'b'); xlim([0,1]);

%%Historiograms%

%Filtered signal
figure;     %22
hist(y_es, L, 'm');
%Squarer
figure;     %23
hist(y_es_sq, L, 'b');
%Half-Wave Rectifier
figure;     %24
hist(y_es_hw, L, 'c');
%AM_SC Modulator
figure;     %25
hist(y_es_am, L, 'g');
