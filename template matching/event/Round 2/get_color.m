function[rgb]=get_color(q)
im = imcrop(q);
redmax = max(max(im(:,:,1)));
redmin = min(min(im(:,:,1)));
greenmax = max(max(im(:,:,2)));
greenmin = min(min(im(:,:,2)));
bluemax = max(max(im(:,:,3)));
bluemin = min(min(im(:,:,3)));
rgb = [redmax, redmin, greenmax, greenmin, bluemax, bluemin];
end