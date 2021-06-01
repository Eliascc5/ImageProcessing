%Partie 3: Seuillage et segmentation 

clc
clear all 
close all
######################################

ImObj = imread('img/OBJECTS.TIF');
figure(1),imshow(ImObj),title('Image originale')   %L'image doit etre bi-modale
level = graythresh(ImObj)                          %Cette fonction cherche le seuil optimale
BW = im2bw(ImObj, level);                          %Binarisation de l'image
figure(2), imshow(BW)
SQ = bwmorph(BW,'skel',20);                        %Morphologie mat. => "ouverture, fermeture, dilatation, squelettisation, etc, etc..."
figure(3), imshow(SQ)
Result = xor(BW,SQ);
figure(4), imshow(Result)
