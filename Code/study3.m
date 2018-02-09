clear;
clc;
close all;

N = 16;
fs = 1/dt;
x=randn(1,2^N);
X = (1/N)*fft(x);
Rx = 1;
Ts = 1;
T = Ts/2^N; %sampling length.
fc  = 1; %Si no funciona algo, igual aquí es 10
wc = 0.1;

f = linspace(0,Ts,2^N);
t = linspace(0,Ts,2^N);

%Theoretical Calculations

%Ideal filter (rectangle)
space = linspace(0,99.99,10000);
H_th = zeros(size(space));
H_th(abs(space)<fch) = 1;
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
H_es = (polyval(b,fh)./polyval(a,fh));
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

%%Smoothed Calculations%%

%Squarer%

%Rectangular window
r_es_sq_ba_re = window_re(r_es_sq_ba);
R_es_sq_ba_re = abs(fft(r_es_sq_ba_re));

r_es_sq_bl_re = window_re(r_es_sq_bl);
R_es_sq_bl_re = abs(fft(r_es_sq_bl_re));

%Triangular window
r_es_sq_ba_tr = window_tr(r_es_sq_ba);
R_es_sq_ba_tr = abs(fft(r_es_sq_ba_tr));

r_es_sq_bl_tr = window_tr(r_es_sq_bl);
R_es_sq_bl_tr = abs(fft(r_es_sq_bl_tr));

%Hamming window
r_es_sq_ba_ha = window_ha(r_es_sq_ba);
R_es_sq_ba_ha = abs(fft(r_es_sq_ba_ha));

r_es_sq_bl_ha = window_ha(r_es_sq_bl);
R_es_sq_bl_ha = abs(fft(r_es_sq_bl_ha));

%Bartlett window
r_es_sq_ba_ba = window_ba(r_es_sq_ba);
R_es_sq_ba_ba = abs(fft(r_es_sq_ba_ba));

r_es_sq_bl_ba = window_ba(r_es_sq_bl);
R_es_sq_bl_ba = abs(fft(r_es_sq_bl_ba));

%Blackmanharris window
r_es_sq_ba_bl = window_bl(r_es_sq_ba);
R_es_sq_ba_bl = abs(fft(r_es_sq_ba_bl));

r_es_sq_bl_bl = window_bl(r_es_sq_bl);
R_es_sq_bl_bl = abs(fft(r_es_sq_bl_bl));

%Half-Wave Rectifier%

%Rectangular window
r_es_hw_ba_re = window_re(r_es_hw_ba);
R_es_hw_ba_re = abs(fft(r_es_hw_ba_re));

r_es_hw_bl_re = window_re(r_es_hw_bl);
R_es_hw_bl_re = abs(fft(r_es_hw_bl_re));

%Triangular window
r_es_hw_ba_tr = window_tr(r_es_hw_ba);
R_es_hw_ba_tr = abs(fft(r_es_hw_ba_tr));

r_es_hw_bl_tr = window_tr(r_es_hw_bl);
R_es_hw_bl_tr = abs(fft(r_es_hw_bl_tr));

%Hamming window
r_es_hw_ba_ha = window_ha(r_es_hw_ba);
R_es_hw_ba_ha = abs(fft(r_es_hw_ba_ha));

r_es_hw_bl_ha = window_ha(r_es_hw_bl);
R_es_hw_bl_ha = abs(fft(r_es_hw_bl_ha));

%Bartlett window
r_es_hw_ba_ba = window_ba(r_es_hw_ba);
R_es_hw_ba_ba = abs(fft(r_es_hw_ba_ba));

r_es_hw_bl_ba = window_ba(r_es_hw_bl);
R_es_hw_bl_ba = abs(fft(r_es_hw_bl_ba));

%Blackmanharris window
r_es_hw_ba_bl = window_bl(r_es_hw_ba);
R_es_hw_ba_bl = abs(fft(r_es_hw_ba_bl));

r_es_hw_bl_bl = window_bl(r_es_hw_bl);
R_es_hw_bl_bl = abs(fft(r_es_hw_bl_bl));

%AM-SC Modulator%

%Rectangular window
r_es_am_ba_re = window_re(r_es_am_ba);
R_es_am_ba_re = abs(fft(r_es_am_ba_re));

r_es_am_bl_re = window_re(r_es_am_bl);
R_es_am_bl_re = abs(fft(r_es_am_bl_re));

%Triangular window
r_es_am_ba_tr = window_tr(r_es_am_ba);
R_es_am_ba_tr = abs(fft(r_es_am_ba_tr));

r_es_am_bl_tr = window_tr(r_es_am_bl);
R_es_am_bl_tr = abs(fft(r_es_am_bl_tr));

