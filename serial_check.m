scr = serial('COM6','BaudRate',9600);
fopen(scr);
pause(2);
fwrite(scr,'w');
fwrite(scr,'f');
pause(0.5);
fwrite(scr, 's');
pause(0.5);
fwrite(scr,'r');
pause(0.5);
fwrite(scr, 's');
pause(0.5);
fwrite(scr,'f');
pause(0.5);
fwrite(scr, 's');
pause(0.5);
fwrite(scr,'r');
pause(0.5);
fwrite(scr, 's');
pause(0.5);
fwrite(scr,'f');
pause(0.5);
fwrite(scr, 's');
pause(0.5);
fwrite(scr,'r');
pause(0.5); 
fwrite(scr, 's');
pause(0.5);
fwrite(scr,'f');
pause(0.5);
fwrite(scr, 's');
pause(0.5);
fwrite(scr, 'r');
pause(0.5);
fwrite(scr, 's');
fwrite(scr,'q');
fclose(scr);