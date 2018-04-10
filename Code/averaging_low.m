Ifunction [acf_av] = averaging_low(y, N)

  %This function averages the ACF for study 2, using the ACF estimate function
  %within a loop and then scalating it. I define a zeros matrix and the
  %put the result in the middle of it so I can compare it accurately when
  %I plot it with the rest of averages and with the theoretical result.
  %N is the number of samples.

  %This value of p is lowest, so it's the least accurate. It looks like the
  %periodogram is still raw.

  p = 2^4;
  n = N/p;
  Ts = 1;

  averaged = zeros(1, n);

  for k=0:1:p-1
     averaged = averaged + acf(y(1, k*n+1 : n+n*k ));
  end

  averaged = averaged / p;
  averaged(1,n) = averaged(1,1);

  acf_av = zeros(1, N);
  acf_av((N/2)-n/2+1:(N/2)+n/2)=averaged;

end
