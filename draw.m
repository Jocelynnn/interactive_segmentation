

figure; imshow(Iseg, []);
axes_old = gca;
pos = get(gca, 'position');
pos_new = [pos(1)+pos(3)/4, pos(2)+pos(4)/4, pos(3)/4, pos(4)/4];
axes_new = axes('position', pos_new);
t = linspace(0, 2*pi, 100);
x = cos(t); y = sin(t);
axes(axes_old), hold on, plot(x*400, y*400, 'r');