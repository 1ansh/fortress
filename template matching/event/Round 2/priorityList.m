function [bbSamp] = priorityList(im, n)
bbSamp = [0,0,0,0];
for i=1:n
    rgb1 = get_color(im);
    vari = 20;
    imSeg = im(:,:,1)<=rgb1(1,1) + vari & im(:,:,1)>=rgb1(1,2) - vari & im(:,:,2)<=rgb1(1,3) + vari & im(:,:,2)>=rgb1(1,4) - vari & im(:,:,3)<=rgb1(1,5) + vari & im(:,:,3)>=rgb1(1,6) - vari;
    imSeg = bwmorph(imSeg,'erode',3);
    imSeg = bwmorph(imSeg,'dilate',5);
    imSeg = bwlabel(imSeg);
    ar = regionprops(imSeg,'Area');
    ar = cat(1,ar.Area);
    maxar = max(max(ar));
    imSeg = bwareaopen(imSeg , maxar-100);
    imtool(imSeg);
    bb = regionprops(imSeg,'BoundingBox');
    bb = cat(1, bb.BoundingBox);
    bbSamp = [bbSamp;bb];
%     bbSamp
end
bbSamp = bbSamp(2:n+1,:);
end

