%Partie 3: Seuillage et segmentation 

clc
clear all 
close all
######################################


ImObj = imread('img/OBJECTS.TIF');
figure(1), imshow(ImObj)
level = graythresh(ImObj)
BW = im2bw(ImObj, level);
figure(2), imshow(BW)
SQ = bwmorph(BW,'skel',20);
figure(3), imshow(SQ)
Result = xor(BW,SQ);
figure(4), imshow(Result)

#Conclusions: