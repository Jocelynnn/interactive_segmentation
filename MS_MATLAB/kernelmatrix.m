function [kmatrix,Y_kmatrix,X_kmatrix] = kernelmatrix(hs,method,h)
%* -------------------------------------------------------------------------
%*   ����  ��pineapple ʱ��  ��2007.5.23
%*   ��ϵ��ʽ ��QQ (94031570) Email(fanjun6294832@163.com)
%* -------------------------------------------------------------------------
%*   ����˵����[kmatrix,Y_kmatrix,X_kmatrix] = kernelmatrix(h,hs,method)
%*   ���������         
%*           hs:        ��ֵƽ���㷨�еĿ��򴰿�
%*           h:         ����Ӱ�췶Χ
%*           method ��  guass | flat. �������͵ĺ˺���
%*   ���������
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
            kmatrix = exp(-kmatrix./hs/hs);% hΪ�˴���
    case 'flat'
            kmatrix = 1- kmatrix./hs/hs;
            k = kmatrix < 0;
            kmatrix(k) = 0;
    end  