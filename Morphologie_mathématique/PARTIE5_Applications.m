%Partie 5 - Applications 
clc
clear all
close all 
app = input("Saisir l''application:\n");

switch app
  
case 1  #Extraction et caracterisation
  img = imread('img/BLOCKN.tif');
  figure(1), imshow(img),title('Image originale');
  figure(2), imhist(img),title('Histogramme de l''image orignale');
  
  level = 160.0/255.0;                 %En regardant l'histogramme. On trouve que le seuil optimal se trouve vers 160 
  %level = graythresh(img)             %Cette fonction cherche le seuil optimale
  
  BW = im2bw(img, level);                          %Binarisation de l'image
  %figure(3), imshow(BW),title('Image binarisée');
  
  %Element structurant
  se = strel('square',5);
  
  #On fait une ouverture
  ER = imerode(BW,se);                 %Erosion 
  image_Ouveture = imdilate(ER,se);    %Suivie de dilatation
  figure(4), imshow(image_Ouveture),title('Image après l''operation de ouverture');
  
  #En suite une femeture pour enlever le trou au centre 
  
  %Element structurant
  se = strel('disk',5,0);
  DIL = imdilate(image_Ouveture,se);                %Dilation 
  image_Fermeture = imerode(DIL,se);    %Suivie d'une erosion
  figure(5), imshow(image_Fermeture),title('Image après l''operation de fermeture');
  
  ##############################################
  
  aire = bwarea(image_Fermeture);
  disp('Aire calculée:'),disp(aire);
  perimetre = bwperim(image_Fermeture);
  figure(6),imshow(perimetre),title("Perimetre de l'image");

  case 2
  
  img = imread('img/pillsetc.png');
  figure(1),imshow(img)
  
  
  
  otherwise
  
  disp('Elle n''existe pas')

endswitch
