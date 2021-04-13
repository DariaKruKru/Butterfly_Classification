close all; clc; clear all; warning off;
%%
inputPath = './images/';
maskPath = './segmentations/';
outPath = './output_seg/';
fileList = getAllFiles(inputPath,'*.jpg');
%%
for i=1:numel(fileList)
    file = fileList{i};
    [~,name,ext] = fileparts(file);
    imgInput = imread(file);
    imgMask = imread([maskPath name '_mask.png']);
    imgOut = imgInput .* cat(3,imgMask,imgMask,imgMask);
    imwrite(imgOut,[outPath name '_Seg.jpg'],'jpg');
end
%%
%- Class 001 {Danaus plexippus}
%           ->  Orange with Black and White
%- Class 002 {Heliconius charitonius}
%           ->  Black with White
%- Class 003 {Heliconius erato}
%           ->  Black with Red and White
%- Class 004 {Junonia coenia}
%           ->  Gray with White, Orange, and Black
%- Class 005 {Lycaena phlaeas}
%           ->  Gray with Orange and Black
%- Class 006 {Nymphalis antiopa}
%           ->  Red with Blue and Black
%- Class 007 {Papilio cresphontes}
%           ->  Black with Yellow
%- Class 008 {Pieris rapae}
%           ->  White with Gray
%- Class 009 {Vanessa atalanta}
%           ->  Black with Orange and White
%- Class 010 {Vanessa cardui}
%           -> Orange with Black and White