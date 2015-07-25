function [kmatrix,Y_kmatrix,X_kmatrix] = kernelmatrix(hs,method,h)
%* -------------------------------------------------------------------------
%*   作者  ：pineapple 时间  ：2007.5.23
%*   联系方式 ：QQ (94031570) Email(fanjun6294832@163.com)
%* -------------------------------------------------------------------------
%*   函数说明：[kmatrix,Y_kmatrix,X_kmatrix] = kernelmatrix(h,hs,method)
%*   输入参数：         
%*           hs:        均值平移算法中的空域窗宽
%*           h:         最大的影响范围
%*           method ：  guass | flat. 两种类型的核函数
%*   输出参数：
%*           kmatrix
%--------------------------------------------------------------------------
if nargin < 3
    h = 2*hs;
end
    x_W =1: 2*h+1;
    y_W =1: 2*h+1;
    x_kmatrix = x_W - h-1;
    y_kmatrix = y_W - h-1;
    [Y_kmatrix,X_kmatrix] = meshgrid(y_kmatrix,x_kmatrix);
    kmatrix = X_kmatrix.^2 + Y_kmatrix.^2;
    switch method
    case 'guass'
            kmatrix = exp(-kmatrix./hs/hs);% h为核窗宽
    case 'flat'
            kmatrix = 1- kmatrix./hs/hs;
            k = kmatrix < 0;
            kmatrix(k) = 0;
    end  