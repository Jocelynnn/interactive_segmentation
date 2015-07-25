im=imread('279.jpg');
[l, Am, C] = slic(im, 50, 10, 1, 'median');
imshow(drawregionboundaries(l, im, [255 255 255]));
