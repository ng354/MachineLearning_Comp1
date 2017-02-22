A = csvread('Adjacency.csv');
feats = csvread('features.csv');
seed = csvread('seed.csv');

size(A)
size(feats)
size(seed)

disp('Spectral Only')
eVec = spectralOnly(A,seed);

disp('kmeans Only')
kmeansOnly (feats, seed)

disp('Combined through CCA')
combinedData(feats, eVec, seed)
