function perf_arr = classification(methode,base,test,type_image_base,cmax,cluster,dim)
% fonction classification(methode)
% methode : choix de la méthode de classification :
% 1 :  méthode exploitant le résultat des k-moyennes
% 2 : méthode exploitant directement les données de la base d’apprentissage
% 3 : prétraitement (pca) des données d'apprentissage et d'observation
%   Génère les sets de données d'apprentissage et d'observation puis créée
%   un object ClassificationKNN pour pouvoir prédire le résultat.
%   Plot la performance pour plusieurs valeurs du paramètre k allant de 1
%   à 5 pour la méthode choisie.

% timer
tic

% Création d'une méthode de classification exploitant les données issues 
% de la base d’apprentissage. 
[X,Y] = genere_data(base,type_image_base,cmax);

% Génération d'un set d'observation
[Xobs,Yobs] = genere_data(test,type_image_base,cmax);

% Initialisation d'un tableau de performance pour le nombre de voisins
% choisi
perf_arr=[];

if methode == 1
    % Sélectionne les index correspondant au points les plus proches des
    % centroïdes de la méthode kmeans
    indexes = kmeansclassif(base,type_image_base,cmax,dim,cluster);
    
    X = X(indexes,:);
    Y = Y(indexes);
elseif methode == 3
    % Création d'une méthode de classification exploitant les données issues 
    % de la base d’apprentissage. 
    [X,Y] = preprocessing(base,type_image_base,cmax,dim);

    % Génération d'un set d'observation
    [Xobs,Yobs] = preprocessing(test,type_image_base,cmax,dim);
end

for k=1:100

    model = fitcknn(X,Y,'NumNeighbors',k,'Standardize',1);

    % Renvoie notamment les labels prédits avec une matrice de score
    % (probabilité postérieure) pour chaque image test.
    [label,score,cost] = predict(model,Xobs);

    % Vérification des résultats
    perf = 0;

    % Pour chaque image test, on vérifie que le label prédit est bien égal
    % au vrai label accessible dans le dataset
    for i=1:length(Yobs)
        if Yobs(i) == label(i)
            perf = perf+1;
        end
    end
    
    %Normalisation
    perf_arr = [perf_arr perf/100];
end

%end timer
toc 

end
        


