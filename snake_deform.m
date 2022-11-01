function [x, y, E] = snake_deform (x, y, u, v, alpha, beta, dt, M, N)
% alpha: elasticity parameter
% beta:  rigidity parameter
% gamma: viscosity parameter
% u & v: external force field

n = length(x);
u = interp2(u, x, y, 'linear');
v = interp2(v, x, y, 'linear');

x_b1 = x([n, 1:n-1]);      % x[n-1]
x_b2 = x([n-1, n, 1:n-2]); % x[n-2]
x_a1 = x([2:n, 1]);        % x[n+1]
x_a2 = x([3:n, 1, 2]);     % x[n+2]
dx2 = x_b1 - 2*x + x_a1; % ~ x''(s)
dx4 = x_b2 - 4*x_b1 + 6*x - 4*x_a1 + x_a2; % ~ x''''(s)
x = x + dt * (alpha*dx2 - beta*dx4 + u);

y_b1 = y([n, 1:n-1]);      % y[n-1]
y_b2 = y([n-1, n, 1:n-2]); % y[n-2]
y_a1 = y([2:n, 1]);        % y[n+1]
y_a2 = y([3:n, 1, 2]);     % y[n+2]
dy2 = y_b1 - 2*y + y_a1; % ~ y''(s)
dy4 = y_b2 - 4*y_b1 + 6*y - 4*y_a1 + y_a2; % ~ y''''(s)
y = y + dt * (alpha*dy2 - beta*dy4 + v);

% Image size limits
for i = 1 : n
    if x(i) < 1
        x(i) = 1;
    elseif x(i) > N
        x(i) = N;
    end
    if y(i) < 1
        y(i) = 1;
    elseif y(i) > M
        y(i) = M;
    end
end

% Energy
dx1 = x_a1 - x_b1; % ~ x'(s)
dy1 = y_a1 - y_b1; % ~ y'(s)
E = 0.5 * (alpha * sum(sqrt(dx1.^2 + dy1.^2)) + beta * sum(sqrt(dx2.^2 + dy2.^2))) + sum(u) + sum(v);