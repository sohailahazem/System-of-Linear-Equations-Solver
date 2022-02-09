function [x,flag] = gaussianEliminationPivot(a,b)
flag=0;
n = size(a,1);
x = zeros(n,1);  
a = [a,b]; 

%forward elimination
for i = 1:n-1
      if(a(i,i) == 0)
            flag = 1;
            return;
      end
    max = i;
    for row = i+1:n
        if abs(a(row,i)) > abs(a(max,i))
            max=row;     
        end
    end
    if(max~=i)
        temp = a(i,:);
        a(i,:) = a(max,:);
        a(max,:) = temp;   
    end
    m = a(i+1:n,i)/a(i,i);
    a(i+1:n,:) = a(i+1:n,:) - m*a(i,:);
end

% back substitution
 if(a(n,n) == 0)
        flag = 1;
        return;
 end
x(n) = a(n,n+1)/a(n,n);
for i = n-1:-1:1
    x(i) = (a(i,n+1) - a(i,i+1:n)*x(i+1:n))/a(i,i);
end
end