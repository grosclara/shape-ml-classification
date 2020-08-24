function perf_arr = classification(methode,base,test,type_image_base,cmax,cluster,dim)
% fonction classification(methode)
% methode : choix de la m�thode de classification :
% 1 :  m�thode exploitant le r�sultat des k-moyennes
% 2 : m�thode exploitant directement les donn�es de la base d�apprentissage
% 3 : pr�traitement (pca) des donn�es d'apprentissage et d'observation
%   G�n�re les sets de donn�es d'apprentissage et d'observation puis cr��e
%   un object ClassificationKNN pour pouvoir pr�dire le r�sultat.
%   Plot la performance pour plusieurs valeurs du param�tre k allant de 1
%   � 5 pour la m�thode choisie.

% timer
tic

% Cr�ation d'une m�thode de classification exploitant les donn�es issues 
% de la base d�apprentissage. 
[X,Y] = genere_data(base,type_image_base,cmax);

% G�n�ration d'un set d'observation
[Xobs,Yobs] = genere_data(test,type_image_base,cmax);

% Initialisation d'un tableau de performance pour le nombre de voisins
% choisi
perf_arr=[];

if methode == 1
    % S�lectionne les index correspondant au points les plus proches des
    % centro�des de la m�thode kmeans
    indexes = kmeansclassif(base,type_image_base,cmax,dim,cluster);
    
    X = X(indexes,:);
    Y = Y(indexes);
elseif methode == 3
    % Cr�ation d'une m�thode de classification exploitant les donn�es issues 
    % de la base d�apprentissage. 
    [X,Y] = preprocessing(base,type_image_base,cmax,dim);

    % G�n�ration d'un set d'observation
    [Xobs,Yobs] = preprocessing(test,type_image_base,cmax,dim);
end

for k=1:100

    model = fitcknn(X,Y,'NumNeighbors',k,'Standardize',1);

    % Renvoie notamment les labels pr�dits avec une matrice de score
    % (probabilit� post�rieure) pour chaque image test.
    [label,score,cost] = predict(model,Xobs);

    % V�rification des r�sultats
    perf = 0;

    % Pour chaque image test, on v�rifie que le label pr�dit est bien �gal
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
        


