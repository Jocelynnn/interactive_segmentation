I = imread('./pick/361.jpg');
seg = imread('./pick-gt/361.png');
I = ceil((double(I) + 0.5) / 16);
seg = double(seg) / 255.0 > 0.5;
colorStat = zeros(16,16,16);
width = size(I, 2);
height = size(I,1);
for i = 1:height
for j = 1:width
if seg(i,j) == 1
colorStat(I(i,j,1),I(i,j,2),I(i,j,3)) = colorStat(I(i,j,1),I(i,j,2),I(i,j,3)) + 1;
end
end
end
colorStat = colorStat / sum(seg(:));
colorStat2 = reshape(colorStat, [16^3, 1]);
c = sort(colorStat2,'descend');
save main.mat c;