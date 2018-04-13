function [] = apply_RRT( front_rgb,rear_rgb,path,vid,rect,scr,sfact)



nod=1;
while(nod ~= size(path,1)+1)
%     bot_move(front_rgb,rear_rgb,path(nod,2:-1:1),vid,rect,scr,sfact);  %bot moves to next node
    bot_move(front_rgb,rear_rgb,path(nod,:),vid,rect,scr,sfact);  %bot moves to next node
    nod = nod + 1;
    pause(1)
end
% fwrite(scr,'w'); %LED ON
% disp('Blink');
pause(1)
% fwrite(scr,'q'); %LED OFF


% back_nod = size(path,1)-1;
% while(back_nod ~= 0)
% %     bot_move(front_rgb,rear_rgb,path(back_nod,2:-1:1),vid,rect,scr,sfact);  %bot moves to next node
%     bot_move(front_rgb,rear_rgb,path(back_nod,:),vid,rect,scr,sfact);  %bot moves to next node
%     back_nod = back_nod - 1;
%     pause(1)
% end
% % fwrite(scr,'w'); %LED ON
% % disp('Blink');
% pause(1)
% % fwrite(scr,'q'); %LED OFF
end

