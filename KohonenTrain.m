function W = KohonenTrain(X, W, neibhd, lrate, max_iter)
    n_patterns = size(X, 2);
    n_units = size(W, 2);
    lratein=lrate;

    plot(X(1, :),X(2, :),'mo'),hold on;
    plotsom(W',neibhd),hold off;
    pause(2);
    convergence = false;
    lastW = W;
    t = 1;
        
    while ~convergence && t <= max_iter 
        for i=1:n_patterns
            distance = repmat(X(:, i), 1, n_units, 1) - W;
            [~, bmu] = min(sum(distance.^2));
            inc = lrate * (X(:, i) - W(:, bmu));
            
            for j=1:n_units
                omega = 1/(2^neibhd(j, bmu));
                W(:, j) = W(:, j) + inc * omega;
            end
        end  
        lrate = lratein * (1-(t/max_iter));
        
        plot(X(1, :),X(2, :),'mo'),hold on;
        plotsom(W',neibhd),hold off;
        pause(0.5)
        
        if lastW == W
            convergence = true;
        else
            lastW = W;
        end 
        t = t + 1;
    end
end

