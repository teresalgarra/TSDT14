function [acf_estimated] = acf(x)

%ACF estimation by the Bartlett Method

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
