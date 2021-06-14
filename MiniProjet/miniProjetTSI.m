clear all 
close all
clc
pkg load image
pkg load signal

#############################
# Auteurs : Alexandre THEBAUD
#           Elias CORREA 
# MiniProjet 2021
############################


#NOTE: Si l'on veut génperer les imagetttes a partir de l'image 07 il faut changer 
#le seuil de la fonction "findpeaks" (la dexieme fois qu'elle est utilisée) par: 54 .
#Autrement il faut le laisser a 53 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%On charge l'image
imgRGB = imread('colindata/09.png');
figure,imshow(imgRGB),title('Image originale:');
%Niveau de gris
img = rgb2gray(imgRGB); 
%Référence de l'image 
originCoord = [0 0];
[size_x,size_y]=size(img);

%Detection des contours par canny
BW = edge(img,'canny');
figure,imshow(BW),title('Contours detectés par Canny');
figure(43),plot(sum(BW)); %Affiche le signal 1D 
#Lors qu'on fait la somme de BW dans 1D, on obtient le contour et comme ca on récupere les coordonnes où il se trouve
[peaks,abscisse] = findpeaks(sum(BW),"MinPeakHeight",80);

maxPeak=max(peaks);
for i = 1:length(peaks)
  peaks(i)=maxPeak;
endfor

%On obtient ici les trois colonnes verticales 
img_v1 = imcrop(imgRGB,[0 0 abscisse(1) peaks(1)]);
img_v2 = imcrop(imgRGB,[abscisse(2) 0 abscisse(3)-abscisse(2) peaks(2)]);
img_v3 = imcrop(imgRGB,[abscisse(4) 0 abs(size_y-abscisse(4)) peaks(4)]);

%%%%%%%%%%%%%%%% PLOT COLONNES VERTICALES  %%%%%%%%%%%%%%%%%%%%%%%%%%%

%figure(3),imshow(img_v1),title('Colonne vertical 1:');
%figure(4),imshow(img_v2),title('Colonne vertical 2:');
%figure(5),imshow(img_v3),title('Colonne vertical 3:');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img_v1g=rgb2gray(img_v1); 
BW=edge(imrotate(img_v1g,90),'canny');

figure(10),imshow(BW);      %Image binaire
figure(11),plot(sum(BW));   %Affiche le signal 1D

[size_xh,size_yh]=size(imrotate(img_v1g,90));

[peaks_h,abscisse_h] = findpeaks(sum(BW),"MinPeakHeight",53);

maxPeak_h=max(peaks_h);
for i = 1:length(peaks_h)
  peaks_h(i)= maxPeak_h;
endfor

img_v11 = imcrop(imrotate(img_v1,90),[0 0 abscisse_h(1) peaks_h(1)]);
img_v12 = imcrop(imrotate(img_v1,90),[abscisse_h(2) 0 abs(size_yh-abscisse_h(2)) peaks_h(2)]);

img_v21 = imcrop(imrotate(img_v2,90),[0 0 abscisse_h(1) peaks_h(1)]);
img_v22 = imcrop(imrotate(img_v2,90),[abscisse_h(2) 0 abs(size_yh-abscisse_h(2)) peaks_h(2)]);

img_v31 = imcrop(imrotate(img_v3,90),[0 0 abscisse_h(1) peaks_h(1)]);
img_v32 = imcrop(imrotate(img_v3,90),[abscisse_h(2) 0  abs(size_yh-abscisse_h(2)) peaks_h(2)]);

#Imagettes qui correspondent aux modes d’acquisition en microscopie
figure,
subplot(2,3,1)
imshow(imrotate(img_v11,-90)),title('Imagette: 1');
subplot(2,3,2)
imshow(imrotate(img_v21,-90)),title('Imagette: 3');
subplot(2,3,3)
imshow(imrotate(img_v31,-90)),title('Imagette: 5');
subplot(2,3,4)
imshow(imrotate(img_v12,-90)),title('Imagette: 2');
subplot(2,3,5)
imshow(imrotate(img_v22,-90)),title('Imagette: 4');
subplot(2,3,6)
imshow(imrotate(img_v32,-90)),title('Imagette: 6');
