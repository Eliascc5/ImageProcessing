#Réduction du Bruit, Lissage
clc,
clear all
close all

savoise = imread('savoise.png'); 
savgaus = imread('savgaus.png'); % image savoise + bruit de type "gaussien" 
figure(1),title('Image originale'), imshow(savoise) 
figure(2),title('Image + bruit gaussien'), imshow(savgaus) 
%Filtres  3x3  5x5  7x7
%Plus on augmente la taille du filtre plus on reduit le bruit mais la zone de transition devient plus large et pourtant l image est plus floue
%Pour corriger cq on pourrait faire un rehausement de l image 
h3         = fspecial('average')   % ôter le ';' afin d’afficher la matrice du filtre 
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


%La difference entre ces valeurs est du à que AVE3 prend le moyen parmi les voisin et MED3 prend
%la mediane parmi les voisin 