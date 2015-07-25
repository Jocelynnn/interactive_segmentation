% mainColor: main color which should be saved and eliminate the others
% IDX: superpixel feature values
% IDXValue:real superpixel number in images
function [rowset,rowcount]=classifySuperpixels(mainColor,IDX,IDXValue)

% IDX = [1,2,3;  
%        2,3,1;  
%        1,2,3;  
%        1,1,1;  
%        1,1,1;  
%        1,1,1]; 
% the superpixel no of each row(must be same row count as IDX)
% IDXValue=[1;
%         2;
%         3;
%         4;
%         5;
%         6];
uniqueRows = unique(IDX,'rows');

% fprintf('%d kinds of different superpixels in total\n',size(uniqueRows,1));
% fprintf('%d main colors in total\n',size(mainColor,1));


% 根据特征值保留所有颜色中是主要颜色的颜色
[mainSuperPixel,i1,i2]=intersect(mainColor,uniqueRows,'rows');
missColor=setdiff(mainColor,mainSuperPixel,'rows');
% 没有出现在超像素块中的主要颜色，后续加入
missCount=size(missColor,1);

% fprintf('after filtering superpixels, miss %d colors\n',missCount)

for i=1:missCount
    current=missColor(i,:);
    minRow=1;
    min=0;
    for j=1:size(uniqueRows,1)
        target=uniqueRows(j,:);
        diff=norm(current-target);
        if(diff<min)
            min=diff;
            minRow=j;
        end
    end
    l=ismember(minRow,i2);
    % all zero:this row is not in the current mainSuperpixel set
    if(size(find(l~=0),1)==0)
%         disp('add missing colors');
        mainSuperPixel=[mainSuperPixel;uniqueRows(j,:)];
    end
end

save mainSuperPixel.mat 'mainSuperPixel';
save uniqueRow.mat uniqueRows;
uniqueRows=mainSuperPixel;
[m,n]=size(IDX);

% fprintf('%d superpixels in total \n',m)

[p,q]=size(uniqueRows);
% fprintf('%d kinds of different superpixel according to main color \n',p)

% each row contains the superpixel numbers with the same color 
% set to max value=m
rowset=zeros(p,m);
for i=1:p
    target=uniqueRows(i,:);
    count=1;
    for j=1:m
        if(IDX(j,:)==target)
            rowset(i,count)=IDXValue(j);
            count=count+1;
        end
        
    end
end

rowcount=p;
save rowset.mat rowset ;

end