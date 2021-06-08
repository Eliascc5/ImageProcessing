close all 
clear all 
clc

I = imread('img/BLOCKN.tif');

[BW]=edge(I,'canny',0.7);

#{   
FUNCTION -> HOUGH

Cette fonction calcule la Transformée de Hough Standard (SHT)
de l'image binaire BW. La fonction hough est conçue pour détecter les lignes.  La fonction utilise la 
représentation paramétrique d'une ligne : rho = x*cos(thêta) + y*sin(thêta). La fonction renvoie rho, 
la distance de l'origine à la ligne le long d'un vecteur perpendiculaire à la ligne, et  theta, l'angle 
en degrés entre l'axe des x et ce vecteur. La fonction renvoie également le SHT, H,  qui est une matrice 
d'espace de paramètres dont les lignes et les colonnes correspondent respectivement aux valeurs rho et thêta
#}

[H,THETA,RHO] = hough(BW,'ThetaResolution',1);


figure(2)
subplot(2,1,1);
imshow(BW);
title('Image binarisée et filtrée');
subplot(2,1,2);
imshow(H,[],'XData',THETA,'YData',RHO);
title('Hough transform ');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;


P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = THETA(P(:,2)); y = RHO(P(:,1));
plot(x,y,'s','color','white');

lines = houghlines(BW,THETA,RHO,P,'FillGap',5,'MinLength',7);
figure, imshow(I), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

end


