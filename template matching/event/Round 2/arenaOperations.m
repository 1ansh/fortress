function [bbArena,n,imSeg,centArena] = arenaOperations(im)
rgb1 = get_color(im);
vari = 20;
imSeg = im(:,:,1)<=rgb1(1,1) + vari & im(:,:,1)>=rgb1(1,2) - vari & im(:,:,2)<=rgb1(1,3) + vari & im(:,:,2)>=rgb1(1,4) - vari & im(:,:,3)<=rgb1(1,5) + vari & im(:,:,3)>=rgb1(1,6) - vari;
imSeg = bwmorph(imSeg,'dilate',3);
[imSeg1, n] = bwlabel(imSeg);
bbArena = regionprops(imSeg1,'BoundingBox');
bbArena = cat(1, bbArena.BoundingBox);
centArena = regionprops(imSeg1,'Centroid');
centArena = cat(1, centArena.Centroid);
end

