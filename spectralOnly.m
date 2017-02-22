function eVec = spectralOnly(A, seed, k)
% Spectral clustering
%   k - number of eigenvectors

n = 12000;
d = zeros(1,n);
for i=1:n
    d(i) = sum(A(i,:));
end

D = sparse(diag(d.^(-1/2)));
L = eye(n,n) - D*A*D;

[eVec,eVal] = eigs(L, k, 'sm');

figure; plot(1:k, diag(eVal),'.')

[nr, nc] = size(seed);
centroidmatrix = zeros(10, k);

for i = 1:nr 
    for j = 1:nc
        centroidmatrix(i,:) = centroidmatrix(i,:) + eVec(seed(i,j),:);
    end
    centroidmatrix(i,:) = centroidmatrix(i,:)/nc;
end

X = eVec;
idx = kmeans(X,10,'Start',centroidmatrix);


bin = zeros(1,10);
for k=1:length(idx)
    bin(idx(k)) = bin(idx(k)) + 1;
end
bin

[nr, nc] = size(seed);
for i = 1:nr
    fprintf('%3d: ', i-1)
    for j = 1:nc
       fprintf('%d ', idx(seed(i,j)))
    end
    fprintf('\n')
end
