scr = serial('COM6','BaudRate',9600);                                   %define Serial Communication
fopen(scr);                                                             %open Serial Communication

vid = videoinput('winvideo', 2, 'I420_1024x576'); 
src = getselectedsource(vid);
vid.ReturnedColorspace = 'rgb';
src.Brightness = 50;                                                    %Camera Calibrations
src.Exposure = -7;
src.Gain = 255;
src.Saturation = 213;
src.Sharpness = 170;
src.Contrast = 228;
preview(vid);
pause(1);

im=getsnapshot(vid);
%im=imrotate(im,90);                                                    %rotate Arena image as per requirement
[im]=imcrop(im,rect);                                                   %crop Arena portion

sfactx = 300/rect(1,3);                                                 %factor for x-axis in terms of pixel vs centimeter
sfacty = 250/rect(1,4);                                                 %factor for y-axis in terms of pixel vs centimeter
sfact = [sfactx sfacty];

% [front_rgb, rear_rgb] = get_bot_color(im);
%crop front part and rear part of bot 5 times for different positions
[front_rgb] = get_color(im);
[rear_rgb] = get_color(im);

[bot_ctr,front_ctr] = get_bot_ctr(im, front_rgb, rear_rgb);             %get bot and start centroid
start_ctr = bot_ctr;

[bbArena, totShapeAr,imSegAr, centAr] = arenaOperations(im);            %returns the number of shapes present in the arena and their regionprops
sampIm = imread('fortress1b.jpg');                                      %Read shape sample image
[~, segImSamp, totShapeSamp] = sampOperations(sampIm);                  %returns the number of shapes present in sample image
bbSamp = priorityList(sampIm,totShapeSamp);                             %shape priority list corresponding to color priority list provided
destCoord = [0,0];                                                      %destination Centroid coordinates initializer

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
            ArBound = imresize(ArBound,[200,200]);
            SampBound1 = imresize(SampBound1,[200,200]);
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
destCoord = [destCoord ; start_ctr];
