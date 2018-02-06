function [y] = window_tr(acf)

N = length(acf);
w = zeros(1,N);
w(ceil((N-100)/2):floor((N+100)/2)) = window(@triang,100);
y = acf.*w;

end
