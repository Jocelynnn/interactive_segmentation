load './evaluationResult/p_m.mat' p_m;
load './evaluationResult/r_m.mat' r_m;

load './evaluationResult/p_auto_1.mat' p_auto_1;
load './evaluationResult/r_auto_1.mat' r_auto_1;


r_o=r_auto_1;
p_o=p_auto_1;

% r=r_o;
% p=p_o;
% [r,index]=sort(r); %A从大到小排列，返回排序后新的向量和索引
% for ni=1:size(r)
%      p(ni)=p(index(ni));
% end
% 
% plot(r,p);

r=r_o;
p=p_o;
[p,index]=sort(p); %A从大到小排列，返回排序后新的向量和索引
for ni=1:size(p)
     r(ni)=r(index(ni));
end

plot(r,p);