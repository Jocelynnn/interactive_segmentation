function [x,y]=markFront(im_original,im_marker,im_seg,im_num)

[m,n,k]=size(im_original);

for i=1:m
    for j=1:n
        if(im_seg(i,j)==255)
            im_original(i,j,1)=0;
            im_original(i,j,2)=0;
            im_original(i,j,3)=0;
        end
    end
end
% imshow(im_original);


%% vl_slic �����طָ�
regionSize=20;
regularizer=0.01;
[segments]=use_slic(im_original,regionSize,regularizer);

% process each region
[features,validPixel]=processSegments(segments,im_original,im_seg);

% extract main color
dimension=8;
threshold=0.01;
mainColor=extractBMainColor(im_original,im_seg,dimension,threshold);

% result of classification
[rowset,rowcount]=classifySuperpixels(mainColor,features,validPixel);

%��ע������ ��ע�ĳ��� Ӧ�ɷֲ����
%                                                                                     
lineCount=1;
lineCapacity=5;


% fprintf('%d lines,each %d points \n',lineCount,rowcount)
cell={};
%%��ÿһ���ߣ����ȡÿ�������е�һ��ɫ�鹹�ɸ�����
for i=1:lineCount
  % ��ÿ�����������ȡɫ�飬����һ��ֱ���Ͽ��ܳ��ֵĵ�
  line=zeros(rowcount,1);
   for j=1:rowcount
    row=rowset(j,:);
    pos=max(find(row~=0));
    line(j,:)=ceil(rand(1,1)*pos);
   end
%   disp(line);

  %������ȡ������ÿ��ɫ������� ������������
  centers_back=[];
  for j=1:rowcount
      regionK = (segments == rowset(j,line(j)));
      I=im2double(im_seg).* regionK;
      BW = im2bw(I);
      s  = regionprops(BW, 'centroid');
      centroids = cat(1, s.Centroid);
      centroids =[ mean(centroids(:,1)),mean(centroids(:,2))];
%       disp(centroids);
      centers_back=[centers_back;centroids]; 
%       disp(size(centers));
  end 
  
  cell{i}=centers_back;
end

%% ��ʱֻȡ��һ����
centers_back=cell{1};
x=centers_back(:,1);
y=centers_back(:,2);
% save centers_BACK.mat centers_back;

filepath='/Users/jiangbingjie/Documents/opencv/input/auto/1/back/';
filepath=strcat(filepath,im_num);
filepath=strcat(filepath,'.yml');
matlab2opencv( centers_back, filepath);


% figure,imshow(im_original)
%         hold on
%    plot(centers(:,1), centers(:,2), 'y*')
%         hold off;

        
end