% scr = serial('COM6','BaudRate',9600);    %define Serial Communication
% fopen(scr);     %open Serial Communication


vid = videoinput('winvideo', 1, 'MJPG_1280x720');
src = getselectedsource(vid);
% vid.ReturnedColorspace = 'rgb';
% src = getselectedsource(vid);
% src.Brightness= ;
% src.Contrast= ;
% src.Exposure= ;
% src.Gain= ;
% src.Sharpness= ;
% src.Saturation= ;
% src.WhiteBalance= ;
preview(vid);
pause(1);

im=getsnapshot(vid);
%im=imrotate(im,90);       %rotate Arena image as per requirement
[im]=imcrop(im,rect);       %crop Arena portion


sfactx = 300/rect(1,3);     %factor for x-axis in terms of pixel vs centimeter
sfacty = 240/rect(1,4);     %factor for y-axis in terms of pixel vs centimeter
sfact = [sfactx sfacty];

%crop front part and rear part of bot 5 times for different positions
[front_rgb, rear_rgb] = get_bot_color(im);
% [front_rgb] = get_color(im);
% [rear_rgb] = get_color(im);

[bot_ctr,front_ctr] = get_bot_ctr(im, front_rgb, rear_rgb);     %get town center centroid viz. bot centroid at start
start_ctr = bot_ctr;
hold off




