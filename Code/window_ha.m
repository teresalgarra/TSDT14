function [y] = window_ha(acf)

N = length(acf);
w = zeros(1,N);
w(ceil((N-100)/2):floor((N+100)/2)) = window(@hamming,100);
y = acf.*w;

end
