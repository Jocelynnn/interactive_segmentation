function cutSet=cutPoint(position,row,col)

cell={};

% 需用前景/背景大小来度量 不是用整张图片
row_threshold=row/15;
col_threshold=col/3;

cutCount=1;
currentCell={};
current=1;
currentCell{current}=position(1,:);
current=current+1;

[m,n]=size(position);
disp(m);
for i=2:m
    point=position(i,:);
    previous=currentCell{current-1};

%     if(abs(point(2)-previous(2))>col_threshold)
%         disp('pass');
%         continue;
%     end
    
    
    if(abs(point(2)-previous(2))>col_threshold)
        cell{cutCount}=currentCell;
        cutCount=cutCount+1;
        currentCell={};
        currentCell{1}=point;
        current=2;
        disp('cut');
        continue;
    end
    
    
    
    disp('in');
    currentCell{current}=point;
    current=current+1;
    
    if(i==m)
        cell{cutCount}=currentCell;
        cutCount=cutCount+1;
        disp('final cut');
        break;
    end
    
    
end

disp(cutCount-1);
disp(cell);
% disp(cell{1});
cutSet=cell;

end