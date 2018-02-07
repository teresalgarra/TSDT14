clear;
clc;
close all;

Ts = 1;
N = 16;
fs = 1/dt;
x=randn(1,2^N);
X = (1/N)*fft(x);
Rx = 1;

fc_ld = 0.9;
fc_hd  = 1; %Si no funciona algo, igual aquí es 10

%Plot stuff for the high degree filter
fh = 0:0.01:99.99;
th = 0:0.01:99.99;
dth = 0.01;

%Plot stuff for the low degree filter
fl = linspace(0,Ts,2^N);
tl = linspace(0,Ts,2^N);
dtl = Ts/2^N;

%Windows
w_re = window(@rectwin,100);
w_tr = window(@triang,100);
w_ha = window(@hamming,100);
w_ba = window(@bartlett,100);
w_bl = window(@blackmanharris,100);

%%%HIGH DEGREE FILTER%%%

%%Estimated functions%%

%10th degree filter
wc_hd = 2*pi*fc_hd;
[b,a] = butter(10,2*wc_hd,'s');
H_hd = (polyval(b,fh)./polyval(a,fh));
h_hd = ifft(H_hd, 'symmetric');

%Final signal
Y_hd = X.*H_hd;
y_hd = ifft(Y_hd,'symmetric');

%%Results%%
R_hd = abs(H_hd).^2 * Rx;
r_hd = ifft(R_hd);

r_hd_ba = es_bartlett(y_hd);
R_hd_ba = fft(r_hd_ba);

r_hd_bl = es_blackman(y_hd);
R_hd_bl = fft(r_hd_bl);

%%Improved functions%%

%%Results%%

%Rectangular window
r_hd_re = window_re(r_hd);
R_hd_re = abs(fft(r_hd_re));

r_hd_ba_re = window_re(r_hd_ba);
R_hd_ba_re = abs(fft(r_hd_ba_re));

r_hd_bl_re = window_re(r_hd_bl);
R_hd_bl_re = abs(fft(r_hd_bl_re));

%Triangular window
r_hd_tr = window_tr(r_hd);
R_hd_tr = abs(fft(r_hd_tr));

r_hd_ba_tr = window_tr(r_hd_ba);
R_hd_ba_tr = abs(fft(r_hd_ba_tr));

r_hd_bl_tr = window_tr(r_hd_bl);
R_hd_bl_tr = abs(fft(r_hd_bl_tr));

%Hamming window
r_hd_ha = window_ha(r_hd);
R_hd_ha = abs(fft(r_hd_ha));

r_hd_ba_ha = window_ha(r_hd_ba);
R_hd_ba_ha = abs(fft(r_hd_ba_ha));

r_hd_bl_ha = window_ha(r_hd_bl);
R_hd_bl_ha = abs(fft(r_hd_bl_ha));

%Bartlett window
r_hd_ba = window_ba(r_hd);
R_hd_ba = abs(fft(r_hd_ba));

r_hd_ba_ba = window_ba(r_hd_ba);
R_hd_ba_ba = abs(fft(r_hd_ba_ba));

r_hd_bl_ba = window_ba(r_hd_bl);
R_hd_bl_ba = abs(fft(r_hd_bl_ba));

%Blackmanharris window
r_hd_bl = window_bl(r_hd);
R_hd_bl = abs(fft(r_hd_bl));

r_hd_ba_bl = window_bl(r_hd_ba);
R_hd_ba_bl = abs(fft(r_hd_ba_bl));

r_hd_bl_bl = window_bl(r_hd_bl);
R_hd_bl_bl = abs(fft(r_hd_bl_bl));

%%%LOW DEGREE FILTER%%%

%%Estimated functions%%

%First order lowpassfilter
wc_ld = 2*pi*fc_ld;
[d,c] = butter(1,2*wc_ld,'s');
H_ld = (polyval(d,fl)./polyval(c,fl));
h_ld = ifft(H_ld, 'symmetric');

%Final signal
Y_ld = X.*H_ld;
y_ld = ifft(Y_ld,'symmetric');

%Results%
R_ld = abs(H_ld).^2 * Rx;
r_ld = ifft(R_ld,'symmetric')/dt;

r_ld_ba = es_bartlett(y_ld);
R_ld_ba = fft(r_ld_ba);

r_ld_bl = es_blackman(y_ld);
R_ld_bl = fft(r_ld_bl);

%%Improved functions%%

%%Results%%

%Rectangular window
r_ld_re = window_re(r_ld);
R_ld_re = abs(fft(r_ld_re));

r_ld_ba_re = window_re(r_ld_ba);
R_ld_ba_re = abs(fft(r_ld_ba_re));

r_ld_bl_re = window_re(r_ld_bl);
R_ld_bl_re = abs(fft(r_ld_bl_re));

%Triangular window
r_ld_tr = window_tr(r_ld);
R_ld_tr = abs(fft(r_ld_tr));

