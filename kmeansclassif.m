function indexes = kmeansclassif(base,type_image_base,cmax,dim,cluster)
% fonction kmeansclassif(base,type_image_base,cmax,dim,cluster)
% cluster : nombre de clusters désirés pour appliquer l'algo kmeans
%Calcule la position des centroïdes grâce à l'algorithme kmeans et renvoie
%les index correspondant aux images les plus proches des centroïdes.

% Récupération des données apreès pca
[X,Y] = preprocessing(base,type_image_base,cmax,dim);

%kmeans algo
[idx,C] = kmeans(X,cluster);

%% Plot
% figure;
% scatter3(X(idx==1,1),X(idx==1,2),X(idx==1,3),'+')
% hold on
% scatter3(X(idx==2,1),X(idx==2,2),X(idx==2,3),'+')
% scatter3(X(idx==3,1),X(idx==3,2),X(idx==3,3),'+')
% scatter3(X(idx==4,1),X(idx==4,2),X(idx==4,3),'+')
% scatter3(X(idx==5,1),X(idx==5,2),X(idx==5,3),'+')
% scatter3(X(idx==6,1),X(idx==6,2),X(idx==6,3),'+')
% 
% scatter3(C(:,1),C(:,2),C(:,3),'filled') 
% legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5','Cluster 6','Centroids')
% title 'Cluster Assignments and Centroids'
% hold off

%% Find the points in the data set that most closely resemble the centroids according to their position
indexes = knnsearch(X,C);

end