function e2 = vec_error(A,U,Z)
[r,c] = size(U)
error = zeros(r)
for i = 1 : r
    error(i) = abs((U(i,:)'*A*A'*U(i,:)) - (Z(i,:)'*A*A'*Z(i,:)))
end
e2 = max(error(:))
end

