function [finaldata,Y] = preprocessing(base,type_image_base,cmax,dim)
% fonction pre_processing(dim)
% base : nom du répertoire contenant la base d'images
% type_image_base : type des images dans la base
% cmax : nombre de descripteurs de Fourier pour extraire le contour
% dim : nombre de eigen vectors qui déterminent le mieux la répartition des
% données
%   Réalise sur le set de données initial une analyse en composante 
%   principale (pca) et projette le set de données dans cette nouvelle base
%   Renvoie le nouveau set de données projetés sur les principaux axes de
%   la pca.
%step 1, generating a dataset
%step 2, finding a mean and subtracting
%step 3, covariance matrix
%step 4, Finding Eigenvectors
%step 5, Deriving the new data set
%finding the projection onto the eigenvectors

if nargin==0;
    base='appr';
    type_image_base='png';
    cmax=30;    
    dim=3;
end

[X,Y] = genere_data(base,type_image_base,cmax);

% Analyse en composante principale
eigvect_pca = pca(X);

% Nouveau set de données obtenu en projetant le set inital sur la base pca
finaldata = inv(eigvect_pca)*X';

% Sélection des eigen vectors les plus pertinents
finaldata = finaldata(1:dim,:)';

%% Plot eventuel

% if dim == 1
%     figure
%     stem(finaldata, 'DisplayName', 'finaldata', 'YDataSource', 'finaldata');
%     title('PCA 1D output ')
% elseif dim == 2
%     figure
%     plot(finaldata(:,1),finaldata(:,2),'r+')
%     title('PCA 2D output')
% elseif dim == 3
%     figure
%     scatter3(finaldata(:,1),finaldata(:,2),finaldata(:,3),'r+')
%     title('PCA 3D output')
% end

end

