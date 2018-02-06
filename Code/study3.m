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

w = linspace(0,1,2^N);
n = linspace(0,2^N,2^N);

%Plot stuff
fh = 0:0.01:99.99;
th = 0:0.01:99.99;
dth = 0.01;

%Theoretical Calculations

%Ideal filter (rectangle)
space = linspace(0,99.99,10000);
H_th = zeros(size(space));
H_th(abs(space)<fch) = 1;
h_th = iift(H_th, 'symmetric');

%Filtered signal
Y_th = X.*H_th;
y_th = ifft(Y_th,'symmetric');

t0 = (2*pi*(wc+0.2));

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
t1=t0/(2*pi);
R_th_am = 1/4*(rectpuls((w-t1)/(2*wc))+rectpuls((w-1-t1)/(2*wc))) + 1/4*(rectpuls((w+t1)/(2*wc))+rectpuls((w-1+t1)/(2*wc)));

%%Estimated functions%%

%10th degree filter
wc = 2*pi*fc;
[b,a] = butter(10,2*wc,'s');
H_es = (polyval(b,fh)./polyval(a,fh));
h_es = iift(H_es, 'symmetric');

%Filtered signal
Y_es = X.*H_es;
y_es = ifft(Y_es,'symmetric');

%Squarer PSD
y_es_sq = y_es.^2;
Y_es_sq = abs(fft(y_es_sq));

r_es_sq_ba = es_bartlett(y_es_sq);
R_es_sq_ba = abs(fft(r_es_sq_ba));

r_es_sq_bl = es_bartlett(y_es_sq);
R_es_sq_bl = abs(fft(r_es_sq_bl));

%Half-Wave Rectifier PSD
y_es_hw = zeros(1,2^N);
Y_es_hw = abs(fft(y_es_hw));

r_es_hw_ba = es_bartlett(y_es_hw);
R_es_hw_ba = abs(fft(r_es_hw_ba));

r_es_hw_bl = es_bartlett(y_es_hw);
R_es_hw_bl = abs(fft(r_es_hw_bl));

%AM-SC Modulator PSD
y_es_am = y_es.*cos(t0*n);
Y_es_am = abs(fft(y_es_am));

r_es_am_ba = es_bartlett(y_es_am);
R_es_am_ba = abs(fft(r_es_am_ba));

r_es_am_bl = es_bartlett(y_es_am);
R_es_am_bl = abs(fft(r_es_am_bl));

%%Smoothed Calculations%%

%Squarer%

%Rectangular window
r_es_sq_re = window_re(r_es_sq);
R_es_sq_re = abs(fft(r_es_sq_re));

r_es_sq_ba_re = window_re(r_es_sq_ba);
R_es_sq_ba_re = abs(fft(r_es_sq_ba_re));

r_es_sq_bl_re = window_re(r_es_sq_bl);
R_es_sq_bl_re = abs(fft(r_es_sq_bl_re));

%Triangular window
r_es_sq_tr = window_tr(r_es_sq);
R_es_sq_tr = abs(fft(r_es_sq_tr));

r_es_sq_ba_tr = window_tr(r_es_sq_ba);
R_es_sq_ba_tr = abs(fft(r_es_sq_ba_tr));

r_es_sq_bl_tr = window_tr(r_es_sq_bl);
R_es_sq_bl_tr = abs(fft(r_es_sq_bl_tr));

%Hamming window
r_es_sq_ha = window_ha(r_es_sq);
R_es_sq_ha = abs(fft(r_es_sq_ha));

r_es_sq_ba_ha = window_ha(r_es_sq_ba);
R_es_sq_ba_ha = abs(fft(r_es_sq_ba_ha));

r_es_sq_bl_ha = window_ha(r_es_sq_bl);
R_es_sq_bl_ha = abs(fft(r_es_sq_bl_ha));

%Bartlett window
r_es_sq_ba = window_ba(r_es_sq);
R_es_sq_ba = abs(fft(r_es_sq_ba));

r_es_sq_ba_ba = window_ba(r_es_sq_ba);
R_es_sq_ba_ba = abs(fft(r_es_sq_ba_ba));

r_es_sq_bl_ba = window_ba(r_es_sq_bl);
R_es_sq_bl_ba = abs(fft(r_es_sq_bl_ba));

%Blackmanharris window
r_es_sq_bl = window_bl(r_es_sq);
R_es_sq_bl = abs(fft(r_es_sq_bl));

r_es_sq_ba_bl = window_bl(r_es_sq_ba);
R_es_sq_ba_bl = abs(fft(r_es_sq_ba_bl));

r_es_sq_bl_bl = window_bl(r_es_sq_bl);
R_es_sq_bl_bl = abs(fft(r_es_sq_bl_bl));

%Half-Wave Rectifier%

