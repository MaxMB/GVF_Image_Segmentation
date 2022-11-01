clear; clc; close;
I = imread('H1_gray.jpg');
%I = imread('GeometricShapes.jpg');
[M, N] = size(I);
I = imnoise(I, 'gaussian', 0, 0.003);
%I = imnoise(I, 'salt & pepper', 0.05);
%I = imnoise(I, 'speckle', 0.01);

%%% GRADIENT VECTOR FLOW
gvf_mu = 0.1;   gvf_dt = 1;   gvf_tol = 1e-3;
[u, v] = gvf (I, gvf_mu, gvf_dt, gvf_tol);
%vector_filed_print (u, v, N, M);

%%% SNAKE INIT
dmin = 0.5;   dmax = 2;
[x, y] = snake_init (M, N, dmin, dmax);
snake_print (I, x, y, 0);

%%% SNAKE DEFORMANTION
alpha = 0.1;   beta = 0.01;   dt = 0.6;   tol = 0.01;   it_max = 300;
[x, y, it] = gvf_snake_segmentation (I, x, y, u, v, alpha, beta, dmin, dmax, dt, M, N, tol, it_max);

%%% OUTPUT IMAGES
Ib = im2bw(I, 0.2);
Is = segmentation_image_output (x, y, M, N);
[ITP, TP, ITN, TN, IFP, FP] = segmentation_accuracy_measures (Ib, Is, M, N);
figure(2), set(gcf, 'Position', get(0, 'Screensize'));
subplot(2,3,1), imshow(I), title('Original image');
subplot(2,3,2), imshow(Ib), title('Binary image');
subplot(2,3,3), imshow(Is), title('Segmented image');
subplot(2,3,4), imshow(ITP), title(['True Positive \Rightarrow TP = ' num2str(TP)]);
subplot(2,3,5), imshow(ITN), title(['True Negative \Rightarrow TN = ' num2str(TN)]);
subplot(2,3,6), imshow(IFP), title(['False Positive \Rightarrow FP = ' num2str(FP)]);