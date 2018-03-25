function [y] = window_ha(x, input_func)

  %This funtions creates a zeros matrix and places the desired window centeres in the middle.
  %It returns a different result depending on if the specified input is PSD or ACF.

  L = length(x);
  w = zeros(1, L);
  w(1, ceil((L-65)/2):floor((L+65)/2)) = window(@hamming,65);

  if input_func=='acf'
      y = x.*w;
  end

  if input_func=='psd'
      W=1/200.*abs(fft(w));
      y = x.*W;
  end

end
