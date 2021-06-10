close all

im1=imread('colindata/01.png');
%figure(2),imshow(im1);

im1_gray=rgb2gray(im1);

%figure(2),imhist(im1_gray);
%-- d'apr�s l'histogramme les bandes sont de niveau 191
level1 = 191/255;
level2 = 192/255;
im1_BW1=im2bw(im1_gray, level1);
im1_BW2=im2bw(im1_gray, level2);
%figure(3),imshow(im1_BW1);
%figure(4),imshow(im1_BW2);

im1_xor=xor(im1_BW1,im1_BW2);
%quand c'est diff�rent =1 qd c'est pareil =0
figure(5),imshow(im1_xor);

IM = imcomplement(im1_xor);
%figure(5),imshow(IM);

%-- Ouverture
ER1=imerode(IM,strel('rectangle',[7,5]));
DL1=imdilate(ER1,strel('rectangle',[7,5]));
%-- Fermeture
%DL2=imdilate(DL1,strel('rectangle',[10,5]));
%ER2=imerode(DL2,strel('rectangle',[10,5]));
%figure(3),imshow(DL1);

[im_frac,NUM]= bwlabel(DL1);
NUM
%NUM est le nbre d'objet

I1= (im_frac==1);
I2= (im_frac==2);
I3= (im_frac==3);
I4= (im_frac==4);
I5= (im_frac==5);
I6= (im_frac==6);
figure(6),imshow(I1);

im_1=and(im1_gray,I6);
figure(7),imshow(im_1);

%N=8;
%[im1_seg,NUM]= BWLABEL(im1_BW,N);
%NUM est le nbre d'objet

%I1= (im1_seg==1);
%I2= (im1_seg==2);
%figure(4),imshow(I1);