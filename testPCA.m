function testPCA(feats, eigvecs, seed, ccaDim, pcaDim)

% - - - - Run PCA on feats - - - - 
C = cov(feats); 
[W1,E] = eigs(C,pcaDim);

[nr,nc] = size(feats);
Amu = feats;
for k = 1:nc
    avg = sum(feats(:,k))/nr;
    Amu(:,k) = Amu(:,k) - avg;
end

X1 = Amu*W1;
X2 = eigvecs;


[W1, W2, r] = cca(X1,X2,ccaDim);

% Center X1
[nr, nc] = size(X1);
for k = 1:nc
    avg = sum(X1(:,k))/nr;
    X1(:,k) = X1(:,k) - avg;
end

% Choose one of these to cluster
Y1 = X1*W1;
%Y2 = X2*W2;

X = Y1;

[nr, nc] = size(X);
centroidmatrix = zeros(10, nc);

for i = 1:10
    for j = 1:3
        centroidmatrix(i,:) = centroidmatrix(i,:) + X(seed(i,j),:);
    end
    centroidmatrix(i,:) = centroidmatrix(i,:)/3;
end

[idx, C] = kmeans(X,10,'Start',centroidmatrix);
% where centroid matrix is a k x d matrix consisting of K centroids one per row.


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

plot2d(X,C)




