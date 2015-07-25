% load('p_auto_1.mat')
% load('p_auto_2.mat')
% load('p_auto_3.mat')
% load('p_half_group_1.mat')
% load('p_half_group_2.mat')
% load('p_half_group_3.mat')
% load('p_half_rate_1.mat')
% load('p_half_rate_2.mat')
% load('p_half_rate_3.mat')
% load('p_m.mat')
% load('p_same_group_1.mat')
% load('p_same_group_2.mat')
% load('p_same_group_3.mat')
% load('p_same_rate_1.mat')
% load('p_same_rate_2.mat')
% load('p_same_rate_3.mat')
% load('r_auto_1.mat')
% load('r_auto_2.mat')
% load('r_auto_3.mat')
% load('r_half_group_1.mat')
% load('r_half_group_2.mat')
% load('r_half_group_3.mat')
% load('r_half_rate_1.mat')
% load('r_half_rate_2.mat')
% load('r_half_rate_3.mat')
% load('r_m.mat')
% load('r_same_group_1.mat')
% load('r_same_group_2.mat')
% load('r_same_group_3.mat')
% load('r_same_rate_1.mat')
% load('r_same_rate_2.mat')
% load('r_same_rate_3.mat')

% plot(p_auto_avg,'r')
% hold on;
% plot(p_m,'b');


p_auto_avg= (p_auto_1+p_auto_2+p_auto_3)/3;
save p_auto_avg.mat p_auto_avg;

p_same_g_avg=(p_same_group_1+p_same_group_2+p_same_group_3)/3;
save p_same_g_avg.mat p_same_g_avg;

p_same_r_avg=(p_same_rate_1+p_same_rate_2+p_same_rate_3)/3;
save p_same_r_avg.mat p_same_r_avg;

p_half_g_avg=(p_half_group_1+p_half_group_2+p_half_group_3)/3;
save p_half_g_avg.mat p_half_g_avg;

p_half_r_avg=(p_half_rate_1+p_half_rate_2+p_half_rate_3)/3;
save p_half_r_avg.mat p_half_r_avg;

p_avg=(p_auto_avg+p_same_g_avg+p_same_r_avg+p_half_g_avg+p_half_r_avg)/5;
save p_avg.mat p_avg;


r_auto_avg= (r_auto_1+r_auto_2+r_auto_3)/3;
save r_auto_avg.mat r_auto_avg;

r_same_g_avg=(r_same_group_1+r_same_group_2+r_same_group_3)/3;
save r_same_g_avg.mat r_same_g_avg;

r_same_r_avg=(r_same_rate_1+r_same_rate_2+r_same_rate_3)/3;
save r_same_r_avg.mat r_same_r_avg;

r_half_g_avg=(r_half_group_1+r_half_group_2+r_half_group_3)/3;
save r_half_g_avg.mat r_half_g_avg;

r_half_r_avg=(r_half_rate_1+r_half_rate_2+r_half_rate_3)/3;
save r_half_r_avg.mat r_half_r_avg;

r_avg=(r_auto_avg+r_same_g_avg+r_same_r_avg+r_half_g_avg+r_half_r_avg)/5;
save r_avg.mat r_avg;

