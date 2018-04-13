function [k] = extract_color(q,rgb)

clr_var = 20;
k = q(:,:,1)<=rgb(1,1)+clr_var & q(:,:,1)>=rgb(1,2)-clr_var & q(:,:,2)<=rgb(1,3)+clr_var & q(:,:,2)>=rgb(1,4)-clr_var & q(:,:,3)>=rgb(1,6)-clr_var & q(:,:,3)<=rgb(1,5)+clr_var;
imshow(k)

end