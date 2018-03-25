function [averaged, vector] = averaging_medium(y)

  %This function averages the PSD for study 2, using the PSD estimate function
  %within a loop and then scalating it. The value of p is medium, so it's more
  %accurate than both the low and the high values.

  N = 2^16;
  p = 2^8;
  n = N/p;

  averaged = zeros(1, n);

  for k=0:1:p-1
     averaged = averaged + PSD_est(y(1, k*n+1 : n+n*k ), n);
  end

  averaged = averaged / p;

  largo = length(averaged);
  vector = linspace(0,1,largo);

end
