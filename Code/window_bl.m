function [y] = window_bl(acf)

N = length(acf);
w = zeros(1,N);
w(ceil((N-100)/2):floor((N+100)/2)) = window(@blackmanharris,100);
y = acf.*w;

end
