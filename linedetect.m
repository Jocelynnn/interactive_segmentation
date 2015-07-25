function linedetect(BW)

% [H,theta,rho] = hough(BW); % 计算二值图像的标准霍夫变换，H为霍夫变换矩阵，theta,rho为计算霍夫变换的角度和半径值
[H,theta,rho] = hough(BW,'RhoResolution',3,'Theta',-90:5:89.5);
figure, imshow(imadjust(mat2gray(H)),[],'XData',theta,'YData',rho,...
    'InitialMagnification','fit');
xlabel('\theta (degrees)'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(hot)

% disp(theta);
% 显示霍夫变换矩阵中的极值点
P = houghpeaks(H,10);
disp(P);
x = theta(P(:,2));
y = rho(P(:,1));
plot(x,y,'s','color','black');
 
% 找原图中的线
lines = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',7);
disp(lines);
rotI=BW;
figure, imshow(rotI), hold on
max_len = 0;
for k = 1:length(lines)
    % 绘制各条线
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
    % 绘制线的起点（黄色）、终点（红色）
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    
    % 计算线的长度，找最长线段
    len = norm(lines(k).point1 - lines(k).point2);
    if ( len > max_len)
        max_len = len;
        xy_long = xy;
    end
end
 
% 以红色线高亮显示最长的线
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');

end

% P = houghpeaks(H,1000,'threshold',ceil(max(H(:)))); % 从霍夫变换矩阵H中提取5个极值点
% [H,theta,rho] = hough(BW,'RhoResolution',2,'Theta',2);