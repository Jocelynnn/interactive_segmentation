function extract_manual_label()
ori_file_path='./pick/';
marker_file_path =  './pick-seed/';% 图像文件夹路径
seg_file_path='./pick-gt/';%前景背景分割结果文件夹

img='1409.jpg';
img2='1409.png';
im_original=imread(strcat(ori_file_path,img));
im_marker=imread(strcat(marker_file_path,img));
im_seg=imread(strcat(seg_file_path,img2));

im_marker=im2double(rgb2gray(im_marker));
[x,y]=find(im_marker==1);
m_front=[y,x];
save m_front.mat m_front;
matlab2opencv( m_front, '/Users/jiangbingjie/Documents/opencv/opencv/opencv/m_front.yml');

[x,y]=find(im_marker==0);
m_back=[y,x];
save m_back.mat m_back;
matlab2opencv( m_back, '/Users/jiangbingjie/Documents/opencv/opencv/opencv/m_back.yml');

end