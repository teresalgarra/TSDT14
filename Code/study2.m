clear;
clc;
close all;

Ts = 1;
N = 16;
dt = Ts/2^N;
fs = 1/dt;
x=randn(1,2^N);
X = (1/N)*fft(x);
Rx = 1;

fc_ld = 0.9;
fc_hd  = 1; %Si no funciona algo, igual aquí es 10

f = linspace(0,Ts,2^N);
t = linspace(0,Ts,2^N);

%Windows
t_w = linspace(0,Ts,65);
w_re = window(@rectwin,65);
w_tr = window(@triang,65);
w_ha = window(@hamming,65);
w_ba = window(@bartlett,65);
w_bl = window(@blackmanharris,65);

%%%HIGH DEGREE FILTER%%%

%%Estimated functions%%

%10th degree filter
wc_hd = 2*pi*fc_hd;
[b,a] = butter(10,2*wc_hd,'s');
H_hd = (polyval(b,f)./polyval(a,f));
h_hd = ifft(H_hd, 'symmetric');

%Final signal
Y_hd = X.*H_hd;
y_hd = ifft(Y_hd,'symmetric');

%%Results%%
r_hd = acf(y_hd);
R_hd = fft(r_hd);

%%Improved functions%%

%%Results%%

%Rectangular window
r_hd_re = window_re(r_hd);
R_hd_re = window_re(R_hd);

%Triangular window
r_hd_tr = window_tr(r_hd);
R_hd_tr = window_tr(R_hd);

%Hamming window
r_hd_ha = window_ha(r_hd);
R_hd_ha = window_ha(R_hd);

%Bartlett window
r_hd_ba = window_ba(r_hd);
R_hd_ba = window_ba(R_hd);

%Blackmanharris window
r_hd_bl = window_bl(r_hd);
R_hd_bl = window_bl(R_hd);

%%%LOW DEGREE FILTER%%%

%%Estimated functions%%

%First order lowpassfilter
wc_ld = 2*pi*fc_ld;
[d,c] = butter(1,2*wc_ld,'s');
H_ld = (polyval(d,f)./polyval(c,f));
h_ld = ifft(H_ld, 'symmetric');

%Final signal
Y_ld = X.*H_ld;
y_ld = ifft(Y_ld,'symmetric');

%Results%
r_ld = acf(y_ld);
R_ld = fft(r_ld);

%%Improved functions%%

%%Results%%

%Rectangular window
r_ld_re = window_re(r_ld);
R_ld_re = window_re(R_ld);

%Triangular window
r_ld_tr = window_tr(r_ld);
R_ld_tr = window_tr(R_ld);

%Hamming window
r_ld_ha = window_ha(r_ld);
R_ld_ha = window_ha(R_ld);

%Bartlett window
r_ld_ba = window_ba(r_ld);
R_ld_ba = window_ba(R_ld);

%Blackmanharris window
r_ld_bl = window_bl(r_ld);
R_ld_bl = window_bl(R_ld);

%%%PLOT ZONE%%%

%%Windows%%

%Rectangular window
figure;     %1
plot(t_w,w_re, 'm');
%Triangular window
figure;     %2
plot(t_w,w_tr, 'b');
%Hamming window
figure;     %3
plot(t_w,w_ha, 'c');
%Bartlett window
figure;     %4
plot(t_w,w_ba, 'g');
%Blackman window
figure;     %5
plot(t_w,w_bl, 'y');

%%High degree filter%%

%Estimations

%Estimated ACF
figure;     %6
plot(t,r_hd, 'm');
figure;     %7
stem(t,r_hd, 'b'); xlim([-20,20]);
%Estimated PSD
figure;     %12
plot(f,R_hd, 'c'); xlim([0,1]);

%Improved functions

%Rectangular window
%Improved ACF
figure;     %13
plot(t, r_hd_re, 'm');
figure;     %14
stem(t,r_hd_re, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %19
plot(f, R_hd_re, 'c'); xlim([0,1]);

%Triangular window
%Improved ACF
figure;     %20
plot(t, r_hd_tr, 'm');
figure;     %21
stem(t,r_hd_tr, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %26
plot(f, R_hd_tr, 'c'); xlim([0,1]);

%Hamming window
%Improved ACF
figure;     %27
plot(t, r_hd_ha, 'm');
figure;     %28
stem(t,r_hd_ha, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %33
plot(f, R_hd_ha, 'c'); xlim([0,1]);

%Bartlett window
%Improved ACF
figure;     %34
plot(t, r_hd_ba, 'm');
figure;     %35
stem(t,r_hd_ba, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %40
plot(f, R_hd_ba, 'c'); xlim([0,1]);

%Blackmanharris window
%Improved ACF
figure;     %41
plot(t, r_hd_bl, 'm');
figure;     %42
stem(t,r_hd_bl, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %47
plot(f, R_hd_bl, 'c'); xlim([0,1]);


%%Low degree filter%%

%Estimations

%Estimated ACF
figure;     %48
plot(t,r_ld, 'm');
figure;     %49
stem(t,r_ld, 'b'); xlim([-20,20]);
%Estimated PSD
figure;     %54
plot(f,R_ld, 'c'); xlim([0,1]);

%Improved functions

%Rectangular window
%Improved ACF
figure;     %55
plot(t, r_ld_re, 'm');
figure;     %56
stem(t,r_ld_re, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %61
plot(f, R_ld_re, 'c'); xlim([0,1]);

%Triangular window
%Improved ACF
figure;     %62
plot(t, r_ld_tr, 'm');
figure;     %63
stem(t,r_ld_tr, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %68
plot(f, R_ld_tr, 'c'); xlim([0,1]);

%Hamming window
%Improved ACF
figure;     %69
plot(t, r_ld_ha, 'm');
figure;     %70
stem(t,r_ld_ha, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %75
plot(f, R_ld_ha, 'c'); xlim([0,1]);

%Bartlett window
%Improved ACF
figure;     %76
plot(t, r_ld_ba, 'm');
figure;     %77
stem(t,r_ld_ba, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %82
plot(f, R_ld_ba, 'c'); xlim([0,1]);

%Blackmanharris window
%Improved ACF
figure;     %83
plot(t, r_ld_bl, 'm');
figure;     %84
stem(t,r_ld_bl, 'b'); xlim([-20,20]);
%Improved PSD
figure;     %89
plot(f, R_ld_bl, 'c'); xlim([0,1]);
