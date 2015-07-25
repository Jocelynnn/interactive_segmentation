ori_file_path='./pick/';
marker_file_path =  './pick-seed/';% ͼ���ļ���·��
seg_file_path='./pick-gt/';%ǰ�������ָ����ļ���

img='1409.jpg';
img2='1409.png';



img_path_list = dir(strcat(ori_file_path,'*.jpg'));%��ȡ���ļ���������jpg��ʽ��ͼ��
img_num = length(img_path_list);%��ȡͼ��������

if img_num > 0 %������������ͼ��
        for j = 1:img_num %��һ��ȡͼ��
            image_name = img_path_list(j).name;% ͼ����
            image =  imread(strcat(ori_file_path,image_name));
            % �ҵ�ȥ����׺���ļ���
            name_size=size(image_name);
            for NNN=1:name_size(2);
                if image_name(NNN)=='.';
                name_num=NNN;%���µ��λ��
                end
            end
            im_num=image_name(1:name_num-1);%��֮ǰ�Ĳ���
%             disp(im_num);
            
            
            %% generate auto label
            im_original=imread(strcat(strcat(ori_file_path,im_num),'.jpg'));
            im_marker=imread(strcat(strcat(marker_file_path,im_num),'.jpg'));
            im_seg=imread(strcat(strcat(seg_file_path,im_num),'.png'));
            
%             markFront(im_original,im_marker,im_seg,im_num);
%             markBack(im_original,im_marker,~im_seg,im_num);
            
            %% extract manual label
            im_marker=im2double(rgb2gray(im_marker));
              
            [x,y]=find(im_marker==1);
            m_front=[y,x];
            filepath='/Users/jiangbingjie/Documents/opencv/input/manual/front/';
            filepath=strcat(filepath,im_num);
            filepath=strcat(filepath,'.yml');
            matlab2opencv( m_front,filepath);

            [x,y]=find(im_marker==0);
            m_back=[y,x];
            filepath='/Users/jiangbingjie/Documents/opencv/input/manual/back/';
            filepath=strcat(filepath,im_num);
            filepath=strcat(filepath,'.yml');
            matlab2opencv( m_back, filepath);

        end
end
