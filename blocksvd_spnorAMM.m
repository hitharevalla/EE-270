function [U,S,V] = blocksvd_spnorAMM(A, iter, k, tall, nsamp)
    
    d = min(size(A));
    n = max(size(A));
    m = nsamp;
    if(tall==0)
        A=A';
    end
    A_act = A;
    
    %perform sparse normal sketching on A here (0 with prob q and N(0,1) with prob 1-q) (S should be m*n in size)
    %S = zeros(m,n);
    col = 1:1:n;
    row = randsample(m, n,true);
    
    S = (1/nsamp^0.5)*sparse(row, col, randsrc(1, length(col)), m, n);
   
    A = S*A;
    %end sketching here (make A = S*A)
    
    PI = randn(d,k);
    [PI,~] = qr(PI,0);
    K  = zeros(d, k*iter);
    
    
    for i=1:iter
        PI = A'*A*PI;
        [PI,~] = qr(PI,0);
        K(:,(i-1)*k+1:i*k) =  PI;
    end

    [Q, ~] = qr(K,0);
    T = A_act*Q;
    %T = A*Q;
    [Ut, St, Vt] = svd(T,0);
    
    S = St(1:k, 1:k);
    
    if (tall==0)
        V = Ut(:,1:k);
        U = Q*Vt(:,1:k);
    else
        U = Ut(:, 1:k);
        V = Q*Vt(:,1:k);
    end

end