% 1 ǰ�� 2 ���� 0 ��ȷ��
% ���� ��ɫ-��Ϊ2
% ǰ�� ��ɫ-��Ϊ1
% ����-0

function convert_to_gsc()
 file_path =  '/Users/jiangbingjie/Documents/imagesegmentation/pick/pick-seed2/_gray/';% ͼ���ļ���·��
 ori_path ='/Users/jiangbingjie/Documents/imagesegmentation/pick/pick/';
 
 img_path_list = dir(strcat(file_path,'*.png'));%��ȡ���ļ���������jpg��ʽ��ͼ��
 img_num = length(img_path_list);%��ȡͼ��������
if img_num > 0 %������������ͼ��
        for j = 1:1 %��һ��ȡͼ��
            image_name = img_path_list(j).name;% ͼ����
            disp(image_name);
             % �ҵ�ȥ����׺���ļ���
            name_size=size(image_name);
            for NNN=1:name_size(2);
                if image_name(NNN)=='.';
                name_num=NNN;%���µ��λ��
                end
            end
            im_num=image_name(1:name_num-1);%��֮ǰ�Ĳ���
            disp(im_num);
            
            im_marker=im2double(imread(strcat(strcat(file_path,im_num),'.png')));
            [m,n]=size(im_marker);
            labels=zeros(m,n);
            
            labels(im_marker==1)=1;
            labels(im_marker==0)=2;
%             disp(im_result);
            img=imread(strcat(strcat(ori_path,im_num),'.jpg'));
            
            
            % Make segmentation options
%             opts=bj.segOpts(); % You can use other methods such as gsc.opts() or gscSeq.opts();
            opts=gsc.opts();

% Customise the options if you need
            opts.postProcess=1;
            opts.gcGamma=150;

% Intialize the segmentation object 
            segH=bj.segEngine(0,opts); % Again, you can use other methods such as gsc.segEngine() or
                           % gscSeq.segEngine(), but make sure you call the same
                           % package you used to build the options for

% preProcess image
            segH.preProcess(im2double(img)); % Only takes in double images

% Get the first segmentation
            ok=segH.start(labels);

% You can access the segmentation obtained using
            figure;imshow(segH.seg);

% Delete the segmentation object
            delete(segH);

% Another function that is more useful in an interactive setting is
% updateSeg -- for making edits to the obtained segmentation 
% you should call segH.updateSeg(newLabels) where newLabels would be the updated
% brush strokes. In an offline setting, you probably dont need to call updateSeg


            
        end
end



end