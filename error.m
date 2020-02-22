function e1 = norm_error(A,k,U_k,S_k,V_k)
[U1,S1,V1] = svds(A,k);
ferr = @(u,v) norm(u(:),'fro')- norm(v(:),'fro');
 e1 = ferr(U1*S1*V1',(U_k*S_k*V_k));
end
 
