function[bot_ctr,front_ctr] = get_bot_ctr(im,front_rgb,rear_rgb)
[bw1] = extract_color(im,front_rgb);
bw1 = bwmorph(bw1,'erode',2);
bw1 = bwmorph(bw1,'dilate',2);
bw1=bwareaopen(bw1,10);
% imshow(bw1)

[bw2] = extract_color(im,rear_rgb);
bw2 = bwmorph(bw2,'erode',2);
bw2 = bwmorph(bw2,'dilate',2);
bw2=bwareaopen(bw2,10);
% imshow(bw2)

r1=regionprops(bw1,'Centroid');
front_ctr = [r1.Centroid];      %front centroid 
    
    
r2=regionprops(bw2,'Centroid');
rear_ctr = [r2.Centroid];        %rear centroid 

    
bot_ctr = (front_ctr+rear_ctr)./2;    %bot centroid y co-ordinate

imshow(im)
hold on
plot(front_ctr(1),front_ctr(2),'ro');
plot(bot_ctr(1),bot_ctr(2),'r*');
end