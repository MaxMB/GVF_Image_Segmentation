function vector_filed_print (u, v, N, M)
u = flip(u);
v = -flip(v);

figure(3);
quiver(u, v);
axis off;
xlim([1,N]);
ylim([1,M]);