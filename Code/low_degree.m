%% STUDY 1 %%

clear;
clc;
close all;

%Data
N = 2^16;
x=randn(1,N)*sqrt(10);
X = fft(x, N);
Rx = 10;

%Vectors
Ts = 1;
nn = ((-N)/2)+1:Ts:(N)/2;
ff= linspace(0,1,N);
tt = 0:Ts:(N)-1;
