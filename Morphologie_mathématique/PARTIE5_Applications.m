%Partie 5 - Applications 
clc
clear all
close all 
app = input("Saisir l''application:\n");

switch app
  
case 1  %Extraction et caracterisation
  img = imread('img/BLOCKN.tif');
  figure(1), imshow(img),title('Image originale');
  figure(2), imhist(img),title('Histogramme de l''image orignale');
  
  level = 160.0/255.0;                 %En regardant l'histogramme. On trouve que le seuil optimal se trouve vers 160 
  %level = graythresh(img)             %Cette fonction cherche le seuil optimale
  
  BW = im2bw(img, level);                          %Binarisation de l'image
  %figure(3), imshow(BW),title('Image binarisée');
  %Element structurant
  se = strel('square',5);
  
  #On fait une ouverture -> Permet d'eliminer le bruit du fond 
  ER = imerode(BW,se);                 %Erosion 
  image_Ouveture = imdilate(ER,se);    %Suivie de dilatation
  figure(4), imshow(image_Ouveture),title('Image après l''operation de ouverture');
  
  #En suite une femeture pour enlever le trou du centre
  
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

  case 2  %Reconnaissance et comptage
  
  %Etapes a faire 
  %1-rgb2gray
  %2-Segmentation binaire (objets vs Fond) Seuillage.
  %3-Enlever le bruit sur le fond et combler les trous sur les objets.
  %4-imfill pour combler les elestiques.
  %5-labelisation par pixel connectés ---> bwlabel
  %6-Séparer les objets entre eux. Segmentation par objetcs. 
  %7- C=f(A,p)=? Critere de forme    // A:aire p:perimetre
  
  imgRGB = imread('img/pillsetc.png');
  I= rgb2gray(imgRGB);
  figure(1)
  subplot(2,1,1);
  imshow(I);
  title('Histogramme');
  subplot(2,1,2);
  imhist(I);
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  level = 207/255;
  BW = im2bw(I, level);                          %Binarisation de l'image
  figure(2),imshow(BW),title('Image binarisée');
  
  #Femeture  ---> Enleve les defauts qui peuvent exister dans les objets 
  %Element structurant
  se = strel('disk',13,0);
  DIL = imdilate(BW,se);                %Dilation 
  image_Fermeture = imerode(DIL,se);    %Suivie d'une erosion
  figure(4), imshow(image_Fermeture),title('Image après l''operation de fermeture');

  BW2 = imfill(image_Fermeture, "holes");

  figure(6),imshow(BW2),title('Trous comblés');
  
  [L,NUM] = bwlabel(BW2,8) ;  % By default the algorithm uses 8-connectivity to define a neighborhood
  figure(7),imagesc(L),axis equal;
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  disp("\n Si la valeur est proche de 1, alors la forme est un cercle:\n");
  
  I1 = (L==1);
  A1 = bwarea(I1);
  p1 = bwarea(bwperim(I1));
  C1 = 4*pi*A1/(p1^2)

  I2 = (L==2);
  A2 = bwarea(I2);
  p2 = bwarea(bwperim(I2));
  C2 = 4*pi*A2/(p2^2)
  
  I3 = (L==3);
  A3 = bwarea(I3);
  p3 = bwarea(bwperim(I3));
  C3 = 4*pi*A3/(p3^2)
  
  I4 = (L==4);
  A4 = bwarea(I4);
  p4 = bwarea(bwperim(I4));
  C4 = 4*pi*A4/(p4^2)
  
  I5 = (L==5);
  A5 = bwarea(I5);
  p5 = bwarea(bwperim(I5));
  C5 = 4*pi*A5/(p5^2)
  
  I6 = (L==6);
  A6 = bwarea(I6);
  p6 = bwarea(bwperim(I6));
  C6 = 4*pi*A6/(p6^2)
  
  otherwise
  
  disp('Elle n''existe pas')

endswitch
