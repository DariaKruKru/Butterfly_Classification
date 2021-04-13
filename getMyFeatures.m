function Fts = getMyFeatures(img, img_mask)

%getMyFeatures function creates a features vector for each picture of
%butterfly. As input it takes two arguments: image of butterfly
%(3-dimensional) and its binary mask that we have already calculated in
%pre-processing function. As output this function returns a vector that
%contain a features for this particular image. More precisely: normalized
%histograms for red, green and blue channel (three vectors of 16 elements),
%entropy index, ratio of width and high of the image, area of the butterfly
%shape and compactness.

%% histogram normalization

R1=img(:,:,1); %values for single channel
G1=img(:,:,2);
B1=img(:,:,3);
[row_1,col_1]=size(R1); %width and high of the image

bins=16;  % define the bins value

% calculate hist
[row, col, R1v]=find(R1); %remove background
[row, col, G1v]=find(G1);
[row, col, B1v]=find(B1);

[R1_count,R1_cent]=hist(double(R1v),bins);% calaulate hist
[G1_count,G1_cent]=hist(double(G1v),bins);
[B1_count,B1_cent]=hist(double(B1v),bins);

%find max and min hist of image
Rmin=min(R1_count(:));
Gmin=min(G1_count(:));
Bmin=min(B1_count(:));
Rmax=max(R1_count(:));
Gmax=max(G1_count(:));
Bmax=max(B1_count(:));

% normalization
R1_count1=zeros(1,bins);
G1_count1=zeros(1,bins);
B1_count1=zeros(1,bins);

for i=1:bins
    R1_count1(1,i)=(R1_count(1,i)-Rmin)/(Rmax-Rmin);
    G1_count1(1,i)=(G1_count(1,i)-Gmin)/(Gmax-Gmin);
    B1_count1(1,i)=(B1_count(1,i)-Bmin)/(Bmax-Bmin);
end

%% texture
texture = entropy(img);

%% form
form = size (img, 1)/size (img, 2); 


%% area of butterfly
countA = size (find(img_mask),1);
img_area=countA/(size (img, 1)*size (img, 2));

%% perimeter

P = bwperim (img_mask, 4);
P = size (find(P));
compactness = (P (1,1)^2)/(4*pi*countA);

%% summary

Fts = [R1_count1 G1_count1 B1_count1 texture form img_area compactness];

end
