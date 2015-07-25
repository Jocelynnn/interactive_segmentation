function [feature]=extractRGBIndex(I,mask,dimension)
% dimension=8;
% I=rgb2hsv(I);
% I=  quantilize(I,16);
% mask = double(mask) / 255.0 > 0.5;
totalPixel=sum(mask(:));
R=im2double(I(:,:,1)).* mask;
G=im2double(I(:,:,2)).* mask;
B=im2double(I(:,:,3)).* mask;

r_value=quantilize(sum(R(:))*255/totalPixel,ceil(256/dimension));
g_value=quantilize(sum(G(:))*255/totalPixel,ceil(256/dimension));
b_value=quantilize(sum(B(:))*255/totalPixel,ceil(256/dimension));

feature=[r_value,g_value,b_value];



% dimension=16;
% step=ceil(256/dimension);
% 
% r_index=ceil(r_value/step);
% g_index=ceil(g_value/step);
% b_index=ceil(b_value/step);

% feature=[r_index,g_index,b_index];
end