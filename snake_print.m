function snake_print (I, x, y, i)
imshow(I);

if i == 0
    set(gcf, 'Position', get(0, 'Screensize'));
end

hold on;
plot([x, x(1)], [y, y(1)], 'r');
hold off;

title(['GVF image segmentation | Iteration = ' num2str(i)]);

pause(0.001);