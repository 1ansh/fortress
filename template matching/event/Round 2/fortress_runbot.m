scr = serial('COM6','BaudRate',9600);    %define Serial Communication
fopen(scr);     %open Serial Communication

vid = videoinput('winvideo', 1, 'MJPG_1280x720');
src = getselectedsource(vid);
vid.ReturnedColorspace = 'rgb';
src.Brightness = 50;

src.Exposure = -7;

src.Gain = 255;

src.Saturation = 213;

src.Sharpness = 170;

src.Contrast = 228;
preview(vid);
pause(1);

im=getsnapshot(vid);
%im=imrotate(im,90);       %rotate Arena image as per requirement
[im]=imcrop(im,rect);       %crop Arena portion


sfactx = 300/rect(1,3);     %factor for x-axis in terms of pixel vs centimeter
sfacty = 250/rect(1,4);     %factor for y-axis in terms of pixel vs centimeter
sfact = [sfactx sfacty];

[front_rgb, rear_rgb] = get_bot_color(im);
%crop front part and rear part of bot 5 times for different positions
% [front_rgb] = get_color(im);
% [rear_rgb] = get_color(im);

[bot_ctr,front_ctr] = get_bot_ctr(im, front_rgb, rear_rgb);     %get town center centroid viz. bot centroid at start
start_ctr = bot_ctr;

[bbArena, totShapeAr,imSegAr, centAr] = arenaOperations(im);
sampIm = imread('fortress1.png'); %Read shape sample image
[~, segImSamp, totShapeSamp] = sampOperations(sampIm);
bbSamp = priorityList(sampIm,totShapeSamp);
destCoord = [0,0]; 

for i = 1 : totShapeSamp
    gotoPrior = Inf;
    valuePrior = Inf;
    for j = 1 : totShapeAr
        SampBound = imcrop(segImSamp , bbSamp(i,:));
        ArBound = imcrop(imSegAr , bbArena(j,:));
        SampBound = imresize(SampBound,size(ArBound));
        subtraction = (ArBound - SampBound);
        value = find(subtraction(:) == 1);
        [value,~] = size(value);
        if(value < valuePrior)
            gotoPrior = j;
            valuePrior = value;
        end
    end
    dest(i) = (gotoPrior);
    destCoord = [destCoord;centAr(gotoPrior,:)];
end
destCoord = destCoord(2:totShapeSamp+1,:);
int k ;
for j = 1:size(destCoord,1);
    bot_move(front_rgb,rear_rgb,destCoord(j),vid,rect,scr,sfact);
    for k = 1:j
        fwrite(scr,'q');
        pause(.6);
        fwrite(scr,'s');
        pause(.6);
    end
end

bot_move(front_rgb,rear_rgb,start_ctr,vid,rect,scr,sfact);