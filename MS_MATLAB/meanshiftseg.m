function [MS_reg,pUnRegion,region_index_sum,region_index_n] = meanshiftseg(A,nThreshold)
%*-------------------------------------------------------------------------
%*   ����  ��pineapple ʱ��  ��2007.5.23
%*   ��ϵ��ʽ ��QQ (94031570) Email(fanjun6294832@163.com)
%*-------------------------------------------------------------------------
%*   ����˵����[MS_reg,pUnRegion] =meanshiftseg(A,nThreshold)
%*   ���������
%*           A��  ��meanshiftƽ������ĻҶ�ͼ��
%*   ���������
%*           MS_reg�� �ָ���ͼ�񣬱��ָ�����������򲿷ֵ�����ֵ���������ڵľ�ֵ
%*           pUnRegion: �ָ���ͼ��ı�־ͼ�񣬲�ͬ�����ò�ͬ�ı�ű�ʾ
%
A = double(A);
[m,n] = size(A);
MS_reg = zeros(m,n);
nDx = [-1 0 1 0];
nDy = [0 1 0 -1];
pUnRegion = zeros(m,n); %   ������־��ǰ���ص���û�б�����
region_index = 0;   %   ��¼����ǰ������зָ�󣬵õ����ܵ������
region_index_n = zeros(1,m*n); %    ��¼ÿ������е����ص�ĸ���
region_index_sum = zeros(1,m*n); %  ��¼ÿ������е����ص��ֵ�ĺ�

pnGrowQueX = zeros(1,m*n);
pnGrowQueY = zeros(1,m*n); % �����ջ

for i=1:m
    for j=1:n
            if(pUnRegion(i,j)==0)  %�����ǰ��û�б�����
                region_index = region_index + 1;
                pUnRegion(i,j) = region_index;
                % ��Ӧ������ĵ�����1
                region_index_n(region_index)=region_index_n(region_index)+1;
                
                region_index_sum(region_index)=region_index_sum(region_index) +A(i,j); % ���¸����ĺ�
                nStart = 1;
                nEnd = 1;
               % �������ӵ�Ϊ��ǰ��
                pnGrowQueX(nEnd) = i;
                pnGrowQueY(nEnd) = j;
                
                while nStart<=nEnd
                    % ��ǰ���ӵ������
                    nCurrX = pnGrowQueX(nStart);
                    nCurrY = pnGrowQueY(nStart);
                    
                    % �Ե�ǰ���4������б���
                    for k=1:4
                        xx = nCurrX + nDx(k);
                        yy = nCurrY + nDy(k);
                    % pUnRegion[yy*nWidth+xx]==0 ��ʾ��û�д���	
					% �����������ж�����(xx��yy)�͵�ǰ����(nCurrX,nCurrY) 
                    % ����ֵ��ľ���ֵ
                        if((yy<=n)&(yy>=1)&(xx<=m)&(xx>=1)...
                            &(pUnRegion(xx,yy)==0)...
                            &abs(A(xx,yy)-A(nCurrX,nCurrY))<nThreshold)              
                            nEnd=nEnd + 1; % ��ջ��β��ָ�����һλ
                            % ����(xx��yy) ѹ��ջ
                            pnGrowQueX(nEnd) = xx;
							pnGrowQueY(nEnd) = yy;
                            
                            % ������(xx��yy)���ó�region_index
							% ͬʱҲ���������ش����
                            pUnRegion(xx,yy) = region_index;
                            
                            % ��Ӧ������ĵ�����1
                            region_index_n(region_index)=region_index_n(region_index)+1;
                            %  ���¸����ĺ�
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
                       
                        
                        
                        


                    
        