%Hamming window
r_es_am_ba_ha = window_ha(r_es_am_ba);
R_es_am_ba_ha = abs(fft(r_es_am_ba_ha));

r_es_am_bl_ha = window_ha(r_es_am_bl);
R_es_am_bl_ha = abs(fft(r_es_am_bl_ha));

%Bartlett window
r_es_am_ba_ba = window_ba(r_es_am_ba);
R_es_am_ba_ba = abs(fft(r_es_am_ba_ba));

r_es_am_bl_ba = window_ba(r_es_am_bl);
R_es_am_bl_ba = abs(fft(r_es_am_bl_ba));

%Blackmanharris window
r_es_am_ba_bl = window_bl(r_es_am_ba);
R_es_am_ba_bl = abs(fft(r_es_am_ba_bl));

r_es_am_bl_bl = window_bl(r_es_am_bl);
R_es_am_bl_bl = abs(fft(r_es_am_bl_bl));

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

%%Smoothed Calculations%%

%Squarer PSD%

%Rectangular window
figure;     %22
plot(f, R_es_sq_ba_re, 'm'); xlim([0,1]);
figure;     %23
plot(f, R_es_sq_bl_re, 'b'); xlim([0,1]);

%Triangular window
figure;     %24
plot(f, R_es_sq_ba_tr, 'm'); xlim([0,1]);
figure;     %25
plot(f, R_es_sq_bl_tr, 'b'); xlim([0,1]);

%Hamming window
figure;     %26
plot(f, R_es_sq_ba_ha, 'm'); xlim([0,1]);
figure;     %27
plot(f, R_es_sq_bl_ha, 'b'); xlim([0,1]);

%Bartlett window
figure;     %28
plot(f, R_es_sq_ba_ba, 'm'); xlim([0,1]);
figure;     %29
plot(f, R_es_sq_bl_ba, 'b'); xlim([0,1]);

%Blackmanharris window
figure;     %30
plot(f, R_es_sq_ba_bl, 'm'); xlim([0,1]);
figure;     %31
plot(f, R_es_sq_bl_bl, 'b'); xlim([0,1]);

%Half-Wave Rectifier%

%Rectangular window
figure;     %32
plot(f, R_es_hw_ba_re, 'm'); xlim([0,1]);
figure;     %33
plot(f, R_es_hw_bl_re, 'b'); xlim([0,1]);

%Triangular window
figure;     %34
plot(f, R_es_hw_ba_tr, 'm'); xlim([0,1]);
figure;     %35
plot(f, R_es_hw_bl_tr, 'b'); xlim([0,1]);

%Hamming window
figure;     %36
plot(f, R_es_hw_ba_ha, 'm'); xlim([0,1]);
figure;     %37
plot(f, R_es_hw_bl_ha, 'b'); xlim([0,1]);

%Bartlett window
figure;     %38
plot(f, R_es_hw_ba_ba, 'm'); xlim([0,1]);
figure;     %39
plot(f, R_es_hw_bl_ba, 'b'); xlim([0,1]);

%Blackmanharris window
figure;     %40
plot(f, R_es_hw_ba_bl, 'm'); xlim([0,1]);
figure;     %41
plot(f, R_es_hw_bl_bl, 'b'); xlim([0,1]);

%AM-SC Modulator%

%Rectangular window
figure;     %42
plot(f, R_es_am_ba_re, 'm'); xlim([0,1]);
figure;     %43
plot(f, R_es_am_bl_re, 'b'); xlim([0,1]);

%Triangular window
figure;     %44
plot(f, R_es_am_ba_tr, 'm'); xlim([0,1]);
figure;     %45
plot(f, R_es_am_bl_tr, 'b'); xlim([0,1]);

%Hamming window
figure;     %46
plot(f, R_es_am_ba_ha, 'm'); xlim([0,1]);
figure;     %47
plot(f, R_es_am_bl_ha, 'b'); xlim([0,1]);

%Bartlett window
figure;     %48
plot(f, R_es_am_ba_ba, 'm'); xlim([0,1]);
figure;     %49
plot(f, R_es_am_bl_ba, 'b'); xlim([0,1]);

%Blackmanharris window
figure;     %50
plot(f, R_es_am_ba_bl, 'm'); xlim([0,1]);
figure;     %51
plot(f, R_es_am_bl_bl, 'b'); xlim([0,1]);

%%Historiograms%

%Filtered signal
figure;     %52
hist(y_es, L, 'm');
%Squarer
figure;     %53
hist(y_es_sq, L, 'b');
%Half-Wave Rectifier
figure;     %54
hist(y_es_hw, L, 'c');
%AM_SC Modulator
figure;     %55
hist(y_es_am, L, 'g');
