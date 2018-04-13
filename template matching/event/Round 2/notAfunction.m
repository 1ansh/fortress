function[x] = notAfunction()
try
    qw = imread('1.jpg');
    qw = imread('2.jpg');
    qw = rgb2hsv(qw);
    imshow(qw);
    
    x= notARealFunction();
catch
notAfunction()
end