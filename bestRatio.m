load('my_features_labels.mat');

rat = 0;
i=1;

for rat = 0.1 : 0.1 :0.9
    %Get training data
    numbTrSamples = ceil (totalNumberSampels * rat);
    X_tr = allFts (1 : numbTrSamples, : );
    Y_tr = allLabels (1 : numbTrSamples)';
    
    %create classification model
    Mdl = fitcknn(X_tr, Y_tr,'NumNeighbors',5,'Standardize',1);
    
    accuracy =  0;
    i=i+1;
    
    numbTestSamples = totalNumberSampels - numbTrSamples;
    
    for number = numbTrSamples+1 : totalNumberSampels
        X = allFts (number, :);
        result = predict(Mdl, X);
        
        if (result == allLabels (number))
            accuracy = accuracy +1;
        end
        
    end

    accuracy = accuracy/ numbTestSamples;
    
    ACC (1, i)= rat;
    ACC (2, i)= accuracy;
end

