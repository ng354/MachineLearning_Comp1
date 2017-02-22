function kmeansOnly (feats, seed)

k = 10;
X = feats;

[nr, nc] = size(seed);
centroidmatrix = zeros(k, 103);

for i = 1:nr 
    for j = 1:nc
        centroidmatrix(i,:) = centroidmatrix(i,:) + feats(seed(i,j),:);
    end
    centroidmatrix(i,:) = centroidmatrix(i,:)/nc;
end

[idx, C] = kmeans(X,k,'Start',centroidmatrix);
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


cluster2digit = [9,0,7,3,4,5,6,2,8,1];
createCSVfile(cluster2digit,idx,'kmeansAssignment.csv')

