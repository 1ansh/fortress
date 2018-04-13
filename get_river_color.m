function[river_rgb] = get_river_color(im)

b1 = get_color(im);

b2 = get_color(im);

b3 = get_color(im);

b4 = get_color(im);

b5 = get_color(im);

b_var = [b1; b2; b3; b4; b5];
b_var_max = max(b_var);
b_var_min = min(b_var);

river_rgb(1:2:5) = b_var_max(1:2:5);
river_rgb(2:2:6) = b_var_min(2:2:6);
end