#Reduction du Bruit, Lissage
clc,
clear all
close all

sequence = input('Saisir la sequence:');

switch (sequence)
  
case 1
   1
  savoise = imread('img/SAVOISE.png'); 
  savgaus = imread('img/SAVGAUS.png'); % image savoise + bruit de type "gaussien" 
  figure(1),title('Image originale'), imshow(savoise) 
  figure(2),title('Image + bruit gaussien'), imshow(savgaus) 
  %Filtres  3x3  5x5  7x7
  %Plus on augmente la taille du filtre plus on reduit le bruit mais la zone de transition devient plus large et pourtant l image est plus floue
  %Pour corriger cq on pourrait faire un rehausement de l image 
  h3         = fspecial('average')   % �ter le ';' afin d�afficher la matrice du filtre 
  h5         = fspecial('average',5) 
  h7         = fspecial('average',7) 
  AVE3   = filter2(h3,savgaus); 
  AVE5   = filter2(h5,savgaus); 
  AVE7   = filter2(h7,savgaus);  
  figure(3), imagesc(AVE3), colormap(gray(256)) ; 
  figure(4), imagesc(AVE5), colormap(gray(256)) ; 
  figure(5), imagesc(AVE7), colormap(gray(256)) ;

  profileOriginal= savgaus(50,:) ; figure, plot(profileOriginal) ; 
  profile3=AVE3(50,:) ; figure, plot(profile3) ; 
  profile5=AVE5(50,:) ; figure, plot(profile5) ; 
  profile7=AVE7(50,:) ; figure, plot(profile7) ; 


  MED3  = medfilt2(savgaus); 
  figure, imshow(MED3) 
  %%%%%%%%%%%%%%%%

  intesite_AVE3 = AVE3(141,127); %164.33
  intesite_MED3 = MED3(141,127); %163

  %on prend le pixel de l image originale
  vp = savgaus(140:142,126:128);

  AVE_original= mean(vp(:));
  vpSorted=sort(vp(:));


  %La difference entre ces valeurs est du � que AVE3 prend le moyen parmi les voisin et MED3 prend
  %la mediane parmi les voisin 
  
case 2 
  %Para reducir el ruido poivre sel debo utilizar un filtro non- lineal (calcula la mediana entre los voisin)
  %Plus grande est la taille du filtre pour attenue est le bruit. Par contre on perdre des details (les coins) les esauinas se curvan
  savoise  = imread('img/SAVOISE.png'); 
  savsap  = imread('img/SAVSAP.png'); % image savoise + bruit de type "poivre et sel" 
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
  
 endswitch