function im_seg_single()
ori_file_path='./pick/';
marker_file_path =  './pick-seed/';% 图像文件夹路径
seg_file_path='./pick-gt/';%前景背景分割结果文件夹

im='101';
img='101.jpg';
img2='101.png';
im_original=imread(strcat(ori_file_path,img));
im_marker=imread(strcat(marker_file_path,img));
im_seg=imread(strcat(seg_file_path,img2));

[x_F,y_F]=markFront(im_original,im_marker,im_seg,im);
[x_B,y_B]=markBack(im_original,im_marker,~im_seg,im);

position_F=sortrows([x_F,y_F]);
position_B=sortrows([x_B,y_B]);

figure,imshow(im_original)
        hold on
   plot(x_F, y_F,'r.',x_B,y_B,'b.')
        hold off;

% figure,imshow(im_original)
%         hold on
%    plot(position_F(:,1), position_F(:,2),'r.-',position_B(:,1),position_B(:,2),'b.-')
%         hold off;

% cutSet=cutPoint(position_F,size(im_original,1),size(im_original,2));
% [m,n]=size(cutSet);
% X=[];
% Y=[];
% 
% figure,imshow(im_original)
%         hold on
%         
%     for i=1:m
%         [p,q]=size(cutSet{i});
%         if(q==1)
%             continue;
%         end
%         for j=1:q
%             X=[X,cutSet{i}{j}(:,1)];
%             Y=[Y,cutSet{i}{j}(:,2)];          
%             plot(X, Y,'r.-');
%         end
%     end  
%         hold off;

end