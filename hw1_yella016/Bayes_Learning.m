function [p1, p2, pc1, pc2] = Bayes_Learning(training_data, validation_data)

% Bayes_Learning. Takes training data and validation data as inputs.
% Returns the following outputs:
%   p1  - learned Bernoulli parameters of the first class
%   p2  - learned Bernoulli parameters of the second class
%   pc1 - best prior of the first class
%   pc2 - best prior of the second class

% Extract data and class labels from training and validation data
T = training_data(:,1:end-1);
T_labels = training_data(:,end);

V = validation_data(:,1:end-1);
V_labels = validation_data(:,end);

% logical array for records of class 1 and class 2
T1_i = (T_labels(:) == 1);
T2_i = (T_labels(:) == 2);

% Extract records for class 1 and class 2 into separate matrix.
% To be used for computing p(x=0|C1) and p(x=0|C2)
T1 = T(T1_i,:);
T2 = T(T2_i,:);

% p1 is the ratio of records where xi is 0 to the total number records 
% of class C1
p1 = (sum((T1(:,:)==0))/size(T1,1))';

% Similarly p2 for class C2
p2 = (sum((T2(:,:)==0))/size(T2,1))';

% Initialize sigma
sigma = -5:5;

% Compute the prior for each sigma
tPC1 = 1./(1+exp(-sigma));
tPC2 = 1 - tPC1;

% vectors for determinant function and predictions
g1 = zeros(size(validation_data,1),1);
g2 = zeros(size(validation_data,1),1);
pred_for_sigma = zeros(size(validation_data,1),1);

% to decide on best sigma
tResult = zeros(size(sigma,2),1);

for i=1:size(sigma,2)
    for ii=1:size(validation_data,1)
        
        % Compute likelihood probabilities for C1 and C2
        p0C1 = p1.^(1-V(ii, :)');
        p1C1 = (1-p1).^(V(ii,:)');
        
        p0C2 = p2.^(1-V(ii, :)');
        p1C2 = (1-p2).^(V(ii,:)');
        
        % Compute determinant from prior and likelihood
        g1(ii) = tPC1(1,i)*prod(p0C1 .* p1C1);
        g2(ii) = tPC2(1,i)*prod(p0C2 .* p1C2);
        
        % Compare and choose class
        if g1(ii) > g2(ii)
            pred_for_sigma(ii) = 1;
        else
            pred_for_sigma(ii) = 2;
        end
        
    end
    
    %compute errors
    error = V_labels - pred_for_sigma;
    
    %  check for instances where error is 0
    tResult(i) = sum(error(:) == 0);
    
    % Print output to the terminal
    fprintf('Num of correct pred:  %d, Error rate:  %.4f%% and sigma:  %d\n',...
        tResult(i), (1-(tResult(i))/size(V,1))*100, sigma(i) );
    
    % Clear g1, g2 and temp_pred for next sigma 
    g1 = zeros(size(validation_data,1),1);
    g2 = zeros(size(validation_data,1),1);
    pred_for_sigma = zeros(size(validation_data,1),1);
end

% Take the sigma that produces minimum error on validation data
[value, index] = max(tResult);
fprintf('Best performance on validation set for sigma =  %d\n',...
    sigma(index));
fprintf('with error rate =  %.4f%%\n', (1-(value/size(V,1)))*100);

% Set best priors
pc1 = tPC1(index);
pc2 = tPC2(index);

end