
ground_truth_path='./pick-gt/';
algorithm_1='/Users/jiangbingjie/Documents/imagesegmentation/pick/pick-seed7/1/';
algorithm_2='/Users/jiangbingjie/Documents/imagesegmentation/pick/pick-seed7/2/';
algorithm_3='/Users/jiangbingjie/Documents/imagesegmentation/pick/pick-seed7/3/';
algorithm_4='/Users/jiangbingjie/Documents/imagesegmentation/pick/pick-seed7/4/';

p_a1=[];
p_a2=[];
p_a3=[];
p_a4=[];
r_a1=[];
r_a2=[];
r_a3=[];
r_a4=[];


img_path_list = dir(strcat(algorithm_1,'*.png'));%��ȡ���ļ���������png��ʽ��ͼ��
img_num = length(img_path_list);%��ȡͼ��������

if img_num > 0 %������������ͼ��
        for j = 1:img_num %��һ��ȡͼ��
            image_name = img_path_list(j).name;% ͼ����
            image =  im2bw(imread(strcat(ground_truth_path,image_name)));
            disp(image_name);
            F_g=sum(image(:)==1);
            
             % �ҵ�ȥ����׺���ļ���
            name_size=size(image_name);
            for NNN=1:name_size(2);
                if image_name(NNN)=='.';
                name_num=NNN;%���µ��λ��
                end
            end
            im_name=image_name(1:name_num-1);%��֮ǰ�Ĳ���
%             disp(j);
%             disp(image_name);

            
            result_a1=imread(strcat(strcat(algorithm_1,im_name),'.png'));
            result_a1=im2bw(result_a1);
            F_s=sum(result_a1(:)==1);
            intersect=image&result_a1;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_a1=[p_a1;p];
            r_a1=[r_a1;r];
            
            
            result_a2=imread(strcat(strcat(algorithm_2,im_name),'.png'));
            result_a2=im2bw(result_a2);
            F_s=sum(result_a2(:)==1);
            intersect=image&result_a2;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_a2=[p_a2;p];
            r_a2=[r_a2;r];
            
            result_a3=imread(strcat(strcat(algorithm_3,im_name),'.png'));
            result_a3=im2bw(result_a3);
            F_s=sum(result_a3(:)==1);
            intersect=image&result_a3;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_a3=[p_a3;p];
            r_a3=[r_a3;r];
            
            result_a4=imread(strcat(strcat(algorithm_4,im_name),'.png'));
            result_a4=im2bw(result_a4);
            F_s=sum(result_a4(:)==1);
            intersect=image&result_a4;
            F_gs=sum(intersect(:)==1);
            p=F_gs/F_s;
            r=F_gs/F_g;
            p_a4=[p_a4;p];
            r_a4=[r_a4;r];
            
        
            
        end
end

save p_a1.mat p_a1;
save p_a2.mat p_a2;
save p_a3.mat p_a3;
save p_a4.mat p_a4;

save r_a1.mat r_a1;
save r_a2.mat r_a2;
save r_a3.mat r_a3;
save r_a4.mat r_a4;




% plot(p_a1,'r')
% hold on;
% plot(p_a2,'b');