function e1 = norm_error(U_k, S_k, V_k ,U1_k,S1_k,V1_k)
    %[U1,S1,V1] = svds(A,k);
    %U1 = U1(:,1:k);
    %S1 = S1(1:k, 1:k);
    %V1 = V1(:,1:k);
    ferr = @(u,v) norm(u,'fro')- norm(v,'fro');
     e1 = ferr(U_k*S_k*V_k',(U1_k*S1_k*V1_k'));
end