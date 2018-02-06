function [acf] = es_bartlett(x)

    N = max(size(x));
    acf = zeros(1,N);

    for k = -N/2+1:N/2
        s = 0;
        for n = 1:(N-abs(k))
            s = s+x(n+abs(k))*x(n);
        end
        acf(k+N/2) = s;
        acf(k+N/2) = acf(k+N/2)/(N);
    end
end
