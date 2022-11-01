function [x, y] = snake_init (M, N, dmin, dmax)
cx = floor(N / 2); % image x center
cy = floor(M / 2); % image y center
rho = min(cx, cy) - 3; % radius

d = (dmax + dmin) / 2; % mean distance
as = acos(1 - (d/rho)^2 / 2); % angle step
ang = -(0 : as : 2*pi - as); % angles in clockwise

x = cx + rho * cos(ang); % x coord points 
y = cy + rho * sin(ang); % y coord points 