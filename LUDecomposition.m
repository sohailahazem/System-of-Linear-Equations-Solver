function [x] = LUDecomposition(A, B)
     [n,c] = size(A);
     scalingFactors = zeros(n, 1);
     [L, U, B] = decompose(A, B, n, scalingFactors);
     [X] = substitute(L, U, B, n); 
     x = zeros(n,1);
     for i = 1 : n
         x(i) = X(i);
     end
end

function [L, A, B] = decompose(A, B, n, scalingFactors)
    for i = 1 : n
        scalingFactors(i) = abs(A(i, 1));
        for j = 2 : n
            if abs(A(i, j)) > scalingFactors(i)
                scalingFactors(i) = abs(A(i, j));
            end
        end
    end   
     
    L = zeros(n);
    for i = 1 : n
        L(i,i) = 1;   %set diagonal elements = 1
    end
    % decompose A into U and L
    for k = 1 : n - 1
        [L, A, B, scalingFactors] =  pivot(L, A, B, scalingFactors, n, k);
        % forward elimination for A to get U
        for i = k + 1 : n
            factor = A(i, k) / A(k, k);
            for j = k + 1 : n
                A(i, j) = A(i, j) - factor * A(k, j);
            end
            L(i, k) = factor;
        end
    end
end

function [L, U, B, scalingFactors] =  pivot(L, U, B, scalingFactors, n, row)
    pivot = row;
    big = abs(U(row, row) / scalingFactors(row));
    for i = row + 1 : n
        dummy = abs(U(i, row) / scalingFactors(i));
        if (dummy > big)
            big = dummy;
            pivot = i;
        end
    end

    if (pivot ~= row)
        % swap in U Matrix
        for j = row : n
            dummy = U(pivot, j);
            U(pivot, j) = U(row, j);
            U(row, j) = dummy;
        end
        % swap in L Matrix
        for j = 1 : row-1
            dummy = L(pivot, j);
            L(pivot, j) = L(row, j);
            L(row, j) = dummy;
        end
        % swap in B Matrix
        dummy = B(pivot);
        B(pivot) = B(row);
        B(row) = dummy;
        
        % swap in scaling factors
        dummy = scalingFactors(pivot);
        scalingFactors(pivot) = scalingFactors(row);
        scalingFactors(row) = dummy;
    end
end

function [X] = substitute(L, U, B, n)
    Y = zeros(n, 1);
    Y(1) = B(1) / L(1,1);
    for i = 2 : n
        sum = 0;
        for j = 1 : i - 1
            sum = sum + L(i, j) * Y(j);
        end
        Y(i) = (B(i) - sum) / L(i,i);
    end

    X(n) = Y(n) / U(n, n);
    for i = n - 1 : -1 : 1
        sum = 0;
        for j = i + 1 : n
            sum = sum + U(i, j) * X(j);
        end
        X(i) = (Y(i) - sum) / U(i, i);
    end
end