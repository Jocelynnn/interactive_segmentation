function [num,length,averageLength]=count(image_name,source,source_total)
% figure,imshow(source);

imshow(source);
%骨骼化 去毛刺
BW=bwmorph(imfill(source,'holes'),'skel',inf);
BW1=bwmorph(BW,'spur',9); % N自行调整,表明执行去毛刺操作的次数

imshow(BW1);

%% 连通域个数
[L,num] = bwlabel(BW1,8);


%%归一化方法一：计算缩放系数


%%归一化方法二：将图像缩放

%% 连通域周长，因宽度一定，可视为长度
STATS = regionprops(L,'all');
length=zeros(1,num);
sum=0;
for i=1:num
%     if(STATS(i).Perimeter==0)
%         disp(image_name);
%     end
    
    length(i)=normalize(STATS(i).Perimeter,source_total);
    sum=sum+length(i);
end
averageLength=sum/num;
end


function result=normalize(perimeter,total)
   %前景像素数/标准像素数
    total=total/(100*100);
    result=perimeter/total;

end