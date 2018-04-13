function[front_rgb, rear_rgb] = get_bot_color(im,vid,rect)

% im = imread('1.png');
f1 = get_color(im);
r1 = get_color(im);
waitforbuttonpress;

% im = imread('2.png');
im=getsnapshot(vid);
% im=imrotate(im,21);       %rotate Arena image as per requirement
[im]=imcrop(im,rect);       %crop Arena portion
f2 = get_color(im);
r2 = get_color(im);
waitforbuttonpress;

% im = imread('3.png');
im=getsnapshot(vid);
% im=imrotate(im,21);       %rotate Arena image as per requirement
[im]=imcrop(im,rect);       %crop Arena portion
f3 = get_color(im);
r3 = get_color(im);
waitforbuttonpress;

% im = imread('4.png');
im=getsnapshot(vid);
% im=imrotate(im,21);       %rotate Arena image as per requirement
[im]=imcrop(im,rect);       %crop Arena portion
f4 = get_color(im);
r4 = get_color(im);
waitforbuttonpress;

% im = imread('5.png');
im=getsnapshot(vid);
% im=imrotate(im,21);       %rotate Arena image as per requirement
[im]=imcrop(im,rect);       %crop Arena portion
f5 = get_color(im);
r5 = get_color(im);
waitforbuttonpress;

f_var = [f1; f2; f3; f4; f5];
r_var = [r1; r2; r3; r4; r5];
f_var_max = max(f_var);
r_var_max = max(r_var);
f_var_min = min(f_var);
r_var_min = min(r_var);

front_rgb(1:2:5) = f_var_max(1:2:5);
front_rgb(2:2:6) = f_var_min(2:2:6);
rear_rgb(1:2:5) = r_var_max(1:2:5);
rear_rgb(2:2:6) = r_var_min(2:2:6);


end