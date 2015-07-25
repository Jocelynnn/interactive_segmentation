function linedetect(BW)

% [H,theta,rho] = hough(BW); % �����ֵͼ��ı�׼����任��HΪ����任����theta,rhoΪ�������任�ĽǶȺͰ뾶ֵ
[H,theta,rho] = hough(BW,'RhoResolution',3,'Theta',-90:5:89.5);
figure, imshow(imadjust(mat2gray(H)),[],'XData',theta,'YData',rho,...
    'InitialMagnification','fit');
xlabel('\theta (degrees)'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(hot)

% disp(theta);
% ��ʾ����任�����еļ�ֵ��
P = houghpeaks(H,10);
disp(P);
x = theta(P(:,2));
y = rho(P(:,1));
plot(x,y,'s','color','black');
 
% ��ԭͼ�е���
lines = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',7);
disp(lines);
rotI=BW;
figure, imshow(rotI), hold on
max_len = 0;
for k = 1:length(lines)
    % ���Ƹ�����
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
    % �����ߵ���㣨��ɫ�����յ㣨��ɫ��
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    
    % �����ߵĳ��ȣ�����߶�
    len = norm(lines(k).point1 - lines(k).point2);
    if ( len > max_len)
        max_len = len;
        xy_long = xy;
    end
end
 
% �Ժ�ɫ�߸�����ʾ�����
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');

end

% P = houghpeaks(H,1000,'threshold',ceil(max(H(:)))); % �ӻ���任����H����ȡ5����ֵ��
% [H,theta,rho] = hough(BW,'RhoResolution',2,'Theta',2);