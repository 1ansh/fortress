function[] = bot_orient(var_angle,d,scr)
if var_angle<=10 && var_angle>=-10
    if(d>45)
        fwrite(scr,'f');
        disp('f');
        pause(0.8)
        disp('0.8')
        fwrite(scr,'s'); pause(0.23);
        disp('s');
    else
        fwrite(scr,'f');
        disp('f');
        pause((d*0.7)/35)
        disp((d*0.7)/35)
        fwrite(scr,'s'); pause(0.23);
        disp('s');
    end
elseif var_angle<=90 && var_angle>10
    fwrite(scr,'r');
    disp('r');
    pause(((var_angle/3)-1)/90)
    disp(((var_angle/3)-1)/90)
    fwrite(scr,'s'); pause(0.23);
    disp('s');
% elseif var_angle<=45 && var_angle>25
%     fwrite(scr,'r');
%     disp('r');
%     pause((var_angle*0.75)/90)
%     disp((var_angle*0.75)/90)
%     fwrite(scr,'s'); pause(0.23);
%     disp('s');
% elseif var_angle<=90 && var_angle>45
%     fwrite(scr,'r');
%     disp('r');
%     pause((var_angle*0.5)/90)
%     disp((var_angle*0.5)/90)
%     fwrite(scr,'s'); pause(0.23);
%     disp('s');
elseif var_angle>=-90 && var_angle<-10
    fwrite(scr,'l');
    disp('l');
    pause((abs(var_angle/3)-1)/90)
    disp((abs(var_angle/3)-1)/90)
    fwrite(scr,'s'); pause(0.23);
    disp('s');
% elseif var_angle>=-45 && var_angle<-25
%     fwrite(scr,'l');
%     disp('l');
%     pause(abs(var_angle*0.75)/90)
%     disp(abs(var_angle*0.75)/90)
%     fwrite(scr,'s'); pause(0.23);
%     disp('s');
% elseif var_angle>=-90 && var_angle<-45
%     fwrite(scr,'l');
%     disp('l');
%     pause(abs(var_angle*0.5)/90)
%     disp(abs(var_angle*0.5)/90)
%     fwrite(scr,'s'); pause(0.23);
%     disp('s');
elseif var_angle<=170 && var_angle>90
    fwrite(scr,'l');
    disp('l');
    pause((((180-var_angle)/3)-1)/90)
    disp((((180-var_angle)/3)-1)/90)
    fwrite(scr,'s'); pause(0.23);
    disp('s');
% elseif var_angle<=155 && var_angle>135
%     fwrite(scr,'l');
%     disp('l');
%     pause(((180-var_angle)*0.75)/90)
%     disp(((180-var_angle)*0.75)/90)
%     fwrite(scr,'s'); pause(0.23);
%     disp('s');
% elseif var_angle<170 && var_angle>155
%     fwrite(scr,'l');
%     disp('l');
%     pause(((180-var_angle))/90)
%     disp(((180-var_angle))/90)
%     fwrite(scr,'s'); pause(0.23);
%     disp('s');
elseif var_angle>=-170 && var_angle<-90
    fwrite(scr,'r');
    disp('r');
    pause((((180-abs(var_angle))/3)-1)/90)
    disp((((180-abs(var_angle))/3)-1)/90)
    fwrite(scr,'s'); pause(0.23);
    disp('s');
% elseif var_angle>=-155 && var_angle<-135
%     fwrite(scr,'r');
%     disp('r');
%     pause(((180-abs(var_angle))*0.75)/90)
%     disp(((180-abs(var_angle))*0.75)/90)
%     fwrite(scr,'s'); pause(0.23);
%     disp('s');
% elseif var_angle>-170 && var_angle<-155
%     fwrite(scr,'r');
%     disp('r');
%     pause(((180-abs(var_angle)))/90)
%     disp(((180-abs(var_angle)))/90)
%     fwrite(scr,'s'); pause(0.23);
%     disp('s');
elseif var_angle>=170 || var_angle<=-170
    if(d>45)
        fwrite(scr,'b');
        disp('b');
        pause(0.8)
        disp('0.8')
        fwrite(scr,'s'); pause(0.23);
        disp('s');
    else
        fwrite(scr,'b');
        disp('b');
        pause((d*0.7)/35)
        disp((d*0.7)/35)
        fwrite(scr,'s'); pause(0.23);
        disp('s');
    end
end
end