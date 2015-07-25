function [num,length,averageLength]=count(image_name,source,source_total)
% figure,imshow(source);

imshow(source);
%������ ȥë��
BW=bwmorph(imfill(source,'holes'),'skel',inf);
BW1=bwmorph(BW,'spur',9); % N���е���,����ִ��ȥë�̲����Ĵ���

imshow(BW1);

%% ��ͨ�����
[L,num] = bwlabel(BW1,8);


%%��һ������һ����������ϵ��


%%��һ������������ͼ������

%% ��ͨ���ܳ�������һ��������Ϊ����
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
   %ǰ��������/��׼������
    total=total/(100*100);
    result=perimeter/total;

end