function extractFeature()

marker_file_path =  './pick-seed/';% ͼ���ļ���·��
seg_file_path='./pick-gt/';%ǰ�������ָ����ļ���
img_path_list = dir(strcat(marker_file_path,'*.jpg'));%��ȡ���ļ���������jpg��ʽ��ͼ��
img_num = length(img_path_list);%��ȡͼ��������
disp(img_num);
frontMarkerCount=zeros(1,1);
frontMarkerLength=zeros(1,1);
averageFMarkerLength=zeros(1,1);

backMarkerCount=zeros(1,1);
backMarkerLength=zeros(1,1);
averageBMarkerLength=zeros(1,1);

if img_num > 0 %������������ͼ��
        for j = 1:img_num %��һ��ȡͼ��
            image_name = img_path_list(j).name;% ͼ����
          
            % �ҵ�ȥ����׺���ļ���
            name_size=size(image_name);
            for NNN=1:name_size(2);
                if image_name(NNN)=='.';
                name_num=NNN;%���µ��λ��
                end
            end
            new_name=image_name(1:name_num-1);%��֮ǰ�Ĳ���
            new_name=strcat(new_name,'.png');
            
            disp(image_name);
            disp(new_name);
            
            %% ��ȡ�ָ���ͼƬ�ͱ�עͼƬ
            image =  rgb2gray(imread(strcat(marker_file_path,image_name)));
            image_seg= imread(strcat(seg_file_path,new_name));
            imshow(image_seg);
            [m,n]=size(image);
            
            %%��ȡǰ����ע��ǰ����������
            front_marker=zeros(m,n);
            front_marker(image==255)=255;
            front_total=sum(image_seg(:)==255);
              %����ǰ����ע���� ��Գ��� ƽ������
            [num,markerLength,averageLength]=count(image_name,front_marker,front_total);
            if(j==1)
                frontMarkerCount=num;
                frontMarkerLength=markerLength;
                averageFMarkerLength=averageLength;
            else
                frontMarkerCount=[frontMarkerCount,num];
                frontMarkerLength=[frontMarkerLength,markerLength];
                averageFMarkerLength=[averageFMarkerLength,averageLength];
            end
             
           %%��ȡ������ע�ͱ�����������
            back_marker=ones(m,n);
            back_marker(image==0)=0;
            back_total=sum(image_seg(:)==0);
            
            %���㱳����ע���� ��Գ��� ƽ������
            [num,markerLength,averageLength]=count(image_name,back_marker,back_total);
            if(j==1)
                backMarkerCount=num;
                backMarkerLength=markerLength;
                averageBMarkerLength=averageLength;
            else
                backMarkerCount=[backMarkerCount,num];
                backMarkerLength=[backMarkerLength,markerLength];
                averageBMarkerLength=[averageBMarkerLength,averageLength];
            end
            
        end
end

front_save_to=strcat('./result/frontCount.mat');
save(front_save_to,'frontMarkerCount');
front_length_save_to=strcat('./result/frontLength.mat');
save(front_length_save_to,'frontMarkerLength');
average_front_length_save_to=strcat('./result/averageFrontLength.mat');
save(average_front_length_save_to,'averageFMarkerLength');


back_save_to=strcat('./result/backCount.mat');
save(back_save_to,'backMarkerCount');
back_length_save_to=strcat('./result/backLength.mat');
save(back_length_save_to,'backMarkerLength');
average_back_length_save_to=strcat('./result/averageBackLength.mat');
save(average_back_length_save_to,'averageBMarkerLength');


end


