clc; close all; clear all;

% %ref: http://stackoverflow.com/questions/5803915/getting-all-file-names-at-a-given-folder-name
% allFiles = dir( './output_seg/' );
% allNames = { allFiles.name };
% 
% allNames = allNames(3:end);
% 
% [pathstr,name,ext] = fileparts(allNames{1});
% strs = strsplit(name,'_');

img = imread('./output_seg/001_0001_Seg.jpg');
imgR_adj = imadjust(img(:,:,1));
imgG_adj = imadjust(img(:,:,2));
imgB_adj = imadjust(img(:,:,3));
img_adj = cat(3,imgR_adj,imgG_adj,imgB_adj);
% img_eq = histeq(img);

figure;
subplot(1,3,1);
imshow(img);
subplot(1,3,2);
imshow(img_adj);
% subplot(1,3,3);
% imshow(img_eq);
%%
img_avg = imfilter(img,fspecial('average', 5));
img_gaus = imfilter(img,fspecial('gaussian', 5, 2));
% img_med = medfilt2(rgb2gray(img),[5  5]);
img_sharp = imsharpen(img);


figure;
subplot(2,2,1);
imshow(img);
subplot(2,2,2);
imshow(img_avg);
subplot(2,2,3);
imshow(img_gaus);
subplot(2,2,4);
imshow(img_sharp);


%%
imgR = img(:,:,1);
figure; imshow(imgR);
thr = graythresh(imgR);
im_BW = im2bw(imgR,thr);
figure; imshow(im_BW);
[N,edges] = histcounts(imgR,256);
figure; plot(edges(2:end),N);
thr_m = 50;
im_BW2 = imgR >= thr_m;
figure; imshow(im_BW2);

thr2 = multithresh(imgR,2);
im_ind = imquantize(imgR,thr2);
figure;imshow(im_ind,[]);

im_BW3 = imgR >= 10 & imgR <= 50;
figure; imshow(im_BW3);





