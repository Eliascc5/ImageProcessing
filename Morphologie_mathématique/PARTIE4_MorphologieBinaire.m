%Partie 4 : Morphologie Binaire


morphologie = input("Saisir la morphologie:\n");

switch morphologie
  %Il faut partir toujours d'une image binaire
  #Faire attention à l'element structurant que l'on utilise
  
case 1   %Erosion et dilatation 
  close all
  BW = imread('img/MORPHO0.TIF');
  figure(1), imshow(BW),title('Image originale');
  
  ER = imerode(BW,strel('disk',4,0));   
  DL = imdilate(BW,strel('disk',4,0));
  figure(2), imshow(ER)
  figure(3), imshow(DL)
  
case 2   %Ouverture et fermeture
  %Ouverture => erosion suivie d'une dilation
  %Permet d'eliminer le bruit du fond 
  close all
  BW = imread('img/MORPHO1.TIF'); 
  figure(1), imshow(BW),title('Image originale');
  ER = imerode(BW,strel('disk',4,0));                 %Erosion 
  image_Ouveture = imdilate(ER,strel('disk',4,0));    %Suivie de dilatation
  figure(2), imshow(image_Ouveture),title('Image après l''operation de ouverture')
  
   %Fermeture => dilation suivie d'une erosion
   %Enleve les defauts qui peuvent exister dans les objets
  
  DIL = imdilate(BW,strel('disk',4,0));                %Dilation 
  image_Fermeture = imerode(DIL,strel('disk',4,0));    %Suivie d'une erosion
  figure(4), imshow(image_Fermeture),title('Image après l''operation de fermeture')
   
otherwise
  disp('Elle n''existe pas')
    
endswitch
