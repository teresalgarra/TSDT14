function [y] = window_re(acf)

N = length(acf);
w = zeros(1,N);
w(ceil((N-100)/2):floor((N+100)/2)) = window(@rectwin,100);
y = acf.*w;

end
