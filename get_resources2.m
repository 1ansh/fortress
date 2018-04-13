function[node_array_final,max_RRT] = get_resources(im, town_ctr, sfact,river_map)




[rgb] = get_color(im);
[k_res] = extract_color(im,rgb);



[k, num] = bwlabel(k_res);
imtool(k)
var = regionprops(k, 'Centroid','Area','Perimeter');
temp1 = (([var.Perimeter].^2)./[var.Area])>14;%Value to be calculated
temp1 = find(temp1==1);
% trng = zeros(size(k));
% for i=1:length(temp1)
%     trng = trng + double(k==temp1(1,i));
% end
% sqr1 = logical(k) - logical(trng);
% imtool(sqr1);
% imtool(trng);
% res_array_noRRT(num, 7) = 0;
% res_array_RRT(num, 7) = 0;


 j = 0;
 k = 0;
for i = 1:num
    tempx = var(i,1).Centroid(1);
    tempy = var(i,1).Centroid(2);
   
    if checkPath(round([tempx,tempy]),round(town_ctr),1-river_map)
        j = j+1;
        var_dist = calc_dist(town_ctr, var(i, 1).Centroid, sfact);
        res_array_noRRT(j, 1) = var(i, 1).Centroid(1);
        res_array_noRRT(j, 2) = var(i, 1).Centroid(2);
        res_array_noRRT(j, 3) = var_dist;
        res_array_noRRT(j, 4) = i;
        res_array_noRRT(j, 7) = 1;     %NORRT
        if logical(find(temp1==i))
            res_array_noRRT(j,5) = var_dist/200; 
            res_array_noRRT(j,6) = 1;  %triangle
        else
            res_array_noRRT(j,5) = var_dist/100;
            res_array_noRRT(j,6) = 0;  %square
        end
        
        
    else
        k = k+1;
        var_dist = calc_dist(town_ctr, var(i, 1).Centroid, sfact);
        res_array_RRT(k, 1) = var(i, 1).Centroid(1);
        res_array_RRT(k, 2) = var(i, 1).Centroid(2);
        res_array_RRT(k, 3) = var_dist;
        res_array_RRT(k, 4) = i;
        res_array_RRT(k, 7) = 0;    %RRT
        
        if logical(find(temp1==i))
            res_array_RRT(k,5) = var_dist/200;
            res_array_RRT(k,6) = 1;   %triangle
            
        else
            res_array_RRT(k,5) = var_dist/100;
            res_array_RRT(k,6)=0;    %square
        end
        
        
        
    end
    
    
    
        
end

node_array_sorted_noRRT = sortrows(res_array_noRRT, 5);
node_array_sorted_RRT = sortrows(res_array_RRT, 5);
max_RRT = length(node_arrya_sorted_RRT);
array_sorted = [node_array_sorted_noRRT;node_array_sorted_RRT];
triangle=0;
square=0;
for i= 1:size(array_sorted)
    if(triangle==0 && array_sorted(i,6)==1)
       node_first_triangle=array_sorted(i,:);
       i_triangle = i;
       triangle =1;
    else if (square==0 && array_sorted(i,6)==0)
       node_first_square=array_sorted(i,:);
       i_square = i;
       square =1;
        end
    end
end
soln=[i_triangle;i_square];

array_sorted(soln,:) = [];
node_array_sorted = [node_first_triangle;node_first_square;array_sorted];    


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
    town_center_ctr_array = imresize(town_ctr,1, [2*num 2]);    %get 46 x 4 array of centroid
    node_array_final(1:2:max_var - 1, :) = node_array_sorted_twice(:,1:2);
    node_array_final(2:2:max_var, :) = town_center_ctr_array(:,:);
    
else
    town_center_ctr_array = imresize(town_ctr, [num 2]);    %get 46 x 4 array of centroid
    node_array_final(1:2:(2*num)-1,:) = node_array_sorted(:,1:2);
    node_array_final(2:2:2*num,:) = town_center_ctr_array(:,:);
    node_array_final = [node_array_final ; node_array_final];
    
end

end





