function eigvecs = code()
% Main function for running digit classification.
% Takes several minutes to run - please be patient!

A = csvread('Adjacency.csv');
feats = csvread('features.csv');
seed = csvread('seed.csv');

eigvecs = spectralEmbedding(A, seed, 250);
ccaKmeans(feats, eigvecs, seed, 3);

end

function eVec = spectralEmbedding(A, seed, k)
% Returns spectral embedding matrix eVec from spectral clustering
%   k - number of eigenvectors

n = 12000;
d = zeros(1,n);
for i=1:n
    d(i) = sum(A(i,:));
end

D = sparse(diag(d.^(-1/2)));
L = eye(n,n) - D*A*D;

[eVec,eVal] = eigs(L, k, 'sm');

%figure; plot(1:k, diag(eVal),'.')

[nr, nc] = size(seed);
centroidmatrix = zeros(10, k);

for i = 1:nr 
    for j = 1:nc
        centroidmatrix(i,:) = centroidmatrix(i,:) + eVec(seed(i,j),:);
    end
    centroidmatrix(i,:) = centroidmatrix(i,:)/nc;
end
end

function ccaKmeans(feats, eigvecs, seed, ccaDim)
% Combines feats and eigvecs data through CCA
% and runs kmeans
%
% Inputs:
%   feats - 12000 x 103
%   eigvecs - 12000 x n (rows are spectral embedding)

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

% 
% data = zeros(12000,2);
% 
% for k = 1:12000
%     data(k,1) = k;
%     data(k,2) = idx(k)-1;
% end
% 
% csvwrite('combinedAssignment.csv', data)
end

function [Wx, Wy, r] = cca(X,Y,K)
% cca code given in class

C = cov([X,Y]);
sx = size(X,2);
sy = size(Y,2);
Cxx = C(1:sx, 1:sx);
Cxy = C(1:sx, sx+1:sx+sy);
Cyx = Cxy';
Cyy = C(sx+1:sx+sy, sx+1:sx+sy) ;
invCyy = pinv(Cyy);
invCxx = pinv(Cxx);

% --- Calculate Wx and r ---
[Wx,r] = eigs(invCxx*Cxy*invCyy*Cyx,K); % Basis in X

Wy = invCyy*Cyx*Wx;     % Basis in Y
Wy = Wy./repmat(sqrt(sum(abs(Wy).^2)),sy,1); % Normalize Wy
end
