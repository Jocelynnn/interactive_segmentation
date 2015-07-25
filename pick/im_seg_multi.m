ori_file_path='./pick/';
marker_file_path =  './pick-seed/';% 图像文件夹路径
seg_file_path='./pick-gt/';%前景背景分割结果文件夹

img='1409.jpg';
img2='1409.png';



img_path_list = dir(strcat(ori_file_path,'*.jpg'));%获取该文件夹中所有jpg格式的图像
img_num = length(img_path_list);%获取图像总数量

if img_num > 0 %有满足条件的图像
        for j = 1:img_num %逐一读取图像
            image_name = img_path_list(j).name;% 图像名
            image =  imread(strcat(ori_file_path,image_name));
            % 找到去除后缀的文件名
            name_size=size(image_name);
            for NNN=1:name_size(2);
                if image_name(NNN)=='.';
                name_num=NNN;%记下点的位置
                end
            end
            im_num=image_name(1:name_num-1);%点之前的部分
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
