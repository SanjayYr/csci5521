function [] = Bayes_Testing(test_data, p1, p2, pc1, pc2)

X = test_data(:,1:end-1);
X_labels = test_data(:,end);

g1 = zeros(size(test_data,1),1);
g2 = zeros(size(test_data,1),1);
pred = zeros(size(test_data,1),1);

for ii=1:size(test_data,1)
        
        % Compute likelihood probabilities for C1 and C2
        p0C1 = p1.^(1-X(ii, :)');
        p1C1 = (1-p1).^(X(ii,:)');
        
        p0C2 = p2.^(1-X(ii, :)');
        p1C2 = (1-p2).^(X(ii,:)');
        
        % Compute determinant from prior and likelihood
        g1(ii) = pc1*prod(p0C1 .* p1C1);
        g2(ii) = pc2*prod(p0C2 .* p1C2);
        
        % Compare and choose class
        if g1(ii) > g2(ii)
            pred(ii) = 1;
        else
            pred(ii) = 2;
        end
        
end

error = X_labels - pred;
accuracy = sum(error(:)==0)/size(error,1);
fprintf('Error Rate using the best prior: %.4f%%\n', (1-accuracy)*100);

end