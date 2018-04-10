function [y_d] = decimate(y)

  %This function decimates a signal for study 4.
  %I create a sequence of zeros and make every other value of this sequence 1.
  %When I multiply it  by the signal, every other value of the signal goes to 0
  %while the rest stay the same.

    N = length(y);
    tt = 1:1:(N/2);
    y_d = zeros(1, N);

    sequence = zeros(1, N);
    sequence(2*tt) = 1;
    y_d = y.*sequence;

end
