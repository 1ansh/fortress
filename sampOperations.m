function [bbSamp,imSeg,totNum] = sampOperations(im)
rgb1 = get_color(im);
vari = 20;
imSeg = im(:,:,1)<=rgb1(1,1) + vari & im(:,:,1)>=rgb1(1,2) - vari & im(:,:,2)<=rgb1(1,3) + vari & im(:,:,2)>=rgb1(1,4) - vari & im(:,:,3)<=rgb1(1,5) + vari & im(:,:,3)>=rgb1(1,6) - vari;
% imSeg = bwmorph(imSeg,'dilate',3);
imSeg = 1 - imSeg;
imSeg = bwareaopen(imSeg, 800);
imSeg = im2bw(imSeg);
[imSeg1 ,totNum] = bwlabel(imSeg);
imtool(imSeg1);
bbSamp = regionprops(imSeg1,'BoundingBox');
bbSamp = cat(1, bbSamp.BoundingBox);
end