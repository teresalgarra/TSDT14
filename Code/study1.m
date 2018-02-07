clear;
clc;
close all;

Ts = 1;
N = 16;
x=randn(1,2^N);
X = (1/N)*fft(x);
Rx = 1;

fc_ld = 0.9;
fc_hd  = 1; %Si no funciona algo, igual aquí es 10

%Plot stuff for the high degree filter
fh = 0:0.01:99.99;
th = 0:0.01:99.99;
dth = 0.01;
fsh = 1/dth;

%Plot stuff for the low degree filter
fl = linspace(0,Ts,2^N);
tl = linspace(0,Ts,2^N);
dtl = Ts/2^N;
fsl = 1/dtl;

%%%HIGH DEGREE FILTER%%%

%%Theoretical functions%%

%Ideal filter (rectangle)
space = linspace(0,99.99,10000);
H_hd_th = zeros(size(X));
H_hd_th(abs(space)<fc_hd) = 1;
h_hd_th = ifft(H_hd_th, 'symmetric');

%Final signal
Y_hd_th = X.*H_hd_th;
%We switch back to time domain
y_hd_th = ifft(Y_hd_th,'symmetric');

%%Results%%
R_hd_th = abs(H_hd_th).^2 * Rx;
r_hd_th = ifft(R_hd_th);

r_hd_th_ba = es_bartlett(y_hd_th);
R_hd_th_ba = fft(r_hd_th_ba);

r_hd_th_bl = es_blackman(y_hd_th);
R_hd_th_bl = fft(r_hd_th_bl);

%%Estimated functions%%

%10th degree filter
wc_hd = 2*pi*fc_hd;
[b,a] = butter(10,2*wc_hd,'s');
H_hd_es = (polyval(b,fc_hd)./polyval(a,fc_hd));
h_hd_es = iift(H_hd_es, 'symmetric');

%Final signal
Y_hd_es = X.*H_hd_es;
%We switch back to time domain
y_hd_es = ifft(Y_hd_es,'symmetric');

%%Results%%
R_hd_es = abs(H_hd_es).^2 * Rx;
r_hd_es = ifft(R_hd_es);

r_hd_es_ba = es_bartlett(y_hd_es);
R_hd_es_ba = fft(r_hd_es_ba);

r_hd_es_bl = es_blackman(y_hd_es);
R_hd_es_bl = fft(r_hd_es_bl);

%%%LOW DEGREE FILTER%%%

%%Theoretical functions%%

%Basic lowpassfilter (1/(1+j*f/fc))
H_ld_th = 1./(1-fc_ld*exp(-i*2*pi*fc_ld));
h_ld_th = ifft(H_ld_th, 'symmetric');

%Final signal
Y_ld_th = X.*H_ld_th;
%We switch back to time domain
y_ld_th = ifft(Y_ld_th,'symmetric');

%Results%
R_ld_th = abs(H_ld_th).^2 * Rx;
r_ld_th = ifft(R_ld_th,'symmetric')/dth;

r_ld_th_ba = es_bartlett(y_ld_th);
R_ld_th_ba = fft(r_ld_th_ba);

r_ld_th_bl = es_blackman(y_ld_th);
R_ld_th_bl = fft(r_ld_th_bl);

%%Estimated functions%%

%First order lowpassfilter
wc_ld = 2*pi*fc_ld;
[d,c] = butter(1,2*wc_ld,'s');
H_ld_es = (polyval(d,fc_ld)./polyval(c,fc_ld));
h_ld_es = iift(H_ld_es, 'symmetric');

%Final signal
Y_ld_es = X.*H_ld_es;
%We switch back to time domain
y_ld_es = ifft(Y_ld_es,'symmetric');

%Results%
R_ld_es = abs(H_ld_es).^2 * Rx;
r_ld_es = ifft(R_ld_es,'symmetric')/dtl;

r_ld_es_ba = es_bartlett(y_ld_es);
R_ld_es_ba = fft(r_ld_es_ba);

r_ld_es_bl = es_blackman(y_ld_es);
R_ld_es_bl = fft(r_ld_es_bl);

%%%PLOT ZONE%%%

