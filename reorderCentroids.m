function centroids = reorderCentroids(W, X, y)
    centroids=zeros(1,size(W,2));

    for i=1:length(W)
       min_distance = Inf;
       class=-1;
       for j=1:length(X)
           distance = d_euclid(X(:,j), W(:,i));
            if distance < min_distance
               min_distance = distance;
               class=y(j);
            end
       end
       centroids(i)=class;
    end

end

