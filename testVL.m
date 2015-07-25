im=imread('./pick/279.jpg');
im_seg=imread('./pick-gt/279.png');
%% test quick sift
% I=im;
% ratio = 0.5;
% kernelsize = 2;
% maxdist = 10;
% Iseg = vl_quickseg(I, ratio, kernelsize, maxdist);
% imshow(Iseg);

%% test slic
im2=im;
im = im2single(im) ;

% im = im(1:128,end-128+1:end,:) ;

figure(1) ; clf ;
image(im) ;
axis equal off tight ;
vl_demo_print('slic_image') ;

regionSize=30;
regularizer=1;
segments = vl_slic(im, regionSize, regularizer, 'verbose') ;

%  % overaly segmentation
%     [sx,sy]=vl_grad(double(segments), 'type', 'forward') ;
%     s = find(sx | sy) ;
%     imp = im ;
%     imp([s s+numel(im(:,:,1)) s+2*numel(im(:,:,1))]) = 0 ;
% 
%     imagesc(imp) ; axis image off ;
%     text(5,5,sprintf('regionSize:%.2g\nregularizer:%.2g', regionSize, regularizer), ...
%          'Background', 'white','VerticalAlignment','top')

%% another way to show
%      imshow(showSegments(segments));

showSegments(segments,im2,im_seg);
