function [Rx] = PSD_est(x, N)

  %The functions estimates the PSD.
  %x is the stochastic signal in time domain, and N is the number of sample we use for the estimation

  x_n = x(1,1:1:N-1); %Infinite sequence of samples (book, p.224)

  X_n = fft(x_n,N); %DFT of the prepared signal

  Rx = 1/N*((abs(X_n).^2)); %PSD

end
