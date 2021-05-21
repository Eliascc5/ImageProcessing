%Partie 8 - Rehaussement de contraste

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Le flou peut être corrigé : rehausser le contraste de l’image par diminution de l’étendue de la zone de transition
%Solution : Ir(x , y) = I(x , y) - lambda * laplacien (I(x , y))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all
close all

floue  = imread('img/FLOUE.png');

figure(1),imshow(floue)

laplacien=del2(double(floue));

lambda = 1;   %Il faut faire attetion de ne pas dépasser la dynamique de l'image

floue = floue - lambda * laplacien ;

figure(2),title('Rehaussement de constraste'),imshow(floue);
figure(3),title('Histogramme de l''image rehaussée'),imhist(floue);

%{
Alors que les filtres à coefficients positifs ont un effet de lissage, dans 
les filtres de différence (qui ont des coefficients positifs et négatifs), 
l'effet est le contraire, où les différences entre les niveaux d'intensité des 
pixels sont améliorées. Par conséquent, ces types de filtres sont normalement 
utilisés pour l'amélioration des bords. 
%}