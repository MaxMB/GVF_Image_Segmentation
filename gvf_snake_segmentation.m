function [x, y, it] = gvf_snake_segmentation (I, x, y, u, v, alpha, beta, dmin, dmax, dt, M, N, tol, it_max)
dE = 1; % energy relative difference
it = 0; % iteration
while (dE > tol / 100) && (it < it_max)
    [x, y, E] = snake_deform (x, y, u, v, alpha, beta, dt, M, N);
    [x, y] = snake_interp (x, y, dmin, dmax);
    if it > 0
        dE = abs(1 - Eb/E);
    end
    Eb = E;
    it = it + 1;
    snake_print (I, x, y, it);
end