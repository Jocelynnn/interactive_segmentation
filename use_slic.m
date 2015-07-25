function segments=use_slic(im,regionSize,regularizer)
im = im2single(im) ;
% im = im(1:128,end-128+1:end,:) ;

% figure(1) ; clf ;
% image(im) ;
axis equal off tight ;
vl_demo_print('slic_image') ;

% get segments,more like a map, pixels in superpixel k is labeled as k
segments = vl_slic(im, regionSize, regularizer, 'verbose') ;




%% show
%     [sx,sy]=vl_grad(double(segments), 'type', 'forward') ;
%     s = find(sx | sy) ;
%     imp = im ;
%     imp([s s+numel(im(:,:,1)) s+2*numel(im(:,:,1))]) = 0 ;
% 
%     imagesc(imp) ; axis image off ;
%     text(5,5,sprintf('regionSize:%.2g\nregularizer:%.2g', regionSize, regularizer), ...
%          'Background', 'white','VerticalAlignment','top') 

end