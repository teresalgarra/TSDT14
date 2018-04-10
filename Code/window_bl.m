function [y] = window_bl(x)

  %This funtions creates a zeros matrix and places the Blackman-Harris window
  %centered in the middle. It returns the correct result only for ACF.

  L = length(x);
  w = zeros(1, L);
  w(1, ceil((L-65)/2):floor((L+65)/2)) = window(@blackmanharris,65);

  y = x.*w;

end
