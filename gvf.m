function [u, v] = gvf (I, mu, dt, tol)
I = double(I);
%%% Edge map: f = (conv(I, laplacian(G)))^2
f = imfilter(I, fspecial('log', [11, 11], 0.2), 'symmetric') .^ 2;
fmin  = min(f(:));
fmax  = max(f(:));
f = (f - fmin) / (fmax - fmin);

%%% Gradient Vector Flow
fx = imfilter(f, -transpose(fspecial('sobel'))/4, 'symmetric');
fy = imfilter(f, -fspecial('sobel')/4, 'symmetric');

% Explicit method: CFL step-size restriction -> r <= 1/4
dx = 1;
dy = 1;
r = mu * dt / (dx * dy);
b = dt * (fx.^2 + fy.^2);
bn = 1 - b;
c1 = b .* fx;
c2 = b .* fy;
u = fx; % u initial condition
v = fy; % v initial condition
emax = 1; % Absolute error
lap = fspecial('laplacian', 0); % Laplacian filter
while emax > tol % error tolerance
    ub = u; % u before
    u = bn .* u + r * imfilter(u, lap, 'symmetric') + c1;
    vb = v; % v before
    v = bn .* v + r * imfilter(v, lap, 'symmetric') + c2;
    emax = max( max(max(abs(u-ub))) , max(max(abs(v-vb))) );
end
mag = sqrt(u.*u + v.*v);
u = u ./ (mag + 1e-10);
v = v ./ (mag + 1e-10);