function [y] = window_ba(x)

  %This funtions creates a zeros matrix and places the Bartlett window
  %centered in the middle. It returns the correct result only for ACF.

  L = length(x);
  w = zeros(1, L);
  w(1, ceil((L-65)/2):floor((L+65)/2)) = window(@bartlett,65);

  y = x.*w;

end
