function [averaged, vector] = averaging_high(y)

  %This function averages the PSD for study 2, using the PSD estimate function
  %within a loop and then scalating it. The value of p is high, so it becomes
  %too distorted and therefore inaccurate.

  N = 2^16;
  p = 2^14;
  n = N/p;

  averaged = zeros(1, n);

  for k=0:1:p-1
     averaged = averaged + PSD_est(y(1, k*n+1 : n+n*k ), n);
  end

  averaged = averaged / p;

  largo = length(averaged);
  vector = linspace(0,1,largo);

end