r_ld_ba_tr = window_tr(r_ld_ba);
R_ld_ba_tr = abs(fft(r_ld_ba_tr));

r_ld_bl_tr = window_tr(r_ld_bl);
R_ld_bl_tr = abs(fft(r_ld_bl_tr));

%Hamming window
r_ld_ha = window_ha(r_ld);
R_ld_ha = abs(fft(r_ld_ha));

r_ld_ba_ha = window_ha(r_ld_ba);
R_ld_ba_ha = abs(fft(r_ld_ba_ha));

r_ld_bl_ha = window_ha(r_ld_bl);
R_ld_bl_ha = abs(fft(r_ld_bl_ha));

%Bartlett window
r_ld_ba = window_ba(r_ld);
R_ld_ba = abs(fft(r_ld_ba));

r_ld_ba_ba = window_ba(r_ld_ba);
R_ld_ba_ba = abs(fft(r_ld_ba_ba));

r_ld_bl_ba = window_ba(r_ld_bl);
R_ld_bl_ba = abs(fft(r_ld_bl_ba));

%Blackmanharris window
r_ld_bl = window_bl(r_ld);
R_ld_bl = abs(fft(r_ld_bl));

r_ld_ba_bl = window_bl(r_ld_ba);
R_ld_ba_bl = abs(fft(r_ld_ba_bl));

r_ld_bl_bl = window_bl(r_ld_bl);
R_ld_bl_bl = abs(fft(r_ld_bl_bl));

%%%PLOT ZONE%%%

%%Windows%%

%Rectangular window
figure;     %1
plot(t,w_re, 'm');
%Triangular window
figure;     %2
plot(t,w_tr, 'b');
%Hamming window
figure;     %3
plot(t,w_ha, 'c');
%Bartlett window
figure;     %4
plot(t,w_ba, 'g');
%Blackman window
figure;     %5
plot(t,w_bl, 'y');

%%High degree filter%%

%Estimations

%Estimated ACF
figure;     %6
plot(t,r_hd, 'm');
figure;     %7
stem(t(1:20),r_hd(1:20), 'b'); xlim([-0.2,20.2]);
%Estimated ACF Bartlett
figure;     %8
plot(t,r_hd_ba, 'm');
figure;     %9
stem(t(1:20),r_hd_ba(1:20), 'b'); xlim([-0.2,20.2]);
%Estimated ACF Blackman
figure;     %10
plot(t,r_hd_bl, 'm');
figure;     %11
stem(t(1:20),r_hd_bl(1:20), 'b'); xlim([-0.2,20.2]);
%Estimated PSD
figure;     %12
plot(f,R_hd, 'c'); xlim([0,1]);

%Improved functions

