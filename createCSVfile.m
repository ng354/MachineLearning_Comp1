function createCSVfile (cluster2digit,idx,filename)
% cluster2digit - array to convert cluster to digit
% idx - array cluster assignment from kmeans
% filename - with .csv extension

data = zeros(12000,2);

for k = 1:12000
    data(k,1) = k;
    data(k,2) = cluster2digit(idx(k));
end

csvwrite(filename, data)