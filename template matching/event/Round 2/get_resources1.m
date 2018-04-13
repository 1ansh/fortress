function[node_array_nrrt,node_array_rrt] = get_resources1(im, town_ctr, sfact)

[rgb] = get_color(im);
[k_res] = extract_color(im,rgb);

[rgb] = get_color(im);
[k_river] = extract_color(im,rgb);
k_river = bwmorph(k_river,'dilate',15);
imtool(k_river)

var = regionprops(k_res, 'Centroid','Area','Perimeter');
temp1 = (([var.Perimeter].^2)./[var.Area])>14;%Value to be calculated
temp1 = find(temp1==1);
% trng = zeros(size(k));
% for i=1:length(temp1)
%     trng = trng + double(k==temp1(1,i));
% end
% sqr1 = logical(k) - logical(trng);
% imtool(sqr1);
% imtool(trng);
res_array(num, 5) = 0;


for i = 1:num
    var_dist = calc_dist(town_ctr, var(i, 1).Centroid, sfact);
    res_array(i, 1) = var(i, 1).Centroid(1);
    res_array(i, 2) = var(i, 1).Centroid(2);
    res_array(i, 3) = var_dist;
    res_array(i, 4) = i;
    if logical(find(temp1==i))
        res_array(i,5) = var_dist/200;
    else
        res_array(i,5) = var_dist/100;
    end
end

node_array_sorted = sortrows(res_array, 5);
node_array_sorted_twice = kron(node_array_sorted, [1;1]);       %double each element
one_sweep = 2*sum(node_array_sorted(:,3));
dist_time = 6; %average distance(cm) in 1sec
one_sweep_time = one_sweep/dist_time;
extra_points = (360-one_sweep_time)*10 + length(temp1)*200 + (num-length(temp1))*100;
reg_points = 0;
cot_dist = 0;
poin = 1;
while(cot_dist<=one_sweep)
    if find(temp1==node_array_sorted_twice(poin,4))
        disp('200')
        reg_points = reg_points + 200;
    else
        disp('100')
        reg_points = reg_points + 100;
    end
    cot_dist = cot_dist + 2*node_array_sorted_twice(poin,3);
    poin = poin+1;
end
if one_sweep_time>=360 || reg_points>extra_points
    max_var = 4*num;
    town_center_ctr_array = imresize(town_ctr, [2*num 2]);    %get 46 x 4 array of centroid
    node_array_final(1:2:max_var - 1, :) = node_array_sorted_twice(:,1:2);
    node_array_final(2:2:max_var, :) = town_center_ctr_array(:,:);
else
    town_center_ctr_array = imresize(town_ctr, [num 2]);    %get 46 x 4 array of centroid
    node_array_final(1:2:(2*num)-1,:) = node_array_sorted(:,1:2);
    node_array_final(2:2:2*num,:) = town_center_ctr_array(:,:);
    node_array_final = [node_array_final ; node_array_final];
end

end


