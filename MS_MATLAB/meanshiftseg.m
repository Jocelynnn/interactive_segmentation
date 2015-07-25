function [MS_reg,pUnRegion,region_index_sum,region_index_n] = meanshiftseg(A,nThreshold)
%*-------------------------------------------------------------------------
%*   作者  ：pineapple 时间  ：2007.5.23
%*   联系方式 ：QQ (94031570) Email(fanjun6294832@163.com)
%*-------------------------------------------------------------------------
%*   函数说明：[MS_reg,pUnRegion] =meanshiftseg(A,nThreshold)
%*   输入参数：
%*           A：  经meanshift平滑过后的灰度图象
%*   输出参数：
%*           MS_reg： 分割后的图像，被分割成连续的区域部分的像素值是其区域内的均值
%*           pUnRegion: 分割后的图像的标志图像，不同区域用不同的编号表示
%
A = double(A);
[m,n] = size(A);
MS_reg = zeros(m,n);
nDx = [-1 0 1 0];
nDy = [0 1 0 -1];
pUnRegion = zeros(m,n); %   用来标志当前像素点有没有被处理
region_index = 0;   %   记录按当前规则进行分割后，得到的总的类别数
region_index_n = zeros(1,m*n); %    记录每个类别中的像素点的个数
region_index_sum = zeros(1,m*n); %  记录每个类别中的像素点的值的和

pnGrowQueX = zeros(1,m*n);
pnGrowQueY = zeros(1,m*n); % 定义堆栈

for i=1:m
    for j=1:n
            if(pUnRegion(i,j)==0)  %如果当前点没有被处理
                region_index = region_index + 1;
                pUnRegion(i,j) = region_index;
                % 对应该区域的点数加1
                region_index_n(region_index)=region_index_n(region_index)+1;
                
                region_index_sum(region_index)=region_index_sum(region_index) +A(i,j); % 更新该类别的和
                nStart = 1;
                nEnd = 1;
               % 设置种子点为当前点
                pnGrowQueX(nEnd) = i;
                pnGrowQueY(nEnd) = j;
                
                while nStart<=nEnd
                    % 当前种子点的坐标
                    nCurrX = pnGrowQueX(nStart);
                    nCurrY = pnGrowQueY(nStart);
                    
                    % 对当前点的4邻域进行遍历
                    for k=1:4
                        xx = nCurrX + nDx(k);
                        yy = nCurrY + nDy(k);
                    % pUnRegion[yy*nWidth+xx]==0 表示还没有处理	
					% 生长条件：判断象素(xx，yy)和当前象素(nCurrX,nCurrY) 
                    % 象素值差的绝对值
                        if((yy<=n)&(yy>=1)&(xx<=m)&(xx>=1)...
                            &(pUnRegion(xx,yy)==0)...
                            &abs(A(xx,yy)-A(nCurrX,nCurrY))<nThreshold)              
                            nEnd=nEnd + 1; % 堆栈的尾部指针后移一位
                            % 象素(xx，yy) 压入栈
                            pnGrowQueX(nEnd) = xx;
							pnGrowQueY(nEnd) = yy;
                            
                            % 把象素(xx，yy)设置成region_index
							% 同时也表明该象素处理过
                            pUnRegion(xx,yy) = region_index;
                            
                            % 对应该区域的点数加1
                            region_index_n(region_index)=region_index_n(region_index)+1;
                            %  更新该类别的和
                            region_index_sum(region_index)=region_index_sum(region_index) +A(xx,yy);
                        end
                    end
                    nStart=nStart+1;
                end % 
            end
    end
end
      
      for i=1:m
          for j = 1 :n
                  temp = pUnRegion(i,j);
                  MS_reg(i,j) = round(region_index_sum(temp)/region_index_n(temp));
          end
      end
MS_reg = uint8(MS_reg);
                       
                        
                        
                        


                    
        





