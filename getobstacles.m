qw = bwlabel(imSegAr);
ab = imSegAr;
for i=1:length(centAr)
    flag = 0;
    for j=1:length(destCoord)
        if(centAr(i)==destCoord(j))
        flag = 1;
%         disp('hi');
        end
    end
    if (flag==1)
        ab = ab - (qw(:,:)==i);
    end
end