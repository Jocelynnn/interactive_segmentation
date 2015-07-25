marker_file_path =  '/Users/jiangbingjie/Documents/imagesegmentation/pick/pick-seed4/';% 图像文件夹路径

% 前景标注为白色 背景标注为黑色
img_path_list = dir(strcat(marker_file_path,'*.png'));%获取该文件夹中所有jpg格式的图像
img_num = length(img_path_list);%获取图像总数量

if img_num > 0 %有满足条件的图像
        for count = 1:img_num %逐一读取图像
            
            image_name = img_path_list(count).name;% 图像名
            image =  imread(strcat(marker_file_path,image_name));
            % 找到去除后缀的文件名
            name_size=size(image_name);
            for NNN=1:name_size(2);
                if image_name(NNN)=='.';
                name_num=NNN;%记下点的位置
                end
            end
            im_num=image_name(1:name_num-1);%点之前的部分
            
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
