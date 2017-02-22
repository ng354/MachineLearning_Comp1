function combinedData(feats, eigvecs, seed, ccaDim)
% Combines feats and eigvecs data through CCA
% and runs kmeans
%
% Inputs:
%   feats - 12000 x 103
%   eigvecs - 12000 x 10 (rows are spectral embedding)

X1 = feats;
X2 = eigvecs;

% normalize both data sets?
%X1 = normc(X1);
%X2 = normc(X2);

[W1, W2, r] = cca(X1,X2,ccaDim);

% Center X1
[nr, nc] = size(X1);
for k = 1:nc
    avg = sum(feats(:,k))/nr;
    X1(:,k) = feats(:,k) - avg;
end

% Choose one of these to cluster
Y1 = X1*W1;
Y2 = X2*W2;

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


data = zeros(12000,2);

for k = 1:12000
    data(k,1) = k;
    data(k,2) = idx(k)-1;
end

csvwrite('combinedAssignment.csv', data)