%Rectangular window
r_es_hw_re = window_re(r_es_hw);
R_es_hw_re = abs(fft(r_es_hw_re));

r_es_hw_ba_re = window_re(r_es_hw_ba);
R_es_hw_ba_re = abs(fft(r_es_hw_ba_re));

r_es_hw_bl_re = window_re(r_es_hw_bl);
R_es_hw_bl_re = abs(fft(r_es_hw_bl_re));

%Triangular window
r_es_hw_tr = window_tr(r_es_hw);
R_es_hw_tr = abs(fft(r_es_hw_tr));

r_es_hw_ba_tr = window_tr(r_es_hw_ba);
R_es_hw_ba_tr = abs(fft(r_es_hw_ba_tr));

r_es_hw_bl_tr = window_tr(r_es_hw_bl);
R_es_hw_bl_tr = abs(fft(r_es_hw_bl_tr));

%Hamming window
r_es_hw_ha = window_ha(r_es_hw);
R_es_hw_ha = abs(fft(r_es_hw_ha));

r_es_hw_ba_ha = window_ha(r_es_hw_ba);
R_es_hw_ba_ha = abs(fft(r_es_hw_ba_ha));

r_es_hw_bl_ha = window_ha(r_es_hw_bl);
R_es_hw_bl_ha = abs(fft(r_es_hw_bl_ha));

%Bartlett window
r_es_hw_ba = window_ba(r_es_hw);
R_es_hw_ba = abs(fft(r_es_hw_ba));

r_es_hw_ba_ba = window_ba(r_es_hw_ba);
R_es_hw_ba_ba = abs(fft(r_es_hw_ba_ba));

r_es_hw_bl_ba = window_ba(r_es_hw_bl);
R_es_hw_bl_ba = abs(fft(r_es_hw_bl_ba));

%Blackmanharris window
r_es_hw_bl = window_bl(r_es_hw);
R_es_hw_bl = abs(fft(r_es_hw_bl));

r_es_hw_ba_bl = window_bl(r_es_hw_ba);
R_es_hw_ba_bl = abs(fft(r_es_hw_ba_bl));

r_es_hw_bl_bl = window_bl(r_es_hw_bl);
R_es_hw_bl_bl = abs(fft(r_es_hw_bl_bl));

%AM-SC Modulator%

%Rectangular window
r_es_am_re = window_re(r_es_am);
R_es_am_re = abs(fft(r_es_am_re));

r_es_am_ba_re = window_re(r_es_am_ba);
R_es_am_ba_re = abs(fft(r_es_am_ba_re));

r_es_am_bl_re = window_re(r_es_am_bl);
R_es_am_bl_re = abs(fft(r_es_am_bl_re));

%Triangular window
r_es_am_tr = window_tr(r_es_am);
R_es_am_tr = abs(fft(r_es_am_tr));

r_es_am_ba_tr = window_tr(r_es_am_ba);
R_es_am_ba_tr = abs(fft(r_es_am_ba_tr));

r_es_am_bl_tr = window_tr(r_es_am_bl);
R_es_am_bl_tr = abs(fft(r_es_am_bl_tr));

%Hamming window
r_es_am_ha = window_ha(r_es_am);
R_es_am_ha = abs(fft(r_es_am_ha));

r_es_am_ba_ha = window_ha(r_es_am_ba);
R_es_am_ba_ha = abs(fft(r_es_am_ba_ha));

r_es_am_bl_ha = window_ha(r_es_am_bl);
R_es_am_bl_ha = abs(fft(r_es_am_bl_ha));

%Bartlett window
r_es_am_ba = window_ba(r_es_am);
R_es_am_ba = abs(fft(r_es_am_ba));

r_es_am_ba_ba = window_ba(r_es_am_ba);
R_es_am_ba_ba = abs(fft(r_es_am_ba_ba));

r_es_am_bl_ba = window_ba(r_es_am_bl);
R_es_am_bl_ba = abs(fft(r_es_am_bl_ba));

%Blackmanharris window
r_es_am_bl = window_bl(r_es_am);
R_es_am_bl = abs(fft(r_es_am_bl));

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
figure;
plot(w,H_es, 'm');
%Filter absolute value
figure;
plot(w,abs(H_es), 'b');
%Filter in time domain
figure;
plot(t,h_es, 'c');

%Filtered signal
figure;
plot(f,Y_th, 'm');
%Filtered signal absolute value
figure;
plot(f,abs(Y_th), 'b');
%Filtered signal in time domain
figure;
plot(t,y_th, 'c');

%Squarer PSD
figure;
plot(w, R_th_sq, 'm');

%Half-Wave Rectifier PSD
figure;
plot(w, R_th_hw, 'b');

%AM-SC Modulator PSD
figure;
plot(w, R_th_am, 'c');

