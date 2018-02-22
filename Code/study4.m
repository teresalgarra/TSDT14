clear;
clc;
close all;

N = 16;
x=randn(1,2^N);
X = (1/N)*fft(x);
Ts = 1;
dt = Ts/2^N;
fs = 1/dt;
Rx = 1;
T = Ts/2^N; %sampling length.
fc  = 1; %Si no funciona algo, igual aquí es 10
wc = 0.1;
fc_hd  = 1;

w = linspace(0,1,2^N);
n = linspace(0,2^N,2^N);

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

%Theoretical PSD
R_th = abs(H_th).^2;

%First System's PSD
R_th_1 = rectpuls((w-1/2)/(2*wc));

%Second System's PSD
R_th_2 = 1/4*(rectpuls((w-1/2)/(2*wc))) + 1/4*(rectpuls(w/(2*wc))+rectpuls((w-1)/(2*wc)));

%%Estimated functions%%

%20th degree filter
wc_hd = 2*pi*fc_hd;
[b,a] = butter(20,2*wc_hd,'s');
H_es = (polyval(b,f)./polyval(a,f));
h_es = ifft(H_hd_es, 'symmetric');

%Filtered signal
Y_es = X.*H_es;
y_es = ifft(Y_es,'symmetric');

%%Results%%
r_es = acf(y_es);
R_es = fft(r_es);

%Systems
s1 = X.*(-1)^(f);


%No sé? Decimar!
sequence = zeros(1,2^N);
sequence(2*f) = 1;
s2 = X.*sequence;

%First System
y_es_1 = y_es.*s1;
Y_es_1 = abs(fft(y_es_1));

r_es_1 = acf(y_es_1);
R_es_1 = abs(fft(r_es_1));

%Second System
y_es_2 = y_es.*s2;
Y_es_2 = abs(fft(y_es_2));

r_es_2 = acf(y_es_2);
R_es_2 = abs(fft(r_es_2));


%%%PLOT ZONE%%%

%%Theoretical Calculations%%

%%Systems%%

%Filter
figure;     %1
plot(w,H_es, 'm');
%Filter absolute value
figure;     %2
plot(w,abs(H_es), 'b');
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

%Initial PSD
figure;     %7
plot(w, R_th, 'm'); xlim([0,1]);

%First System PSD
figure;     %8
plot(w, R_th_1, 'm'); xlim([0,1]);

%Second System PSD
figure;     %9
plot(w, R_th_2, 'b'); xlim([0,1]);

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
%First System in time domain
figure;     %13
plot(t,y_es_1, 'm');
%First System
figure;     %14
plot(t,Y_es_1, 'm');
%First System absolute value
figure;     %15
plot(t,abs(Y_es_1), 'm');
%Second System in time domain
figure;     %16
plot(t,y_es_2, 'm');
%Second System
figure;     %17
plot(t,Y_es_2, 'm');
%Second System absolute value
figure;     %18
plot(t,abs(Y_es_2), 'm');

%First System PSD
figure;     %19
plot(w, R_es_1, 'b'); xlim([0,1]);

%Second System PSD
figure;     %20
plot(w, R_es_2, 'b'); xlim([0,1]);
