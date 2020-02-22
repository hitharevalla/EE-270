function [U,S,V] = blocksvd(A, iter, k, tall, nsamp)
    
    d = min(size(A));
    n = max(size(A));
    m = nsamp;
    if(tall==0)
        A=A';
    end
    A_act = A;
    
    %generating D
    x = randsrc(n,1);
    %D = diag(x);    
    %find DA (do optimal since D is diagonal)
    temp = repmat(x,1,d); 
    DA = temp.*A;
    %find fast H transform of DA
    temp2 = fwht(DA);
    %sample using P
    %m= 400;
    samples = randsample(n, m, true);
    A1 = temp2(samples,:);
    
    A = A1;
    
    PI = randn(d,k);
    [PI,~] = qr(PI,0);
    K  = zeros(d, k*iter);
    
    for i=1:iter
        PI = A'*(A*PI);
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