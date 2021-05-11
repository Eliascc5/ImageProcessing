#Réduction du Bruit, Lissage
clc,
clear all
close all

%Para reducir el ruido poivre sel debo utilizar un filtro non- lineal (calcula la mediana entre los voisin)
%Plus grande est la taille du filtre pour attenue est le bruit. Par contre on perdre des details (les coins) les esauinas se curvan
savoise  = imread('savoise.png'); 
savsap  = imread('savsap.png'); % image savoise + bruit de type "poivre et sel" 
figure(1), imshow(savoise) 
figure(2), imshow(savsap) 
MED3   = medfilt2(savsap); 
MED5   = medfilt2(savsap,[5,5]); 
MED7   = medfilt2(savsap,[7,7]); 
figure(3), imshow(MED3) 
figure(4), imshow(MED5) 
figure(5), imshow(MED7) 

%Lorsqu on utilise un filtre moyenneur pour reduire le bruit poivre sel on (esparcimos el ruido entre los vecinos; la image se ve peor)
h3         = fspecial('average'); 
AVE3   = filter2(h3, savsap); 
figure(7), imagesc(AVE3),colormap(gray(256)) ;