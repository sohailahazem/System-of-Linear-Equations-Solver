function  [x,flag]  = gaussianJordanPivot(A,B )
flag = 0;
X = [A B];
[n,m]=size(X);
x = zeros(n,1);      
for i = 1:n
     if X(i,i)==0
             x = [];
             flag = 1;
             break;
     end 
max=i;
    for row = i+1:n
        if abs(X(row,i)) > abs(X(max,i))
            max=row;     
        end
    end
    if(max~=i)
        temp = X(i,:);
        X(i,:) = X(max,:);
        X(max,:) = temp;   
    end

    for j = 1:n
        if  i ~= j
            X(j,:) = X(j,:) - X(i,:).*X(j,i)./X(i,i);
        end
    end
end
for i = 1:n
    x(i) = X(i,m)/X(i,i);
end
end