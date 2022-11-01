function I_seg = segmentation_image_output (x, y, M, N)
xr = round(x);
yr = round(y);
I_seg = 255 * ones(M, N);
for i = 1 : length(xr)
        I_seg(yr(i), xr(i)) = 0;
end
I_seg = im2bw(I_seg, 0.5);