%Noise
figure;     %1
plot(t,x, 'm');
%Noise in frequency domain
figure;     %2
plot(f, X, 'b');

%%High degree filter%%

%Filter
figure;     %3
plot(w,H_hd, 'm');
%Filter absolute value
figure;     %4
plot(w,abs(H_hd), 'b');
%Filter in time domain
figure;     %5
plot(t,h_hd, 'c');
%Final signal
figure;     %6
plot(f,Y_hd), 'm';
%Final signal absolute value
figure;     %7
plot(f,abs(Y_hd), 'b');
%Final signal in time domain
figure;     %8
plot(t,y_hd, 'c');

%Theoretical ACF
figure;     %9
plot(t,r_hd_th, 'm');
figure;     %10
stem(t(1:20),r_hd_th(1:20), 'b'); xlim([-0.2,20.2]);
%Theoretical ACF Bartlett
figure;     %11
plot(t,r_hd_th_ba, 'm');
figure;     %12
stem(t(1:20),r_hd_th_ba(1:20), 'b'); xlim([-0.2,20.2]);
%Theoretical ACF Blackman
figure;     %13
plot(t,r_hd_th_bl, 'm');
figure;     %14
stem(t(1:20),r_hd_th_bl(1:20), 'b'); xlim([-0.2,20.2]);
%Theoretical PSD
figure;     %15
plot(f,R_hd_th, 'c'); xlim([0,1]);

%Estimated ACF
figure;     %16
plot(t,r_hd_es, 'm');
figure;     %17
stem(t(1:20),r_hd_es(1:20), 'b'); xlim([-0.2,20.2]);
%Estimated ACF Bartlett
figure;     %18
plot(t,r_hd_es_ba, 'm');
figure;     %19
stem(t(1:20),r_hd_es_ba(1:20), 'b'); xlim([-0.2,20.2]);
%Estimated ACF Blackman
figure;     %20
plot(t,r_hd_es_bl, 'm');
figure;     %21
stem(t(1:20),r_hd_es_bl(1:20), 'b'); xlim([-0.2,20.2]);
%Estimated PSD
figure;     %22
plot(f,R_hd_es, 'c'); xlim([0,1]);

%%Low degree filter%%

%Filter
figure;     %23
plot(w,H_ld, 'm');
%Filter absolute value
figure;     %24
plot(w,abs(H_ld), 'b');
%Filter in time domain
figure;     %25
plot(t,h_ld, 'c');
%Final signal
figure;     %26
plot(f,Y_ld, 'm');
%Final signal absolute value
figure;     %27
plot(f,abs(Y_ld), 'b');
%Final signal in time domain
figure;     %28
plot(t,y_ld, 'c');

%Theoretical ACF
figure;     %29
plot(t,r_ld_th, 'm');
figure;     %30
stem(t(1:20),r_ld_th(1:20), 'b'); xlim([-0.2,20.2]);
%Theoretical ACF Bartlett
figure;     %31
plot(t,r_ld_th_ba, 'm');
figure;     %32
stem(t(1:20),r_ld_th_ba(1:20), 'b'); xlim([-0.2,20.2]);
%Theoretical ACF Blackman
figure;     %33
plot(t,r_ld_th_bl, 'm');
figure;     %34
stem(t(1:20),r_ld_th_bl(1:20), 'b'); xlim([-0.2,20.2]);
%Theoretical PSD
figure;     %35
plot(f,R_ld_th, 'c'); xlim([0,1]);

%Estimated ACF
figure;     %36
plot(t,r_ld_es, 'm');
figure;     %37
stem(t(1:20),r_ld_es(1:20), 'b'); xlim([-0.2,20.2]);
%Estimated ACF Bartlett
figure;     %38
plot(t,r_ld_es_ba, 'm');
figure;     %39
stem(t(1:20),r_ld_es_ba(1:20), 'b'); xlim([-0.2,20.2]);
%Estimated ACF Blackman
figure;     %40
plot(t,r_ld_es_bl, 'm');
figure;     %41
stem(t(1:20),r_ld_es_bl(1:20), 'b'); xlim([-0.2,20.2]);
%Estimated PSD
figure;     %42
plot(f,R_ld_es, 'c'); xlim([0,1]);
