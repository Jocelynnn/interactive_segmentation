% segments:the result of slic 
% im: rgb image
% im_seg: gray result of segmentation

function [features,validPixel]=processSegments(segments,im,im_seg)

perim = true(size(im,1), size(im,2));
dimension=8;

% number of features
featureCount=3;
% all the super pixels
maxPixelCount=max(segments(:));

features=zeros(maxPixelCount,featureCount);
% number of valid pixel
validPixel=zeros(maxPixelCount,1);
validCount=1;

%控制颜色块的大小，过小的滤去
threshold=100;
for k = 1 : maxPixelCount
    
    regionK = segments == k;
    I=im2double(im_seg).* regionK;
    % eliminate the boundary effect
    if(length(find(I==1))>threshold)
        
        mask=regionK;
        feature=extractRGBIndex(im,mask,dimension);
    %   the feature of the valid pixel
        features(validCount,:)=feature;
    %   the number of the pixwl
        validPixel(validCount)=k;
    %   total count of valid pixels   
        validCount=validCount+1;
        
        perimK = bwperim(regionK, 8);        
        perim(perimK) = false;
    end
    
end

% trim to size
features=features(1:validCount-1,:);
validPixel=validPixel(1:validCount-1,:);
save features.mat features;
save validPixel.mat validPixel;



%% show boundary
% perim = uint8(cat(3,perim,perim,perim));
% finalImage = im.* perim;
%  imagesc(finalImage);
%  axis image off ;hold on;
