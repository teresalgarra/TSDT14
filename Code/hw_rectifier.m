function [y_hw] = hw_rectifier(y, N)

  %This function is a half-wave rectifier filter for study 3.
  %I create a sequence of zeros and, with a loop and a conditional statment,
  %make every negative value 0. The rest, that is, positive values, stay the same.

    y_hw = zeros(1, N);

    for i=1:1:N
        if y(1,i)<0
            y_hw(1,i)= 0;
        else
            y_hw(1, i) = y(1,i);
        end
    end

end
