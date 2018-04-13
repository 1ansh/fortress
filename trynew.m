function[] = trynew()
try
    notAfunction
catch
    prompt = {'Please request a timeout'};
    dlg_title = 'May-Day';
    answer = inputdlg(prompt,dlg_title);
    disp('Mission Accomplished');
end