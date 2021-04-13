clc
clear
close all

outPath = './Dataset/output_seg/'; %set a directory

ListImgs = dir([outPath, '0*.jpg']);
ListImgs_rand = ListImgs(randperm(length (ListImgs))); %randomize order of images

for  imNum= 1:length (ListImgs)
    
    I_org = imread( [outPath ListImgs_rand(imNum).name]); %read the image
    
   [Img_preprocessed, img_mask] =  getPreprocessedImage (I_org);
   
   allFts (imNum, : ) =  getMyFeatures (Img_preprocessed, img_mask);
   
    %create a vector containing number of type for each image in dataset
   allLabels (imNum) = str2num (ListImgs_rand  (imNum).name(1:3));
    
end

save ( 'my_features_labels.mat', 'allFts',  'allLabels'); %save featuress and correct types
save( 'ListImgsName_rand.mat', 'ListImgs_rand'); %save permutd order 
