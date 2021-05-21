%Partie 8 - Rehaussement de contraste


floue  = imread('img/FLOUE.png');
figure(1),imshow(floue)

% Hay aue restarle el laplaciano 

Lap=del2(double(floue));

floue = floue - 1* Lap ;

figure(2),imshow(floue);

