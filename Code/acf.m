function [acf_estimated] = acf(x)

  %This function estimates the ACF by the Bartlett Method.
  %I use a double loop to apply the formula found in the book.

    N = max(size(x));
    acf_estimated = zeros(1,N);

    for k = -N/2+1:N/2
        s = 0;
        for n = 1:(N-abs(k))
            s = s+x(n+abs(k))*x(n);
        end
        acf_estimated(k+N/2) = s;
        acf_estimated(k+N/2) = acf_estimated(k+N/2)/(N);
    end
end
