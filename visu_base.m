function visu_base(base,type_image_base,arretimage,N,cmax)
% fonction visu_base(base,type_image_base,arretimage)
% base : nom du répertoire contenant la base d'images
% type_image_base : type des images dans la base
% arretimage : si 0, le défilement est continu, si 1, il faut appuyer sur
% une touche pour obtenir le défilement image par image.
%Visualise les images préalablement générées, 
%et indique pour chacune d’elles la classe à laquelle elle appartient

if nargin==0
    base='appr';
    type_image_base='png';
    arretimage=0;
    N=1000;
    cmax = 30;
end
close all

liste=dir(fullfile(base,['*.' type_image_base]));
set(figure,'Units','normalized','Position',[5 5 90 85]/100)

for n=1:length(liste)
    
    nom=liste(n).name;
    Y=double(imread(fullfile(base,nom)))/255;
    Ybin = imbinarize(Y);
    fid=fopen(fullfile(base,[nom(1:strfind(nom,'.')-1) '.txt']),'r');
    classe=fscanf(fid,'%d');
    fclose (fid);
    
    subplot(2,2,1)
    imshow(Y),title(['fichier ' nom ', classe ' int2str(classe)]),drawnow
    
    subplot(2,2,2)
    imshow(Ybin),title('Image en noir et blanc'),drawnow
    
    subplot(2,2,3)
    
    threshold = graythresh(Y);
    hold on
    imhist(Y),title('Histogramme répartition des niveaux de gris'),drawnow
    plot([threshold threshold],[0 2000],'LineWidth',1)
    xlabel('Nuances de gris')
    ylabel('Nombre de pixels')
    legend('Nuances de gris',"Seuil d'Otus")
    hold off
    
    subplot(2,2,4)
    contour(Ybin, cmax, N)
             
    if arretimage
        pause()
    end
    
end

end