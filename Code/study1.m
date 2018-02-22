clear;
clc;
close all;

N = 16;
x=randn(1,2^N);
X = (1/N)*fft(x);
Rx = 1;
Ts = 1;

f = linspace(0,Ts,2^N);
t = linspace(0,Ts,2^N);

%%%HIGH DEGREE FILTER%%%

%%Theoretical functions%%

%Ideal filter (rectangle)
H_hd_th = rectangularPulse(-0.2, 0.2, f);
h_hd_th = 0.2*sinc(0.2*t);

%Final signal
Y_hd_th = X.*H_hd_th;
y_hd_th = x.*h_hd_th;

%%Results%%
R_hd_th = abs(H_hd_th).^2;
r_hd_th = ifft(R_hd_th, 'symmetric');

%%Estimated functions%%

%20th degree filter
wc_hd = 2*pi*fc_hd;
[b,a] = butter(20,2*wc_hd,'s');
H_hd_es = (polyval(b,f)./polyval(a,f));
h_hd_es = ifft(H_hd_es, 'symmetric');

%Final signal
Y_hd_es = X.*H_hd_es;
y_hd_es = ifft(Y_hd_es,'symmetric');

%%Results%%
r_hd_es = acf(y_hd_es);
R_hd_es = fft(r_hd_es);

%%%LOW DEGREE FILTER%%%

%%Theoretical functions%%

%Basic lowpassfilter (1/(1+j*f/fc))
H_ld_th = 1./(1-0.9*exp(-1i*2*pi*f));

%Final signal
Y_ld_th = X.*H_ld_th;
y_ld_th = ifft(Y_ld_th,'symmetric');

%Results%
R_ld_th = abs(H_ld_th).^2;
r_ld_th = ifft(R_ld_th,'symmetric');

%%Estimated functions%%

%First order lowpassfilter
wc_ld = 2*pi*fc_ld;
[d,c] = butter(1,2*wc_ld,'s');
H_ld_es = (polyval(d,f)./polyval(c,f));
h_ld_es = ifft(H_ld_es, 'symmetric');

%Final signal
Y_ld_es = X.*H_ld_es;
y_ld_es = ifft(Y_ld_es,'symmetric');

%Results%
r_ld_es = acf(y_ld_es);
R_ld_es = fft(r_ld_es);

%%%PLOT ZONE%%%

%Noise
figure;     %1
plot(t, x, 'm');
%Noise in frequency domain
figure;     %2
plot(f, X, 'b');

%%High degree filter%%

%Filter
figure;     %3
plot(f,H_hd_th, 'm');
%Filter absolute value
figure;     %4
plot(f,abs(H_hd_th), 'b');
%Filter in time domain
figure;     %5
plot(t, h_hd_th, 'c');
%Final signal
figure;     %6
plot(f,Y_hd_th), 'm';
%Final signal absolute value
figure;     %7
plot(f,abs(Y_hd_th), 'b');
%Final signal in time domain
figure;     %8
plot(t, y_hd_th, 'c');

%Theoretical ACF
figure;     %9
plot(t, r_hd_th, 'm');
figure;     %10
stem(t,r_hd_th, 'b'); xlim([-20,20]);
%Theoretical PSD
figure;     %11
plot(f,R_hd_th, 'c'); xlim([0,1]);

%Estimated ACF
figure;     %12
plot(t, r_hd_es, 'm');
figure;     %13
stem(t,r_hd_es, 'b'); xlim([-20,20]);
%Estimated PSD
figure;     %14
plot(f,R_hd_es, 'c'); xlim([0,1]);

%%Low degree filter%%

%Filter
figure;     %15
plot(f,H_ld_th, 'm');
%Filter absolute value
figure;     %16
plot(f,abs(H_ld_th), 'b');
%Filter in time domain
figure;     %17
plot(t, h_ld_th, 'c');
%Final signal
figure;     %18
plot(f,Y_ld_th, 'm');
%Final signal absolute value
figure;     %19
plot(f,abs(Y_ld_th), 'b');
%Final signal in time domain
figure;     %20
plot(t, y_ld_th, 'c');

%Theoretical ACF
figure;     %21
plot(t, r_ld_th, 'm');
figure;     %22
stem(t,r_ld_th, 'b'); xlim([-20,20]);
%Theoretical PSD
figure;     %23
plot(f,R_ld_th, 'c'); xlim([0,1]);

%Estimated ACF
figure;     %24
plot(t, r_ld_es, 'm');
figure;     %25
stem(t,r_ld_es, 'b'); xlim([-20,20]);
%Estimated PSD
figure;     %26
plot(f,R_ld_es, 'c'); xlim([0,1]);