%%Estimated Calculations%%

%Filtered signal
figure;
plot(f,Y_es), 'm';
%Filtered signal absolute value
figure;
plot(f,abs(Y_es), 'b');
%Filtered signal in time domain
figure;
plot(t,y_es, 'c');
%Squarer signal in time domain
figure;
plot(t,y_es_sq, 'm');
%Half-Wave signal in time domain
figure;
plot(t,y_es_hw, 'b');
%AM_SC Modulator signal in time domain
figure;
plot(t,y_es_am, 'c');

%Squarer PSD
figure;
plot(w, R_es_sq, 'm');
figure;
plot(w, R_es_sq_ba, 'b');
figure;
plot(w, R_es_sq_bl, 'c');

%Half-Wave Rectifier PSD
figure;
plot(w, R_es_hw, 'm');
figure;
plot(w, R_es_hw_ba, 'b');
figure;
plot(w, R_es_hw_bl, 'c');

%AM-SC Modulator PSD
figure;
plot(w, R_es_am, 'm');
figure;
plot(w, R_es_am_ba, 'b');
figure;
plot(w, R_es_am_bl, 'c');

%%Smoothed Calculations%%

%Squarer PSD%

%Rectangular window
figure;
plot(w, R_es_sq_re, 'm');
figure;
plot(w, R_es_sq_ba_re, 'b');
figure;
plot(w, R_es_sq_bl_re, 'c');

%Triangular window
figure;
plot(w, R_es_sq_tr, 'm');
figure;
plot(w, R_es_sq_ba_tr, 'b');
figure;
plot(w, R_es_sq_bl_tr, 'c');

%Hamming window
figure;
plot(w, R_es_sq_ha, 'm');
figure;
plot(w, R_es_sq_ba_ha, 'b');
figure;
plot(w, R_es_sq_bl_ha, 'c');

%Bartlett window
figure;
plot(w, R_es_sq_ba, 'm');
figure;
plot(w, R_es_sq_ba_ba, 'b');
figure;
plot(w, R_es_sq_bl_ba, 'c');

%Blackmanharris window
figure;
plot(w, R_es_sq_bl, 'm');
figure;
plot(w, R_es_sq_ba_bl, 'b');
figure;
plot(w, R_es_sq_bl_bl, 'c');

%Half-Wave Rectifier%

%Rectangular window
figure;
plot(w, R_es_hw_re, 'm');
figure;
plot(w, R_es_hw_ba_re, 'b');
figure;
plot(w, R_es_hw_bl_re, 'c');

%Triangular window
figure;
plot(w, R_es_hw_tr, 'm');
figure;
plot(w, R_es_hw_ba_tr, 'b');
figure;
plot(w, R_es_hw_bl_tr, 'c');

%Hamming window
figure;
plot(w, R_es_hw_ha, 'm');
figure;
plot(w, R_es_hw_ba_ha, 'b');
figure;
plot(w, R_es_hw_bl_ha, 'c');

%Bartlett window
figure;
plot(w, R_es_hw_ba, 'm');
figure;
plot(w, R_es_hw_ba_ba, 'b');
figure;
plot(w, R_es_hw_bl_ba, 'c');

%Blackmanharris window
figure;
plot(w, R_es_hw_bl, 'm');
figure;
plot(w, R_es_hw_ba_bl, 'b');
figure;
plot(w, R_es_hw_bl_bl, 'c');

%AM-SC Modulator%

%Rectangular window
figure;
plot(w, R_es_am_re, 'm');
figure;
plot(w, R_es_am_ba_re, 'b');
figure;
plot(w, R_es_am_bl_re, 'c');

%Triangular window
figure;
plot(w, R_es_am_tr, 'm');
figure;
plot(w, R_es_am_ba_tr, 'b');
figure;
plot(w, R_es_am_bl_tr, 'c');

%Hamming window
figure;
plot(w, R_es_am_ha, 'm');
figure;
plot(w, R_es_am_ba_ha, 'b');
figure;
plot(w, R_es_am_bl_ha, 'c');

%Bartlett window
figure;
plot(w, R_es_am_ba, 'm');
figure;
plot(w, R_es_am_ba_ba, 'b');
figure;
plot(w, R_es_am_bl_ba, 'c');

%Blackmanharris window
figure;
plot(w, R_es_am_bl, 'm');
figure;
plot(w, R_es_am_ba_bl, 'b');
figure;
plot(w, R_es_am_bl_bl, 'c');

%%Historiograms%

%Filtered signal
figure;
hist(y_es, L, 'm');
%Squarer
figure;
hist(y_es_sq, L, 'b');
%Half-Wave Rectifier
figure;
hist(y_es_hw, L, 'c');
%AM_SC Modulator
figure;
hist(y_es_am, L, 'g');