%Rectangular window
%Improved ACF
figure;     %13
plot(r_hd_re, 'm');
figure;     %14
stem(t(1:20),r_hd_re(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Bartlett
figure;     %15
plot(r_hd_ba_re, 'm');
figure;     %16
stem(t(1:20),r_hd_ba_re(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Blackman
figure;     %17
plot(r_hd_bl_re, 'm');
figure;     %18
stem(t(1:20),r_hd_bl_re(1:20), 'b'); xlim([-0.2,20.2]);
%Improved PSD
figure;     %19
plot(R_hd_re, 'c'); xlim([0,1]);

%Triangular window
%Improved ACF
figure;     %20
plot(r_hd_tr, 'm');
figure;     %21
stem(t(1:20),r_hd_tr(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Bartlett
figure;     %22
plot(r_hd_ba_tr, 'm');
figure;     %23
stem(t(1:20),r_hd_ba_tr(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Blackman
figure;     %24
plot(r_hd_bl_tr, 'm');
figure;     %25
stem(t(1:20),r_hd_bl_tr(1:20), 'b'); xlim([-0.2,20.2]);
%Improved PSD
figure;     %26
plot(R_hd_tr, 'c'); xlim([0,1]);

%Hamming window
%Improved ACF
figure;     %27
plot(r_hd_ha, 'm');
figure;     %28
stem(t(1:20),r_hd_ha(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Bartlett
figure;     %29
plot(r_hd_ba_ha, 'm');
figure;     %30
stem(t(1:20),r_hd_ba_ha(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Blackman
figure;     %31
plot(r_hd_bl_ha, 'm');
figure;     %32
stem(t(1:20),r_hd_bl_ha(1:20), 'b'); xlim([-0.2,20.2]);
%Improved PSD
figure;     %33
plot(R_hd_ha, 'c'); xlim([0,1]);

%Bartlett window
%Improved ACF
figure;     %34
plot(r_hd_ba, 'm');
figure;     %35
stem(t(1:20),r_hd_ba(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Bartlett
figure;     %36
plot(r_hd_ba_ba, 'm');
figure;     %37
stem(t(1:20),r_hd_ba_ba(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Blackman
figure;     %38
plot(r_hd_bl_ba, 'm');
figure;     %39
stem(t(1:20),r_hd_bl_ba(1:20), 'b'); xlim([-0.2,20.2]);
%Improved PSD
figure;     %40
plot(R_hd_ba, 'c'); xlim([0,1]);

%Blackmanharris window
%Improved ACF
figure;     %41
plot(r_hd_bl, 'm');
figure;     %42
stem(t(1:20),r_hd_bl(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Bartlett
figure;     %43
plot(r_hd_ba_bl, 'm');
figure;     %44
stem(t(1:20),r_hd_ba_bl(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Blackman
figure;     %45
plot(r_hd_bl_bl, 'm');
figure;     %46
stem(t(1:20),r_hd_bl_bl(1:20), 'b'); xlim([-0.2,20.2]);
%Improved PSD
figure;     %47
plot(R_hd_bl, 'c'); xlim([0,1]);


%%Low degree filter%%

%Estimations

%Estimated ACF
figure;     %48
plot(t,r_ld, 'm');
figure;     %49
stem(t(1:20),r_ld(1:20), 'b'); xlim([-0.2,20.2]);
%Estimated ACF Bartlett
figure;     %50
plot(t,r_ld_ba, 'm');
figure;     %51
stem(t(1:20),r_ld_ba(1:20), 'b'); xlim([-0.2,20.2]);
%Estimated ACF Blackman
figure;     %52
plot(t,r_ld_bl, 'm');
figure;     %53
stem(t(1:20),r_ld_bl(1:20), 'b'); xlim([-0.2,20.2]);
%Estimated PSD
figure;     %54
plot(f,R_ld, 'c'); xlim([0,1]);

%Improved functions

%Rectangular window
%Improved ACF
figure;     %55
plot(r_ld_re, 'm');
figure;     %56
stem(t(1:20),r_ld_re(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Bartlett
figure;     %57
plot(r_ld_ba_re, 'm');
figure;     %58
stem(t(1:20),r_ld_ba_re(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Blackman
figure;     %59
plot(r_ld_bl_re, 'm');
figure;     %60
stem(t(1:20),r_ld_bl_re(1:20), 'b'); xlim([-0.2,20.2]);
%Improved PSD
figure;     %61
plot(R_ld_re, 'c'); xlim([0,1]);

%Triangular window
%Improved ACF
figure;     %62
plot(r_ld_tr, 'm');
figure;     %63
stem(t(1:20),r_ld_tr(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Bartlett
figure;     %64
plot(r_ld_ba_tr, 'm');
figure;     %65
stem(t(1:20),r_ld_ba_tr(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Blackman
figure;     %66
plot(r_ld_bl_tr, 'm');
figure;     %67
stem(t(1:20),r_ld_bl_tr(1:20), 'b'); xlim([-0.2,20.2]);
%Improved PSD
figure;     %68
plot(R_ld_tr, 'c'); xlim([0,1]);

%Hamming window
%Improved ACF
figure;     %69
plot(r_ld_ha, 'm');
figure;     %70
stem(t(1:20),r_ld_ha(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Bartlett
figure;     %71
plot(r_ld_ba_ha, 'm');
figure;     %72
stem(t(1:20),r_ld_ba_ha(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Blackman
figure;     %73
plot(r_ld_bl_ha, 'm');
figure;     %74
stem(t(1:20),r_ld_bl_ha(1:20), 'b'); xlim([-0.2,20.2]);
%Improved PSD
figure;     %75
plot(R_ld_ha, 'c'); xlim([0,1]);

%Bartlett window
%Improved ACF
figure;     %76
plot(r_ld_ba, 'm');
figure;     %77
stem(t(1:20),r_ld_ba(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Bartlett
figure;     %78
plot(r_ld_ba_ba, 'm');
figure;     %79
stem(t(1:20),r_ld_ba_ba(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Blackman
figure;     %80
plot(r_ld_bl_ba, 'm');
figure;     %81
stem(t(1:20),r_ld_bl_ba(1:20), 'b'); xlim([-0.2,20.2]);
%Improved PSD
figure;     %82
plot(R_ld_ba, 'c'); xlim([0,1]);

%Blackmanharris window
%Improved ACF
figure;     %83
plot(r_ld_bl, 'm');
figure;     %84
stem(t(1:20),r_ld_bl(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Bartlett
figure;     %85
plot(r_ld_ba_bl, 'm');
figure;     %86
stem(t(1:20),r_ld_ba_bl(1:20), 'b'); xlim([-0.2,20.2]);
%Improved ACF Blackman
figure;     %87
plot(r_ld_bl_bl, 'm');
figure;     %88
stem(t(1:20),r_ld_bl_bl(1:20), 'b'); xlim([-0.2,20.2]);
%Improved PSD
figure;     %89
plot(R_ld_bl, 'c'); xlim([0,1]);
