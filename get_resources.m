function[node_array_final,arr] = get_resources(im, town_ctr, sfact, k_river, res_rgb)

% [rgb] = get_color(im);
[k_res] = extract_color(im,res_rgb);
k_res = imfill(k_res,'holes');
k_res = bwareaopen(k_res,15);
% sc = strel('disk',2);
k_res = bwmorph(k_res,'erode', 2);
% k_res = bwmorph(k_res,'dilate',2);

[k_res,num] = bwlabel(k_res);
imtool(k_res)

var = regionprops(k_res, 'Centroid','Area','Perimeter');
temp1 = find([var.Area]<=100); %value to be calibarated
% temp1 = (([var.Perimeter].^2)./[var.Area])>16.5;%Value to be calculated
% temp1 = find(temp1==1);
% trng = zeros(size(k));
% for i=1:length(temp1)
%     trng = trng + double(k==temp1(1,i));
% end
% sqr1 = logical(k) - logical(trng);
% imtool(sqr1);
% imtool(trng);
arr=[];
for i=1:num
    if ~checkPath([round(town_ctr(2)) round(town_ctr(1))],[round(var(i).Centroid(2)) round(var(i).Centroid(1))],1-k_river)
        arr = [arr i];
    end
end
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
    if logical(find(arr==i))
        res_array(i,5) = res_array(i,5) + 100;
    end
end

node_array_sorted = sortrows(res_array, 5);
vv = 3;
if size(node_array_sorted,1)>=3
    if logical(sum(find(temp1==node_array_sorted(1,4)))) && logical(sum(find(temp1==node_array_sorted(2,4))))
        while(logical(sum(find(temp1==node_array_sorted(vv,4)))))
            vv = vv+1;
        end
        temp_arr = node_array_sorted(vv,:);
        node_array_sorted(3:vv,:) = node_array_sorted(2:vv-1,:);
        node_array_sorted(2,:) = temp_arr;
    else if ~logical(sum(find(temp1==node_array_sorted(1,4)))) && ~logical(sum(find(temp1==node_array_sorted(2,4))))
            while(~logical(sum(find(temp1==node_array_sorted(vv,4)))))
                vv = vv + 1;
            end
            temp_arr = node_array_sorted(vv,:);
            node_array_sorted(3:vv,:) = node_array_sorted(2:vv-1,:);
            node_array_sorted(2,:) = temp_arr;
        end
    end
end
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
    town_center_ctr_array = [imresize(town_ctr, [2*num 2]) zeros(2*num,1)];    %get 46 x 4 array of centroid
    clear node_array_final;
    node_array_final(1:2:max_var - 1, :) = [node_array_sorted_twice(:,1:2) node_array_sorted_twice(:,4)];
    node_array_final(2:2:max_var, :) = town_center_ctr_array(:,:);
else
    town_center_ctr_array = [imresize(town_ctr, [num 2]) zeros(num,1)];    %get 46 x 4 array of centroid
    clear node_array_final;
    node_array_final(1:2:(2*num)-1,:) = [node_array_sorted(:,1:2) node_array_sorted(:,4)] ;
    node_array_final(2:2:2*num,:) = town_center_ctr_array(:,:);
    node_array_final = [node_array_final ; node_array_final];
end

end