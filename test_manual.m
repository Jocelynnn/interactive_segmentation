% ori_file_path='./pick/';
% marker_file_path =  '/Users/jiangbingjie/Documents/imagesegmentation/pick/pick-seed2/';% ͼ���ļ���·��
% seg_file_path='./pick-gt/';%ǰ�������ָ����ļ���
% 
% img='75.jpg';
% img2='75.png';
% im_original=imread(strcat(ori_file_path,img));
% im_marker=imread(strcat(marker_file_path,img2));
% im_seg=imread(strcat(seg_file_path,img2));
% 
% [percent_f]=manual_percent_front(im_original,im_marker,im_seg,299);
% [percent_b]=manual_percent_back(im_original,im_marker,~im_seg,299);


percent_front=[];
percent_back=[];


ori_file_path='./pick/';
marker_file_path =  '/Users/jiangbingjie/Documents/imagesegmentation/pick/pick-seed7/_gray/';% ͼ���ļ���·��
% marker_file_path='./pick-seed/'
seg_file_path='./pick-gt/';%ǰ�������ָ����ļ���


img_path_list = dir(strcat(marker_file_path,'*.png'));%��ȡ���ļ���������jpg��ʽ��ͼ��
img_num = length(img_path_list);%��ȡͼ��������
% disp(img_path_list);
disp(img_num);
index_front=cell(img_num);
index_back=cell(img_num);

if img_num > 0 %������������ͼ��
        for j = 1:img_num %��һ��ȡͼ��
            disp(j);
            
            image_name = img_path_list(j).name;% ͼ����
            % �ҵ�ȥ����׺���ļ���
            name_size=size(image_name);
            for NNN=1:name_size(2);
                if image_name(NNN)=='.';
                name_num=NNN;%���µ��λ��
                end
            end
            im_num=image_name(1:name_num-1);%��֮ǰ�Ĳ���
            
            im_original=imread(strcat(strcat(ori_file_path,im_num),'.jpg'));
            im_marker=imread(strcat(strcat(marker_file_path,im_num),'.png'));
            im_seg=imread(strcat(strcat(seg_file_path,im_num),'.png'));
            
            [percent_f,in_index_f]=manual_percent_front(im_original,im_marker,im_seg,im_num);
            [percent_b,in_index_b]=manual_percent_back(im_original,im_marker,~im_seg,im_num);
            
            [percent_front]=[percent_front;percent_f];
            [percent_back]=[percent_back;percent_b];
            
            index_front{j}=in_index_f';
            index_back{j}=in_index_b';
            
        end
        save percent_front.mat percent_front;
        save percent_back.mat percent_back;
        save index_front.mat index_front;
        save index_back.mat index_back;

end
            
            