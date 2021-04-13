function [Img_preprocessed, img_mask]  = getPreprocessedImage(img)

%getPreprocessedImage function does preparation of an image for following
%feature extraction. As input it takes the 3-dimensional array of image,
%as output it gives two images: first is preprocessed image (which contain
%normally oriented, cropped and colour corrected picture of butterfly) and
%second is binary mask the same size (which contain black values for background and white for butterfly shape)


%% create binary mask 
img_mask = zeros (size (img,1 ), size (img,2));

for i=1 :size (img,1 )
    for j=1 :size (img,2 )
        if(img(i,j,1)==0 && img(i,j,2)==0 && img(i,j,3)==0)
            img_mask(i,j)=0;
        else
            img_mask(i,j)=255;
        end
    end
end

img_mask = imerode(img_mask, strel('diamond', 10));

%% section 1 "rotation" 
% find row or col has long distance

[row_1, col_1] = size(img_mask); %width and high of the image
row=zeros(row_1,1);
col=zeros(col_1,1);

for i=1:row_1
    [rowt, colt]=find( img_mask(i,:));
    row(i,1)=length(rowt);
end
for i=1:col_1
    [rowt, colt]=find( img_mask(:,i));
    col(i,1)=length(colt);
end
row_l=max(row(:));
col_l=max(col(:));

% find max col and its correspod row
if row_l>col_l
    [row, col]=find( img_mask);
    [col_max, p_max]=max(col);
    [col_min, p_min]=min(col);
    row_max=row(p_max);
    row_min=row(p_min);
else
    [row, col]=find( img_mask);
    [row_max, p_max]=max(row);
    [row_min, p_min]=min(row);
    col_max=col(p_max);
    col_min=col(p_min);
end

% calculate angle
angle = atan((row_max-row_min)/(col_max-col_min));
angle_d = rad2deg(angle);

% rotate
Img_preprocessed = imrotate(img,angle_d);
img_mask = imrotate(img_mask, angle_d);

%%  section 2 "crop"

rp = regionprops(img_mask, 'BoundingBox', 'Area');

area = [rp.Area].';
[~,ind] = max(area);
bb = rp(ind).BoundingBox;

img_mask = imcrop (img_mask, bb );
Img_preprocessed = imcrop (Img_preprocessed, bb);

%% section 3 "contrast & saturation"
saturation_index = 1.2; %set saturation multiplicator

img_hsv = rgb2hsv (Img_preprocessed);

img_hsv(:,:,3) = imadjust(img_hsv(:,:,3),[0.13 0.9],[]);
img_hsv(:,:,2) = img_hsv(:,:,2).*saturation_index;

Img_preprocessed = hsv2rgb(img_hsv);

end
