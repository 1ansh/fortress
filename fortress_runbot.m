% scr = serial('COM5','BaudRate',9600);    %define Serial Communication
% fopen(scr);     %open Serial Communication
% 
% vid = videoinput('winvideo', 1, 'MJPG_1280x720');
% src = getselectedsource(vid);
% % vid.ReturnedColorspace = 'rgb';
% src.Brightness = 20;
% src.Exposure = -7;
% src.Gain = 220;
% src.Saturation = 255;
% src.Sharpness = 130;
% src.Contrast = 140;
% preview(vid);
% pause(2);

im=getsnapshot(vid);
% im=imrotate(im,-35);       %rotate Arena image as per requirement
[im]=imcrop(im,rect);       %crop Arena portion

% sfactx = 280/rect(1,3);     %factor for x-axis in terms of pixel vs centimeter
% sfacty = 225/rect(1,4);     %factor for y-axis in terms of pixel vs centimeter
% sfact = [sfactx sfacty];

% [front_rgb, rear_rgb] = get_bot_color(im,vid,rect);
% crop front part and rear part of bot 5 times for different positions
% [front_rgb] = get_color(im);
% [rear_rgb] = get_color(im);

[bot_ctr,front_ctr] = get_bot_ctr(im, front_rgb, rear_rgb);     %get start center centroid viz. bot centroid at start
start_ctr = bot_ctr;

% [bbArena, totShapeAr,imSegAr, centAr] = arenaOperations(im);
% sampIm = imread('fortress_t.jpg'); %Read shape sample image
% [~, segImSamp, totShapeSamp] = sampOperations(sampIm);
% bbSamp = priorityList(sampIm,totShapeSamp);
% destCoord = [0,0];
% zx = bwareaopen(imSegAr, 2000);


for i = 1 : totShapeSamp                                                %for each shape present in the sample image
    gotoPrior = Inf;                                                    %variable intializers
    valuePrior(i) = Inf;
    angRot = 0;
    SampBound = imcrop(segImSamp , bbSamp(i,:));                        %crop i'th shape from sample image
    SampBound1 = SampBound;
    while(angRot<=360)                                                  %while the angle of rotation is following condition
        SampBound1 = imrotate(SampBound,angRot);
        SampBound1 = logical(SampBound1);
        bbAfterRot = regionprops(SampBound1,'BoundingBox');
        bbAfterRot = cat(1, bbAfterRot.BoundingBox);
        SampBound1 = imcrop(SampBound1, bbAfterRot(1,:));
        for j = 1 : totShapeAr
            ArBound = imcrop(imSegAr , bbArena(j,:));
            SampBound1 = imresize(SampBound1,size(ArBound));
            SampBound1 = logical(SampBound1);
            ArBound = imresize(ArBound,[300,300]);
            SampBound1 = imresize(SampBound1,[300,300]);
            subtraction = (ArBound - SampBound1);
            subtraction = logical(subtraction);
            value = find(subtraction(:) == 1);
            [value,~] = size(value);
%             disp(value);
            if(value < valuePrior(i))
                gotoPrior = j;
%                 disp(value);
%                 disp(j);
%                 imtool(subtraction);
                valuePrior(i) = value;
            end
        end
        angRot = angRot + 4;
    end
    dest(i) = (gotoPrior);
    destCoord = [destCoord;centAr(gotoPrior,:)];
end
destCoord = destCoord(2:totShapeSamp+1,:); 
destCoord = [ destCoord; start_ctr];

% for i = 1 : totShapeSamp
%     gotoPrior = Inf;
%     valuePrior = Inf;
%     SampBound = imcrop(segImSamp , bbSamp(i,:));
%     for j = 1 : totShapeAr
%         ArBound = imcrop(imSegAr , bbArena(j,:));
%         SampBound1 = imresize(SampBound,size(ArBound));
%         SampBound1 = logical(SampBound1);
%         subtraction = (ArBound - SampBound1);
%         subtraction = logical(subtraction);
%         value = find(subtraction(:) == 1);
%         [value,~] = size(value);
%         if(value < valuePrior)
%             gotoPrior = j;
%             valuePrior = value;
%         end
%     end
%     dest(i) = (gotoPrior);
%     destCoord = [destCoord;centAr(gotoPrior,:)];
% end
% destCoord = destCoord(2:totShapeSamp+1,:);
% destCoord = [destCoord ; start_ctr];
getobstacles
zvar = 26;
cd = bwmorph(ab, 'dilate', zvar);



for j = 1:size(destCoord,1);
    path = [];
    try
        disp(j)
        path = call_rrt(1-(cd),[round(bot_ctr(2)) round(bot_ctr(1))],[round(destCoord(j,2)),round(destCoord(j,1))]);
    catch
        disp('godirect');
        path = destCoord(j,2:-1:1);
    end
    k = size(path,1);
    for k = 1:k
        bot_ctr = bot_move(front_rgb,rear_rgb,path(k,2:-1:1),vid,rect,scr,sfact);
    end
    for z = 1:j
        if(j==size(destCoord,1))
            continue;
        end
        fwrite(scr,'q');
        pause(.6);
        fwrite(scr,'s');
        pause(.6);
    end
end