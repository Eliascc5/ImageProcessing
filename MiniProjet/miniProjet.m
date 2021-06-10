clear all 
close all
clc

img1rgb = imread('colindata/02.png');
I = rgb2gray(img1rgb);
BW = edge(I,'Canny');


figure(1),imshow(img1rgb)

[H,THETA,RHO] = hough(BW,'ThetaResolution',0.5);

figure(10)
subplot(2,1,1);
imshow(BW);
title('Image binarisée et filtrée');
subplot(2,1,2);
imshow(H,[],'XData',THETA,'YData',RHO);
title('Hough transform ');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;


%P  = houghpeaks(H,6,'threshold',ceil(0.3*max(H(:))));
P  = houghpeaks(H,10);
x = THETA(P(:,2)); y = RHO(P(:,1));
plot(x,y,'s','color','white');

lines = houghlines(BW,THETA,RHO,P,'FillGap',100,'MinLength',100);
%lines = houghlines(BW,THETA,RHO,P);
figure, imshow(I), hold on

%Entre los puntos 1 y 4

for k = 1
   xy = [lines(k).point1; lines(k).point2];
   
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

end



#{
xy1 = [lines(1).point1; lines(1).point2];

xy4 = [lines(4).point1; lines(4).point2];

plot(xy1(:,1),xy1(:,2),'LineWidth',2,'Color','green');


%plot(2:2,259:510,'LineWidth',2,'Color','green');

%plot(173:173,259:510,'LineWidth',2,'Color','green');

plot(xy4(:,1),xy4(:,2),'LineWidth',2,'Color','green');
#}