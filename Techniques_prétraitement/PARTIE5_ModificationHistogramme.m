%Modification d'Histogramme

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
%Ajouter binarization