function [y] = window_tr(x, input_func)

L = length(x);
w = zeros(1, L);
w(1, ceil((L-65)/2):floor((L+65)/2)) = window(@triang,65);

if input_func=='acf'
    y = x.*w;
end

if input_func=='psd'
    W=1/200.*abs(fft(w));
    y = x.*W;
end

end
