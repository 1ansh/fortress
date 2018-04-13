function [ path ] = smooth_path( path ,im )
first = 1;
sec = 2;
thir = 3;

while(thir<=size(path,1))
   if checkPath (path(first,:),path(thir,:),im)
       path(sec,:)=0;
       sec = thir;
       thir =  thir + 1;
   else
       first = sec;
       sec=thir;
       thir = thir+1;
   end
    
end
temp1 = path(:,1)~=0;
path = path(temp1,:);
end


