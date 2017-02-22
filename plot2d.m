function plot2d(A,centroids) 
% centroids - column 1 is x, column 2 is y

A = [A; centroids];

C = cov(A); 
[W1,E] = eigs(C,2);

[nr,nc] = size(A);
Amu = A;
for k = 1:nc
    avg = sum(A(:,k))/nr;
    Amu(:,k) = Amu(:,k) - avg;
end

Y = Amu*W1;

figure; hold on
plot(Y(1:nr-10,1),Y(1:nr-10,2),'b.')
plot(Y(nr-9:nr,1),Y(nr-9:nr,2),'y*')

for k = nr-9:nr
    dig = k-nr+9;
    text(Y(k,1), Y(k,2), sprintf('%d',dig), 'Color', 'red', 'FontSize', 14);
end
hold off
