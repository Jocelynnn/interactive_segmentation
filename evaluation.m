% x=load('/Users/jiangbingjie/Documents/opencv/result/test.txt');

ground_truth_path='./pick-gt/';
auto_1='/Users/jiangbingjie/Documents/opencv/result_bw/radius=8/auto_1/';
auto_2='/Users/jiangbingjie/Documents/opencv/result_bw/radius=8/auto_2/';
auto_3='/Users/jiangbingjie/Documents/opencv/result_bw/radius=8/auto_3/';
manual='/Users/jiangbingjie/Documents/opencv/result_bw/radius=8/manual/';
same_g_1='/Users/jiangbingjie/Documents/opencv/result_bw/radius=8/same_group_1/';
same_g_2='/Users/jiangbingjie/Documents/opencv/result_bw/radius=8/same_group_2/';
same_g_3='/Users/jiangbingjie/Documents/opencv/result_bw/radius=8/same_group_3/';
same_r_1='/Users/jiangbingjie/Documents/opencv/result_bw/radius=8/same_rate_1/';
same_r_2='/Users/jiangbingjie/Documents/opencv/result_bw/radius=8/same_rate_2/';
same_r_3='/Users/jiangbingjie/Documents/opencv/result_bw/radius=8/same_rate_3/';
half_g_1='/Users/jiangbingjie/Documents/opencv/result_bw/radius=8/half_group_1/';
half_g_2='/Users/jiangbingjie/Documents/opencv/result_bw/radius=8/half_group_2/';
half_g_3='/Users/jiangbingjie/Documents/opencv/result_bw/radius=8/half_group_3/';
half_r_1='/Users/jiangbingjie/Documents/opencv/result_bw/radius=8/half_rate_1/';
half_r_2='/Users/jiangbingjie/Documents/opencv/result_bw/radius=8/half_rate_2/';
half_r_3='/Users/jiangbingjie/Documents/opencv/result_bw/radius=8/half_rate_3/';

p_auto_1=[];
r_auto_1=[];
p_auto_2=[];
r_auto_2=[];
p_auto_3=[];
r_auto_3=[];
p_same_group_1=[];
r_same_group_1=[];
p_same_group_2=[];
r_same_group_2=[];
p_same_group_3=[];
r_same_group_3=[];
p_same_rate_1=[];
r_same_rate_1=[];
p_same_rate_2=[];
r_same_rate_2=[];
p_same_rate_3=[];
r_same_rate_3=[];

p_half_group_1=[];
r_half_group_1=[];
p_half_group_2=[];
r_half_group_2=[];
p_half_group_3=[];
r_half_group_3=[];
p_half_rate_1=[];
r_half_rate_1=[];
p_half_rate_2=[];
r_half_rate_2=[];
p_half_rate_3=[];
r_half_rate_3=[];

p_m=[];
r_m=[];


img_path_list = dir(strcat(ground_truth_path,'*.png'));%获取该文件夹中所有png格式的图像
img_num = length(img_path_list);%获取图像总数量

if img_num > 0 %有满足条件的图像
        for j = 1:img_num %逐一读取图像
            image_name = img_path_list(j).name;% 图像名
            image =  im2bw(imread(strcat(ground_truth_path,image_name)));
            
            F_g=sum(image(:)==1);
            
             % 找到去除后缀的文件名
            name_size=size(image_name);
            for NNN=1:name_size(2);
                if image_name(NNN)=='.';
                name_num=NNN;%记下点的位置
                end
            end
            im_name=image_name(1:name_num-1);%点之前的部分
%             disp(j);
%             disp(image_name);

            %compared with result of half group of manual label
            im_half_group_1=imread(strcat(strcat(half_g_1,im_name),'.jpg'));
            im_half_group_1=im2bw(im_half_group_1);
            F_s=sum(im_half_group_1(:)==1);
            intersect=image&im_half_group_1;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_half_group_1=[p_half_group_1;p];
            r_half_group_1=[r_half_group_1;r];
            
            im_half_group_2=imread(strcat(strcat(half_g_2,im_name),'.jpg'));
            im_half_group_2=im2bw(im_half_group_2);
            F_s=sum(im_half_group_2(:)==1);
            intersect=image&im_half_group_2;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_half_group_2=[p_half_group_2;p];
            r_half_group_2=[r_half_group_2;r];
            
            im_half_group_3=imread(strcat(strcat(half_g_3,im_name),'.jpg'));
            im_half_group_3=im2bw(im_half_group_3);
            F_s=sum(im_half_group_3(:)==1);
            intersect=image&im_half_group_3;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_half_group_3=[p_half_group_3;p];
            r_half_group_3=[r_half_group_3;r];
            
            
            im_half_rate_1=imread(strcat(strcat(half_r_1,im_name),'.jpg'));
            im_half_rate_1=im2bw(im_half_rate_1);
            F_s=sum(im_half_rate_1(:)==1);
            intersect=image&im_half_rate_1;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_half_rate_1=[p_half_rate_1;p];
            r_half_rate_1=[r_half_rate_1;r];
            
            im_half_rate_2=imread(strcat(strcat(half_r_2,im_name),'.jpg'));
            im_half_rate_2=im2bw(im_half_rate_2);
            F_s=sum(im_half_rate_2(:)==1);
            intersect=image&im_half_rate_2;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_half_rate_2=[p_half_rate_2;p];
            r_half_rate_2=[r_half_rate_2;r];
            
            im_half_rate_3=imread(strcat(strcat(half_r_3,im_name),'.jpg'));
            im_half_rate_3=im2bw(im_half_rate_3);
            F_s=sum(im_half_rate_3(:)==1);
            intersect=image&im_half_rate_3;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_half_rate_3=[p_half_rate_3;p];
            r_half_rate_3=[r_half_rate_3;r];
            
        
            
            %compared with result of manual label-1
            im_manual=imread(strcat(strcat(manual,im_name),'.jpg'));
            im_manual=im2bw(im_manual);
            F_s=sum(im_manual(:)==1);
            intersect=image&im_manual;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_m=[p_m;p];
            r_m=[r_m;r];
            
            %compared with result of auto generated label-1
            im_auto_1=imread(strcat(strcat(auto_1,im_name),'.jpg'));
            im_auto_1=im2bw(im_auto_1);
            F_s=sum(im_auto_1(:)==1);
            intersect=image&im_auto_1;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_auto_1=[p_auto_1;p];
            r_auto_1=[r_auto_1;r];
            
            im_auto_2=imread(strcat(strcat(auto_2,im_name),'.jpg'));
            im_auto_2=im2bw(im_auto_2);
            F_s=sum(im_auto_2(:)==1);
            intersect=image&im_auto_2;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_auto_2=[p_auto_2;p];
            r_auto_2=[r_auto_2;r];
            
            im_auto_3=imread(strcat(strcat(auto_3,im_name),'.jpg'));
            im_auto_3=im2bw(im_auto_3);
            F_s=sum(im_auto_3(:)==1);
            intersect=image&im_auto_3;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_auto_3=[p_auto_3;p];
            r_auto_3=[r_auto_3;r];
