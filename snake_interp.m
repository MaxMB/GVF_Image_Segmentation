function [xf, yf] = snake_interp (x, y, dmin, dmax)
% -> Mark points that are too close from each other for removal and 
%    calculate how many interpolation points between points that are
%    too far away from each other
n = length(x);
xr = x(1); % x reference
yr = y(1); % y reference
idx_min = zeros(1, n); % Mark points that are too close
idx_max = zeros(1, n+1); % Number of points to add between points
count_min = 0; % Counts points to remove
for i = 2 : n
	d = ((x(i)-xr)^2 + (y(i)-yr)^2) ^ 0.5;
    if d < dmin
        idx_min(i) = 1;
        count_min = count_min + 1;
    else
        xr = x(i); yr = y(i); % Reference
        if d > dmax % Number of points to add between
            idx_max(i) = floor(d / dmax);
        end
    end
end
% Dealing with the end of the snake
d = ((x(1)-xr)^2 + (y(1)-yr)^2) ^ 0.5;
if d < dmin % Removal
    % Find the position of the current reference
    k = n;
    while idx_min(k) == 1
        k = k - 1;
    end
    % Mark it for removal
    idx_min(k) = 1;
    idx_max(k) = 0;
    count_min = count_min + 1;
    % Find the position of the previous reference
    k = k - 1;
    while idx_min(k) == 1
        k = k - 1;
    end
    % Mark how many interpolation points until to the end
    xr = x(k); yr = y(k); % reference
    d = ((x(1)-xr)^2 + (y(1)-yr)^2) ^ 0.5;
    idx_max(n+1) = floor(d / dmax);
elseif d > dmax % Interpolation
    idx_max(n+1) = floor(d / dmax);
end

% -> Remove points that are too close and interpolate points that are
%    too far away from each other
nf = n - count_min + sum(idx_max);
xf = zeros(1, nf); xf(1) = x(1); % x output
yf = zeros(1, nf); yf(1) = y(1); % y output
pos = 2; % Current posion of the output vectors
for i = 2 : n
    if idx_min(i) == 0 % This point isn't for removal
        nm = idx_max(i); % Number of points for interpolations
        if nm > 0 % LINEAR interpolation
            dx = (x(i) - xf(pos-1)) / (nm + 1); % x step
            dy = (y(i) - yf(pos-1)) / (nm + 1); % y step
            for j = (0 : nm-1) + pos % Fill with the interpolation
                xf(j) = xf(j-1) + dx;
                yf(j) = yf(j-1) + dy;
            end
            pos = pos + nm;
        end
        xf(pos) = x(i);
        yf(pos) = y(i);
        pos = pos + 1;
    end
end
% Dealing with the end of the snake
nm = idx_max(n+1);
if nm > 0 % linear interpolation
    dx = (x(1) - xf(pos-1)) / (nm + 1);
    dy = (y(1) - yf(pos-1)) / (nm + 1);
    for j = (0 : nm-1) + pos
        xf(j) = xf(j-1) + dx;
        yf(j) = yf(j-1) + dy;
    end
end