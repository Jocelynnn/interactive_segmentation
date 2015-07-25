marker_file_path =  '/Users/jiangbingjie/Documents/imagesegmentation/pick/pick-seed4/';% ͼ���ļ���·��

% ǰ����עΪ��ɫ ������עΪ��ɫ
img_path_list = dir(strcat(marker_file_path,'*.png'));%��ȡ���ļ���������jpg��ʽ��ͼ��
img_num = length(img_path_list);%��ȡͼ��������

if img_num > 0 %������������ͼ��
        for count = 1:img_num %��һ��ȡͼ��
            
            image_name = img_path_list(count).name;% ͼ����
            image =  imread(strcat(marker_file_path,image_name));
            % �ҵ�ȥ����׺���ļ���
            name_size=size(image_name);
            for NNN=1:name_size(2);
                if image_name(NNN)=='.';
                name_num=NNN;%���µ��λ��
                end
            end
            im_num=image_name(1:name_num-1);%��֮ǰ�Ĳ���
            
            [m,n,k]=size(image);
            result=ones(m,n)/2;
            
            image_hsv=rgb2hsv(image)*360;
            H = image(:,:,1)*255;
            S = image(:,:,2)*255;
            V = image(:,:,3)*255;

            for i=1:m
                for j=1:n
                    if(image(i,j,1)==255&&image(i,j,2)==255&&image(i,j,3)==255)
                        continue;
                    end
%                     if(image(i,j,1)==0&&image(i,j,2)==0&&image(i,j,3)==255)
%                         result(i,j)=0;
%                     end
                        
                        if(image_hsv(i,j,1)==240)
                            result(i,j)=0;
                        else
                            result(i,j)=1;
                        end
                        
                        
    
                end
            end
            result_path=strcat('/Users/jiangbingjie/Documents/imagesegmentation/pick/pick-seed4/_gray/',im_num);
            result_path=strcat(result_path,'.png');
            imwrite(result,result_path);
        end
end
