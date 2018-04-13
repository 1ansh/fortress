function[]=serial_send(char,advar,scr)
if char=='s'    %move forward
    fwrite(scr,'s');
    pause(1*advar/50);
    fwrite(scr,'a');
    pause(0.15);
elseif char=='b'        %move backward
    fwrite(scr,'b');
    pause(1*advar/50);
    fwrite(scr,'a');
    pause(0.15);
elseif char=='l'        %move left
    fwrite(scr,'l');
    pause(0.35*advar/100);
    fwrite(scr,'a');
    pause(0.15);
elseif char=='r'        %move right
    fwrite(scr,'r');
    pause(0.15*advar/100);
    fwrite(scr,'a');
    pause(0.15);
end
end