%             
%             
            %compared with result of same group-1
            im_same_group_1=imread(strcat(strcat(same_g_1,im_name),'.jpg'));
            im_same_group_1=im2bw(im_same_group_1);
            F_s=sum(im_same_group_1(:)==1);
            intersect=image&im_same_group_1;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_same_group_1=[p_same_group_1;p];
            r_same_group_1=[r_same_group_1;r];
            
            im_same_group_2=imread(strcat(strcat(same_g_2,im_name),'.jpg'));
            im_same_group_2=im2bw(im_same_group_2);
            F_s=sum(im_same_group_2(:)==1);
            intersect=image&im_same_group_2;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_same_group_2=[p_same_group_2;p];
            r_same_group_2=[r_same_group_2;r];
            
            im_same_group_3=imread(strcat(strcat(same_g_3,im_name),'.jpg'));
            im_same_group_3=im2bw(im_same_group_3);
            F_s=sum(im_same_group_3(:)==1);
            intersect=image&im_same_group_3;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_same_group_3=[p_same_group_3;p];
            r_same_group_3=[r_same_group_3;r];
            
            
            %compared with result of same rate-1
            im_same_rate_1=imread(strcat(strcat(same_r_1,im_name),'.jpg'));
            im_same_rate_1=im2bw(im_same_rate_1);
            F_s=sum(im_same_rate_1(:)==1);
            intersect=image&im_same_rate_1;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_same_rate_1=[p_same_rate_1;p];
            r_same_rate_1=[r_same_rate_1;r];
            
            im_same_rate_2=imread(strcat(strcat(same_r_2,im_name),'.jpg'));
            im_same_rate_2=im2bw(im_same_rate_2);
            F_s=sum(im_same_rate_2(:)==1);
            intersect=image&im_same_rate_2;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_same_rate_2=[p_same_rate_2;p];
            r_same_rate_2=[r_same_rate_2;r];
            
            im_same_rate_3=imread(strcat(strcat(same_r_3,im_name),'.jpg'));
            im_same_rate_3=im2bw(im_same_rate_3);
            F_s=sum(im_same_rate_3(:)==1);
            intersect=image&im_same_rate_3;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_same_rate_3=[p_same_rate_3;p];
            r_same_rate_3=[r_same_rate_3;r];
            
        end
end


save p_auto_1.mat p_auto_1;
save p_auto_2.mat p_auto_2;
save p_auto_3.mat p_auto_3;
save p_same_group_1.mat p_same_group_1;
save p_same_group_2.mat p_same_group_2;
save p_same_group_3.mat p_same_group_3;
save p_same_rate_1.mat p_same_rate_1;
save p_same_rate_2.mat p_same_rate_2;
save p_same_rate_3.mat p_same_rate_3;
save p_m.mat p_m;
 
save r_auto_1.mat r_auto_1;
save r_auto_2.mat r_auto_2;
save r_auto_3.mat r_auto_3;
save r_same_group_1.mat r_same_group_1;
save r_same_group_2.mat r_same_group_2;
save r_same_group_3.mat r_same_group_3;
save r_same_rate_1.mat r_same_rate_1;
save r_same_rate_2.mat r_same_rate_2;
save r_same_rate_3.mat r_same_rate_3;
save r_m.mat r_m;


save p_half_group_1.mat p_half_group_1;
save p_half_group_2.mat p_half_group_2;
save p_half_group_3.mat p_half_group_3;
save p_half_rate_1.mat p_half_rate_1;
save p_half_rate_2.mat p_half_rate_2;
save p_half_rate_3.mat p_half_rate_3;

save r_half_group_1.mat r_half_group_1;
save r_half_group_2.mat r_half_group_2;
save r_half_group_3.mat r_half_group_3;
save r_half_rate_1.mat r_half_rate_1;
save r_half_rate_2.mat r_half_rate_2;
save r_half_rate_3.mat r_half_rate_3;



