%TP 2 Segmentation  - Morphologie mathématique
%Partie 2 - Détection de contours


sequence=input('Saisir le seauence: ');

switch sequence
    case 1  
        
        load trees 
        ImB = ind2gray(X,map); 
        h  = fspecial('sobel'); % ôter le ‘;’ afin d’afficher la matrice du filtre 
        ImF = filter2(h,ImB); 
        colormap(gray(256)), imagesc(ImF), axis off 
        
        %Filtre de Sobel pour lea detection de contours horizontaux..
        %Filtrage et lissage (gaussien)
        %Podemos jugar cambiando trasponiendo el filtro con h' para
        %detectar los contornos verticales
        
    case 2
        I=imread('img/objects.tif'); 
        figure(1), imshow(I) 
        figure(2), imshow(~edge(I)) %// 'sobel' par défaut 
        figure(3), imshow(~edge(I,'roberts')) 
        figure(4), imshow(~edge(I,'prewitt')) 
        figure(5), imshow(~edge(I,'log')) % // le paramètre échelle ? = 2 par défaut 
        figure(6), imshow(~edge(I,'canny'))% // le paramètre échelle ? = 1 par défaut 
        
    case 3
        
    case 4
    case 5
    case 6
                
    otherwise
        disp('Elle n''existe pas')

end
