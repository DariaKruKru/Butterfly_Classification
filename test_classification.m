load('my_features_labels.mat');
load ('my_mdl.mat');
load ('ListImgsName_rand.mat');

number = randi (length(allLabels) - ceil (10*ratio))+ceil (10*ratio);

X = allFts (number, :);

result = predict(Mdl, X);

TypeName={'Danaus plexippus' 'Heliconius charitonius' 'Heliconius erato' 'Junonia coenia' 'Lycaena phlaeas' ...
    'Nymphalis antiopa' 'Papilio cresphontes' 'Pieris rapae' 'Vanessa atalanta' 'Vanessa cardui'};

Img_show=imread(strcat(ListImgs_rand(number).folder,'/',ListImgs_rand(number).name));
imshow(Img_show); 
str1=strcat({'Finded type:'},num2str(result),{' ('},TypeName(1,result),{')'});
str2=strcat({'Correct type:'},num2str(allLabels (number)),{' ('},TypeName(1,allLabels (number)),{')'});
title([str1;str2]);
