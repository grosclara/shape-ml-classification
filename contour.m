function contour(Ybin,cmax,N)

% fonction contour(Y,cmax)
% Y : image binaire dont on extrait le contour
% cmax : param qui joue sur le nombre de descripteurs de Fourier
% N : nombre de points pour le contour reconstruit


% Une cell représente un contour dans l'image
% Dans notre cas, il n'y a à chaque fois qu'une unique cell
cell = bwboundaries(Ybin);

% dans l'unique cell pour chaque ligne (pixel) on écrit un complexe 
% représentant les coordonnées du pixel contour
s = cell{1}(:,1)+1i*cell{1}(:,2);

% REGLAGE DE CMAX A OPTIMISER
%cmax = length(cell{1})-1

coeff = dfdir(s,cmax);

z = dfinv(coeff,N);

% Plot
X = real(z);
Y = imag(z);

axis ij 
plot(X,Y,'.')
title('Contour extrait')