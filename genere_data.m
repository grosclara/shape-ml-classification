function [X,Y] = genere_data(base,type_image_base,cmax)
% fonction genere_data(base,type_image_base,cmax)
% base : nom du répertoire contenant la base d'images
% type_image_base : type des images dans la base
% cmax : nombre de descripteurs de Fourier pour extraire le contour
%   Génère un set de data X à partir des images du répertoire reference et 
%   génère aussi un vecteur Y qui contient la classe de chaque ligne de X

if nargin==0
    base='appr';
    type_image_base='png';
    cmax=30;
end

% Récupération de toutes les images dans une liste
images=dir(fullfile(base,['*.' type_image_base]));

% Initialisation du set de data initial
X = zeros(length(images),2*cmax+1);
% Initialisation de la matrice qui contient les labels pour chaque image
Y = zeros(length(images),1);

for n=1:length(images)
    
    nom=images(n).name;
    Im=double(imread(fullfile(base,nom)))/255;
    Imbin = imbinarize(Im);
    
    fid=fopen(fullfile(base,[nom(1:strfind(nom,'.')-1) '.txt']),'r');
    classe=fscanf(fid,'%d');
    fclose (fid);
        
    % Calcul des descripteurs de Fourier pour chaque image
    cell = bwboundaries(Imbin);
    s = cell{1}(:,1)+1i*cell{1}(:,2);
    fdescript = dfdir(s,cmax); %Fourier descripteurs
    % Pour  obtenir  des  attributs  indépendants  de  la  rotation, on 
    % prend le module  des descripteurs 
    X(n,:) = abs(fdescript);
    % On met à jour la matrice des labels
    Y(n,1) = classe;

end

end

