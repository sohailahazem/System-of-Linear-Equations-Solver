function [C, flag] = gaussianJordan(A,B)
    flag = 0;
    X = [A B];
    [n,m]=size(X);
    i=1;
    while i <= n
        if X(i,i)==0
             C = [];
             flag = 1;
             break;
         end 
        
    [r,m]= size(X);
    a=X(i,i);
    X(i,:)=X(i,:)/a;
    
    for k = 1:r
        if k == i
            continue;
        end 
        X(k,:) = X(k,:)-X(i,:)*X(k,i);
    end 
        i = i+1;
    end 
    C = X(:,m);
end