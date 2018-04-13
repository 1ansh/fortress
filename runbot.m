scr = serial('COM6','BaudRate',9600);    %define Serial Communication
fopen(scr);     %open Serial Communication


vid = videoinput('winvideo', 2, 'I420_1024x576');
src = getselectedsource(vid);
vid.ReturnedColorspace = 'rgb';
src.Brightness = 50;

src.Exposure = -7;

src.Gain = 255;

src.Saturation = 213;

src.Sharpness = 170;

src.Contrast = 228;
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
sfacty = 300/rect(1,4);     %factor for y-axis in terms of pixel vs centimeter
sfact = [sfactx sfacty];

[front_rgb, rear_rgb] = get_bot_color(im);
%crop front part and rear part of bot 5 times for different positions
% [front_rgb] = get_color(im);
% [rear_rgb] = get_color(im);

[bot_ctr,front_ctr] = get_bot_ctr(im, front_rgb, rear_rgb);     %get town center centroid viz. bot centroid at start
% town_ctr = bot_ctr;
hold off

% [river_rgb] = get_river_color(im);
[k_river] = extract_color(im,river_rgb);
k_river = imfill(k_river, 'holes');
k_river = bwareaopen(k_river, 20);
% k_river = bwmorph(k_river,'erode', 2);
k_river = bwmorph(k_river,'dilate',15); %Value to be calibarated
imtool(k_river);

[node_array_final,arr] = get_resources(im, town_ctr, sfact,k_river, res_rgb);      %get resource ctr array with resource number


var=1;


RRT_path_struct(length(arr)) = struct('path',[]);
RRT_label = zeros(1,length(arr));
while(var ~= length(node_array_final)+1)
    
    if (~logical(sum(find(arr==node_array_final(var,3))))) || logical(sum(node_array_final(var,3)==0))  % no RRT
        try
            bot_move(front_rgb,rear_rgb,node_array_final(var,:),vid,rect,scr,sfact);     %bot moves to next resource
        catch
            disp('timeout reequired');
            pause(8);
            var = var + 2;
            continue;
        end
        var = var + 1;
        fwrite(scr,'w'); %LED ON
        disp('Blink');
        pause(0.5)
        fwrite(scr,'q'); %LED OFF
    else
        if logical(sum(find(RRT_label == node_array_final(var,3))))
            inn = find(RRT_label == node_array_final(var,3)==1);
            path = RRT_path_struct(inn).path;
            try
                apply_RRT( front_rgb,rear_rgb,path,vid,rect,scr,sfact)%bot moves to next resource
            catch
                disp('timeout required');
                pause(8);
                var = var + 2;
                continue;
            end
            var = var + 2;
        else
            try
                path = call_rrt(1-k_river,[round(town_ctr(2)) round(town_ctr(1))],round(node_array_final(var,2:-1:1)));
            catch
                path = [[round(town_ctr(2)) round(town_ctr(1))] ; round(node_array_final(var,2:-1:1))];
                temp2 = find(node_array_final(:,3)==node_array_final(var,3));
                node_array_final = [node_array_final(1:temp2(2,1)-1,:) ; node_array_final((temp2(2,1)+2):end,:)];
            end
            GG = find(RRT_label == 0);
            RRT_label(1,GG(1,1)) = node_array_final(var,3);
            RRT_path_struct(GG(1,1)).path = path;
            figure;
            try
                apply_RRT( front_rgb,rear_rgb,path,vid,rect,scr,sfact)
            catch
                disp('timeout reequired');
                pause(8);
                var = var + 2;
                continue;
            end
            var = var + 2;
        end
        
    end
end