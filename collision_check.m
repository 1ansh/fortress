function [bool] = collision_check (a,bwimage)
x1=a(1);
x2=a(3);
y1=a(2);
y2=a(4);
bool =0;
slope=(x2-x1)/(y2-y1);
constant= y1-slope*(x1);

if(abs(slope)<1)
    if(x2<x1)
    temp=x2;
    x2=x1;
    x1=temp;
    end
    for i = x1:10:x2
        ytemp=round(slope*i+constant);
        if bwimage(i,ytemp)== 1
            bool = 1;
            break;
        end
    end
    
else
    if(y2<y1)
        temp=y2;
        y2=y1;
        y1=temp;
    end
  for i = y1:10:y2
    xtemp=round((-constant+i)/slope);
    if bwimage(xtemp,i)== 1
        bool = 1;
        break;
    end

  end
end
end

