function [y] = window_bl(acf)

L = length(acf);
w = zeros(1, L);
w(1, ceil((L-65)/2):floor((L+65)/2)) = window(@blackmanharris,65);
y = acf.*w;

end
