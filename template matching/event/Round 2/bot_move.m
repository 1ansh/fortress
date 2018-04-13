function[]=bot_move(front_rgb,rear_rgb,nxt_node_ctr,vid,rect,scr,sfact)
while(1)
    
     im=getsnapshot(vid);
%   im=imrotate(im,90);
%     
%       im = imread('w.png');
    im=imcrop(im,rect);
%     [bot_ctr,front_ctr] = get_bot_ctr(im, front_rgb, rear_rgb);
    
    
     try
         [bot_ctr,front_ctr] = get_bot_ctr(im, front_rgb, rear_rgb);
     catch
         bot_move(front_rgb,rear_rgb,nxt_node_ctr,vid,rect,scr,sfact);
         break;
     end
     plot(nxt_node_ctr(1),nxt_node_ctr(2),'b*');
     hold off
    a=complex(front_ctr(1)-bot_ctr(1),front_ctr(2)-bot_ctr(2));       %bot vector
    b=complex(nxt_node_ctr(1)-bot_ctr(1),nxt_node_ctr(2)-bot_ctr(2));     %bot and node vector
    k=angle(b/a)*180/pi;        %angle between both vectors
    d=calc_dist(bot_ctr, nxt_node_ctr, sfact);   %distance in cm between bot and node
    if d<=5
        break;
    end
    bot_orient(k,d,scr);
%      break;
end
end