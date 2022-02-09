
function [x, flag] = gaussianElimination(A, B)
    flag = 0;
    [n,c] = size(A);
    x = zeros(n,1);
    %foward elimination
    for i = 1 :n-1
        if(A(i,i) == 0)
            flag = 1;
            return;
        end
       for k = i+1 : n 
           factor = A(k,i)/A(i,i);
           for j = i+1: n 
               A(k,j) = A(k,j) - factor * A(i,j);
           end 
           B(k) = B(k)- factor * B(i);
       end
    end 
    %backward substitution
    if(A(n,n) == 0)
        flag = 1;
        return;
    end
    x(n)= B(n)/A(n,n);
    for i = n-1:-1:1
        if(A(i,i) == 0)
            flag = 1;
            return;
        end
        sum = 0;
        for j = i+1 : n 
            sum = sum + A(i,j) * x(j);
        end 
        x(i) = (B(i) - sum) / A(i,i);
    end
end