clc

clear all
close all


otolithe  = imread('otolithe.png');
 
figure(1),imshow(otolithe)
TfOt=fftshift(fft2(otolithe));


figure(2), colormap(jet(64)), imagesc(log(abs(TfOt))) 
%//définition d'une région d'intérêt rectangulaire 
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




