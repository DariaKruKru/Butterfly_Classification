%Butterfly_classify.m script creates a classification model. It contains variable ?ratio? 
%that in charge of  ratio between size of training and testing sets. 
%The script uses previously created file (my_features_labels.mat) 
%with all features extracted from each picture and number of correct type for them. 
%At the end of execution it saves classification model for future use.

load('my_features_labels.mat');

totalNumberSampels = length (allLabels);
ratio = 0.86; %set the ratio of size of training set to size of test set

%Get training data
numbTrSamples = ceil (totalNumberSampels * ratio);
X_tr = allFts (1 : numbTrSamples, : );
Y_tr = allLabels (1 : numbTrSamples)';

%create classification model
Mdl = fitcknn(X_tr, Y_tr,'NumNeighbors',5,'Standardize',1);

save ('my_mdl.mat', 'Mdl');

