% threshold: the ration of color which is regarded as main color

function mainColor=extractBMainColor(I,seg,dimension,threshold)
% dimension=16;
% threshold=0.05;
% I = imread('./pick/299.jpg');
% seg = imread('./pick-gt/299.png');
% I = ceil((double(I) + 0.5) / dimension);
I=  quantilize(I,ceil(256/dimension));
seg = double(seg) / 255.0 > 0.5;
colorStat = zeros(dimension,dimension,dimension);
width = size(I, 2);
height = size(I,1);
for i = 1:height
for j = 1:width
if seg(i,j) ~= 1
colorStat(I(i,j,1),I(i,j,2),I(i,j,3)) = colorStat(I(i,j,1),I(i,j,2),I(i,j,3)) + 1;
end
end
end
colorStat = colorStat / sum(seg(:));

I=find(colorStat>threshold);
[i1,i2,i3]=ind2sub(size(colorStat),I);
mainColor=[i1,i2,i3];
save mainColor.mat mainColor;
% colorStat2 = reshape(colorStat, [16^3, 1]);
% c = sort(colorStat2,'descend');
% save c.mat 'c';
end