
[m,n]=size(p_m);
result=[];
for i=1:m
    x=r_m(i,1);
    y=r_auto_1(i,1);
    result(i,:)=x-y; 
end
result(abs(result)<0.1)=0;
[m,n]=find(result~=0);
res1=[m,result(m,1)];

[m,n]=size(p_m);
for i=1:m
    x=r_m(i,1);
    y=r_auto_2(i,1);
    result(i,:)=x-y; 
end
result(abs(result)<0.1)=0;
[m,n]=find(result~=0);
res2=[m,result(m,1)];

[m,n]=size(p_m);
for i=1:m
    x=r_m(i,1);
    y=r_auto_3(i,1);
    result(i,:)=x-y; 
end
result(abs(result)<0.1)=0;
[m,n]=find(result~=0);
res3=[m,result(m,1)];

i1=intersect(res1(:,1),res2(:,1));
i2=intersect(i1,res3(:,1));


% [m,n]=size(p_m);
% result1=[];
% result2=[];
% result3=[];
% for i=1:m
%     x=p_m(i,1);
%     y=p_auto_1(i,1);
%     result1(i,:)=x-y; 
% end
% result1(abs(result1)<0.1)=0;
% [m,n]=find(result1~=0);
% res1=[m,result1(m,1)];
% 
% [m,n]=size(p_m);
% for i=1:m
%     x=p_m(i,1);
%     y=p_auto_2(i,1);
%     result2(i,:)=x-y; 
% end
% result2(abs(result2)<0.1)=0;
% [m,n]=find(result2~=0);
% res2=[m,result2(m,1)];
% 
% [m,n]=size(p_m);
% for i=1:m
%     x=p_m(i,1);
%     y=p_auto_3(i,1);
%     result3(i,:)=x-y; 
% end
% result3(abs(result3)<0.1)=0;
% [m,n]=find(result3~=0);
% res3=[m,result3(m,1)];
% 
% i1=intersect(res1(:,1),res2(:,1));
% i2=intersect(i1,res3(:,1));
