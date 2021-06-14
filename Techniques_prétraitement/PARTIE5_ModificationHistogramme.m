%Modification d'Histogramme

clc
clear all
close all

#{
house1 = imread('img/house1.png');
house2 = imread('img/HOUSE2.png');
house3 = imread('img/HOUSE3.png');

figure(2)
imhist(house1);
hold off
figure(3)
imhist(house2);
hold off
figure(4)
imhist(house3);

sic = imread('img/SIC.png');
figure(5)
imhist(sic);
#}


dna = imread('img/DNA.png');
figure,imshow(dna)

low_in = double(min(min(dna)))/255; 
high_in = double(max(max(dna)))/255;

dna_adj = imadjust(dna, [low_in high_in],[0 1]);

figure,imshow(dna_adj)

