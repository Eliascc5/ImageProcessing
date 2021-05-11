%Partie 7: Filtrage Fréquentiel par TF rapide
clc
clear all
close all

enonce = input('Saisir l''énoncé: ');

switch (enonce)
  
case 1
  

  interfer = imread('img/INTERFER.png');
  grain = imread('img/GRAIN.png');

  tf_Interfer=fft2(interfer);
  tf_Grain=fft2(grain);

  figure(7), title('Interfer') ,imshow(interfer);
  %Dans ce cas les haut frequences se trouvent dans les angles(sur les coins)
  figure(8), colormap(jet(64)),imagesc(log(abs(tf_Interfer)))
  %A l'aide de la fonction fftshift je les ramene au centre
  tf_Interfer_shift=fftshift(tf_Interfer);
  figure(9), colormap(jet(64)),imagesc(log(abs(tf_Interfer_shift)))

  figure(10),title('Grain'), imshow(grain);
  %Dans ce cas les haut frequences se trouvent dans les angles (sur les coins)
  figure(11), colormap(jet(64)),imagesc(log(abs(tf_Grain)))
  %A l'aide de la fonction fftshift je les ramene au centre
  tf_Grain_shift=fftshift(tf_Grain);
  figure(12), colormap(jet(64)),imagesc(log(abs(tf_Grain_shift)))


case 2

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  otolithe  = imread('img/otolithe.png');
   
  figure(1),imshow(otolithe)
  TfOt=fftshift(fft2(otolithe));


  figure(2), colormap(jet(64)), imagesc(log(abs(TfOt))) 
  %//d�finition d'une r�gion d'int�r�t rectangulaire 
  roi=zeros(size(TfOt)); 
  dv=50, dh=50;  %// les dimensions de bande passante du filtre 
  xc=size(roi,2)/2; 
  yc=size(roi,1)/2; 
  roi(yc-dv:yc+dv,xc-dh:xc+dh)=1; 
  figure(3), imshow(roi) 
  figure(4), imshow(~roi) 
  HF = TfOt .* ~roi; 
  BF = TfOt .* roi; 
  figure(5), colormap(jet(64)), imagesc(log(abs(HF))) 
  figure(6), colormap(jet(64)), imagesc(log(abs(BF)))
  
endswitch




