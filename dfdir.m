function coeff=dfdir(z,cmax)

% fonction coeff=dfdir(z,cmax)
% z : suite complexe repr�sentant le contour
% cmax : les coefficients d'indice -cmax � cmax sont conserv�s
% returns coeff : tableau des 2*cmax+1 coefficients complexes

% on calcule la moyenne sur toutes les coordonn�es des contours en x et
% sur toutes les coordonn�es des contours en y
z_moy=mean(z);

% nombre de lignes (ie de pixels contour)
N=length(z);

% on calcule les coefficients de Fourier
TC=fft(z-z_moy)/N;

% on s�lectionne les coefficients entre -cmax et cmax
num=(-cmax):cmax;

% on initialise le vecteur coeff
coeff=zeros(2*cmax+1,1);
coeff(end-cmax:end)=TC(1:cmax+1);
coeff(1:cmax)=TC(end-cmax+1:end);
% on retourne la s�quence si le parcours est dans le
% sens inverse au sens trigonom�trique
if abs(coeff(num==-1))>abs(coeff(num==1))
    coeff=coeff(end:-1:1);
end
% normalisation d'�chelle
coeff=coeff/abs(coeff(num==1));
