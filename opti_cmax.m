% Optimisation du contour en jouant sur le param cmax

%% Paramètres
N=1000;
pas = 50;

base='appr';
type_image_base='png';

%% Choix et binarisation d'une image

liste=dir(fullfile(base,['*.' type_image_base]));
nom=liste(39).name;
Y=double(imread(fullfile(base,nom)))/255;
Ybin = imbinarize(Y);

%% Extraction du contour

% Une cell représente un contour dans l'image
% Dans notre cas, il n'y a à chaque fois qu'une unique cell
cell = bwboundaries(Ybin);

% dans l'unique cell pour chaque ligne (pixel) on écrit un complexe 
% représentant les coordonnées du pixel contour
s = cell{1}(:,1)+1i*cell{1}(:,2);

%% Optimisation de cmax

plotNumber=0;
for cmax=1:pas:length((cell{1})-1)
    plotNumber = plotNumber+1;
    coeff = dfdir(s,cmax);

    z = dfinv(coeff,N);

    % Plot
    X = real(z);
    Y = imag(z);
    
    subplot(3, 3, plotNumber)
    sgtitle("Influence du paramètre c_{max} dans l'extraction du contour")
    axis ij 
    plot(X,Y,'.')
    title(['c_{max} = ' num2str(cmax)])
end



