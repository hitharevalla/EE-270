function [U,S,V] = blocksvd_fftAMM(A, iter, k, tall, nsamp)
    
    d = min(size(A));
    n = max(size(A));
    m = nsamp;
    if(tall==0)
        A=A';
    end
    A_act = A;
    
    %perform sketching on A here (S should be m*n in size)
    D = randsrc(n,1);
    DA = repmat(D,1,d).*A;
    T = abs(fft(DA,n));
    A = (1/m^0.5)*T(randsample(n,m,'true'),:);
    %end sketching (A=S*A)
    
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
