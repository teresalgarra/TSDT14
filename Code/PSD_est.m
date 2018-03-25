function [Rx] = PSD_est(x, N)

% x is the stochastic signal in time domain
% N is the number of sample we use for the estimation

x_n = x(1,1:1:N-1); % infinite sequence of samples (book, p.224)

X_n = fft(x_n,N); %DFT of the prepared signal

Rx = 1/N*((abs(X_n).^2)); %PSD

end
