% Get data
clear all; close all; clc
wine_data = load("wine.data")
X = wine_data(:, 2:end);
y = wine_data(:, 1);
X= X';
y = y';

% Dimensional reduction
w = fisher(X, y, 3);
X = w * X;

% Output layer
G = gridtop(1, 3, 3);

% Center the grid in the value space aprox
mean1=mean(X(1, :));
mean2=mean(X(2, :));
G(1,:)=G(1,:)-mean(G(1,:));
G(2,:)=G(2,:)-mean(G(2,:));
G(1,:)=G(1,:)+mean1;
G(2,:)=G(2,:)+mean2;

figure;
subplot(1,2,1),plotpat(X,y);
subplot(1,2,2),plotsom(G);

% Neighborhood
neigh = linkdist(G);

% Training
lrate = 0.5;
max_iter = 100;
dibujar = 1;
W = KohonenTrain(X, G, neigh, lrate, max_iter);


%Classification: Minimun distance

centroids_order = reorderCentroids(W, X, y);

n_classes = length(unique(y));

for i=1:n_classes
    d(i,:) = d_euclid(X,W(:, centroids_order(i)));
end

[~,yest]=min(d);
t_acierto_total_de = 100*sum(y ==yest)/length(yest)