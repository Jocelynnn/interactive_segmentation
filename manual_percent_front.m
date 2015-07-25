function [percent,in_index]=manual_percent_front(im_original,im_marker,im_seg,im_num)
[m,n,k]=size(im_original);

for i=1:m
    for j=1:n
        if(im_seg(i,j)~=255)
            im_original(i,j,1)=0;
            im_original(i,j,2)=0;
            im_original(i,j,3)=0;
        end
    end
end
% imshow(im_original);
regionSize=20;
regularizer=0.01;
[segments]=use_slic(im_original,regionSize,regularizer);

% process each region
[features,validPixel]=processSegments(segments,im_original,im_seg);

dimension=8;
threshold=0.01;
mainColor=extractFMainColor(im_original,im_seg,dimension,threshold);

% result of classification +filter
[rowset,rowcount]=classifySuperpixels(mainColor,features,validPixel);

% 记得改掉！！！！

% im_marker=im2double(rgb2gray(im_marker));
 im_marker=im2double(im_marker);
 
front=im_marker;
front(front~=1)=0;
[x,y,val]=find(segments(front==1));
% disp(val);

%找到人工标注覆盖的像素group编号
incount=0;
in_index=[];
for j=1:rowcount
    row=rowset(j,:);
    pos=max(find(row~=0));
    
    for i=1:pos
        current=rowset(j,i);
        if(any(val==current))
%             disp(current);
            incount=incount+1;
            in_index=[in_index;j];
            break;
        end
    end
end

% disp(incount/rowcount);
percent=incount/rowcount;

% disp(in_index);

% %%取与人工标注相同的像素group 即rowset中取相同的行
% line=zeros(incount,1);
% for i=1:incount
%     row=rowset(in_index(i),:);
%     pos=max(find(row~=0));
%     line(i,:)=ceil(rand(1,1)*pos);
% end
% 
% % disp(line);
% 
% %取集合中每个色块的中心 生成折线
%   centers_front=[];
%   for j=1:incount 
%       regionK = (segments == rowset(in_index(j),line(j)));
%       I=im2double(im_seg).* regionK;
%       BW = im2bw(I);
%       s  = regionprops(BW, 'centroid');
%       centroids = cat(1, s.Centroid);
%       centroids =[ mean(centroids(:,1)),mean(centroids(:,2))];
% %       disp(centroids);
%       centers_front=[centers_front;centroids]; 
% %       disp(size(centers));
%   end
%   
% filepath='/Users/jiangbingjie/Documents/opencv/input/manual_same_group/3/front/';
% filepath=strcat(filepath,im_num);
% filepath=strcat(filepath,'.yml');
% matlab2opencv( centers_front,filepath);
% 
% 
% %%取与人工标注相同比例的像素group，即rowset中相同比例的行数
% target_index=[];
% line=zeros(incount,1);
% for i=1:incount 
%     while(1)
%         current=ceil(rand(1,1)*rowcount);
% %         disp(current);
%         if(~any(target_index==current))
%             target_index=[target_index;current];
%             row=rowset(current,:);
%             pos=max(find(row~=0));
%             line(i,:)=ceil(rand(1,1)*pos);            
%             break;
%         end
%     end
% end
% 
% % disp(line);
% 
% %取集合中每个色块的中心 生成折线
%   centers_front=[];
%   for j=1:incount
%       regionK = (segments == rowset(target_index(j),line(j)));
%       I=im2double(im_seg).* regionK;
%       BW = im2bw(I);
%       s  = regionprops(BW, 'centroid');
%       centroids = cat(1, s.Centroid);
%       centroids =[ mean(centroids(:,1)),mean(centroids(:,2))];
% %       disp(centroids);
%       centers_front=[centers_front;centroids]; 
% %       disp(size(centers));
%   end
%   
% % filepath='/Users/jiangbingjie/Documents/opencv/input/manual_same_rate/3/front/';
% % filepath=strcat(filepath,im_num);
% % filepath=strcat(filepath,'.yml');
% % matlab2opencv( centers_front,filepath);
% 
% 
% ratio=1/2;
% 
% %%取与人工标注相同的像素group 即rowset中取相同的行
% line=zeros(incount,1);
% for i=1:incount
%     row=rowset(in_index(i),:);
%     pos=max(find(row~=0));
%     line(i,:)=ceil(rand(1,1)*pos);
% end
% 
% % disp(line);
% 
% %取集合中每个色块的中心 生成折线
%   centers_front=[];
%   for j=1:incount *ratio  % half the group
%       regionK = (segments == rowset(in_index(j),line(j)));
%       I=im2double(im_seg).* regionK;
%       BW = im2bw(I);
%       s  = regionprops(BW, 'centroid');
%       centroids = cat(1, s.Centroid);
%       centroids =[ mean(centroids(:,1)),mean(centroids(:,2))];
% %       disp(centroids);
%       centers_front=[centers_front;centroids]; 
% %       disp(size(centers));
%   end
%   
% % filepath='/Users/jiangbingjie/Documents/opencv/input/manual_half_group/3/front/';
% % filepath=strcat(filepath,im_num);
% % filepath=strcat(filepath,'.yml');
% % matlab2opencv( centers_front,filepath);
% 
% 
% %%取与人工标注相同比例的像素group，即rowset中相同比例的行数
% target_index=[];
% line=zeros(incount,1);
% for i=1:incount *ratio %half the rate
%     while(1)
%         current=ceil(rand(1,1)*rowcount);
% %         disp(current);
%         if(~any(target_index==current))
%             target_index=[target_index;current];
%             row=rowset(current,:);
%             pos=max(find(row~=0));
%             line(i,:)=ceil(rand(1,1)*pos);            
%             break;
%         end
%     end
% end
% 
% % disp(line);
% 
% %取集合中每个色块的中心 生成折线
%   centers_front=[];
%   for j=1:incount * ratio
%       regionK = (segments == rowset(target_index(j),line(j)));
%       I=im2double(im_seg).* regionK;
%       BW = im2bw(I);
%       s  = regionprops(BW, 'centroid');
%       centroids = cat(1, s.Centroid);
%       centroids =[ mean(centroids(:,1)),mean(centroids(:,2))];
% %       disp(centroids);
%       centers_front=[centers_front;centroids]; 
% %       disp(size(centers));
%   end
%   
% % filepath='/Users/jiangbingjie/Documents/opencv/input/manual_half_rate/3/front/';
% % filepath=strcat(filepath,im_num);
% % filepath=strcat(filepath,'.yml');
% % matlab2opencv( centers_front,filepath);


end