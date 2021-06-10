%TP 2 Segmentation  - Morphologie mathematique
%Partie 2 - Detection de contours


sequence=input("Saisir la seauence:\n");

switch sequence

    case 1  
 
        load trees 
        ImB = ind2gray(X,map);         
        noyau_horizontal  = fspecial('sobel')        % Enlever le ';' afin d'afficher la matrice du filtre 
        noyau_vertical = transpose(noyau_horizontal)
        
        ImF_h = filter2(noyau_horizontal,ImB);  %On glisse le filtre par l'image afin de detecter les contours horizontaux.
        ImF_v = filter2(noyau_vertical,ImB);  %On glisse le filtre par l'image afin de detecter les contours verticaux.
        
        figure,colormap(gray(256)), imagesc(ImF_h), axis off 
        figure,colormap(gray(256)), imagesc(ImF_v), axis off 
        
        
        %Filtre de Sobel:
        %le filtre de sobel se compose d'un lissage gaussien suivi d'une derivation (pour la detection des contours)
        
        % [-1 0 1     [1
        %  -2 0 2   =  2  * [-1 0 +1]   Lissage gaussien + derivation
        %  -1 0 1]     1]
        
        %On travaille l'image en niveaux de gris puisque c'est une approche qui trvaille avec l'intesité des pixels
        
        %imagesc(I) affiche les données du tableau I sous la forme d'une image qui utilise toute la gamme de couleurs de la palette de couleurs. 
        
  case 2
  
    
        I=imread('img/objects.tif'); 
        figure(1), imshow(I) 
        figure(2), imshow(~edge(I)) %// 'sobel' par defaut 
        figure(3), imshow(~edge(I,'roberts')) 
        figure(4), imshow(~edge(I,'prewitt')) 
        figure(5), imshow(~edge(I,'log')) % // le param�tre �chelle ? = 2 par d�faut 
        figure(6), imshow(~edge(I,'canny'))% // le param�tre �chelle ? = 1 par d�faut 
        
  case 3

        close all
        load trees
        I = ind2gray(X,map);
        figure(1), imshow(I)
        figure(2), imshow(~edge(I)) % 'sobel' par défaut
        figure(3), imshow(~edge(I,'roberts'))
        figure(4), imshow(~edge(I,'prewitt'))
        figure(5), imshow(~edge(I,'log')) % le paramètre échelle  = 2 par défaut
        figure(6), imshow(~edge(I,'canny')) %le paramètre échelle  = 1 par défaut  
        
  case 4
        %Detection de contours par le filtre de canny
        
        close all
        load trees
        I = ind2gray(X,map);
        figure(1),imshow(I)
        [BW,S]=edge(I,'canny');
        S
        figure(2), imshow(~edge(I,'canny'))      
        figure(3), imshow(~edge(I,'canny',S/2))   %Plus des contours detectés (sur detection)
        figure(4), imshow(~edge(I,'canny',2*S))   %Moins des contours detectés (sous detection)
        
        %THRESH -> Seuil  (seuillage par hystérésis)
        
        %BW is a binary image with the identified edges.  THRESH is the
        %threshold value used to identify those edges.  Note that THRESH is
        %used on a filtered image and not directly on IM.
    
  case 5
  
        %Effets de la gaussiene (modification de sigma)
        
        close all
        load trees
        I = ind2gray(X,map);
        [BW,S]=edge(I,'canny');
        S
        figure(1), imshow(~edge(I,'canny'))       %Le parametre echelle sigma = 1 par defaut
        figure(2), imshow(~edge(I,'canny',S,2))
        figure(3), imshow(~edge(I,'canny',S,3))
        figure(5), imshow(~edge(I,'canny',S,5))
        figure(7), imshow(~edge(I,'canny',S,7))   %Le parametre echelle sigma = 7
    
  case 6
 
    close all
    Obj = imread('img/OBJECTS.TIF');
    Cel = imread('img/cell.tif');
    %figure(1), imshow(Obj)
    figure(2), imshow(Cel)
    h = fspecial('laplacian') % Enlever le ';' afin d’afficher la matrice du filtre
    LAP = filter2(h,Obj);
    ZC1 = (LAP == 0.0);       %Pour les points ou le laplacien est egale a zero. (La derivée est nulle -> zone homogene)
    ZC2 = (LAP <= 5 & LAP >= -5);     %Passage par zero du laplacien -> ca veut dire qu'il y a un contour
    %figure(3), imshow(~ZC1)
    %figure(4), imshow(~ZC2)
    %figure(5), imshow(~edge(Obj,'log'))
    
    LAP = filter2(h,Cel);
    ZC1 = (LAP == 0.0);
    ZC2 = (LAP <= 5 & LAP >= -5);
    
    figure(3), imshow(~ZC1)
    figure(4), imshow(~ZC2)
    figure(5), imshow(~edge(Cel,'log'))
                
    otherwise
        disp('Elle n''existe pas')

end
