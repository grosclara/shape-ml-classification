%% Param�trage
clear all
close all

N=100;
cmax = 30;
reference = 'anim_ref'; %anim_ref
base = 'anim_appr'; %anim_appr
test = 'anim_test'; %anim_test
type_image_ref = 'bmp';
type_image_base = 'png';
arret_image=0;
cluster=3;
dim=3;

%% Générer la base d'image et la visualiser

% Si elle n'est pas générée, décommenter la ligne suivante
%genere_base(reference,base,type_image_ref,type_image_base,N)
%genere_base(reference,test,type_image_ref,type_image_base,N)
visu_base(base,type_image_base,arret_image,N,cmax)

%% Classification

% Classification par la méthode exploitant le résultat des k-moyennes 
perf_arr_1 = classification(1,base,test,type_image_base,cmax,cluster,dim);

% Classification par la méthode exploitant directement les données de la 
% base d'apprentissage
perf_arr_2 = classification(2,base,test,type_image_base,cmax,cluster,dim);

perf_arr_3 = classification(3,base,test,type_image_base,cmax,cluster,dim);

% Affichage
figure
hold on
plot(perf_arr_1,'-','LineWidth',1.5)
plot(perf_arr_2,'-','LineWidth',1.5)
plot(perf_arr_3,'-','LineWidth',1.5)
title("Performance de la classification d'un dataset suivant trois méthodes")
ylim([0 1.1])
xlim([1 100])
legend('kmeans',"dataset d'apprentissage","PCA sur les datasets")
xlabel('Nombre k de plus proches voisins')
ylabel('Performance normalisée')
hold off



