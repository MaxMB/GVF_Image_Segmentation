function vd = snake_video_writer (a, b, c)

%{
writerObj = VideoWriter('H1_segmentation.avi');
writerObj.FrameRate = 30;
open(writerObj);
%}
%{
frm = getframe(gcf);
im = frm.cdata(70:440, 500:866, :);
writeVideo(writerObj, im);
%}
%close(writerObj);