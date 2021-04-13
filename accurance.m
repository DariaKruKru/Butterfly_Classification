load ('my_mdl.mat');
load ('ListImgsName_rand.mat');

%Get testing data
numbTestSamples = totalNumberSampels - numbTrSamples;

%initialization
accuracy =  0;
number_type = zeros (1, 10); %frequency of each type in test set
number_result = zeros (1, 10); %frequency of correct answer for each type in test set

for number = numbTrSamples+1 : totalNumberSampels

    X = allFts (number, :); %get the featres for test image
    result = predict(Mdl, X);
    
    %count how many pictures of each type in test set
    number_type(1, allLabels (number)) = number_type(1, allLabels (number)) +1; 
    
    if (result == allLabels (number))
        accuracy = accuracy +1; %summation of the correct answers
        number_result(1,allLabels (number))=number_result(1,allLabels (number))+1; %count number of correct results for each type
    end
end

%calculation of the probabity to pridict right type for each kind pf the butterfly
RES_type = number_result./number_type; 

accuracy = accuracy/ numbTestSamples; %calculation of final accuracy