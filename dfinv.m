function z=dfinv(coeff,N)

% fonction z=dfinv(coeff,N)
% coeff : tableau des 2*cmax+1 oefficients complexes
% N : nombre de points pour le contour reconstruit
% z : suite complexe avec N �l�ments repr�sentant le contour reconstruit

% rot : bool�en qui indique si on veut un r�sultat ind�pendant de la
% rotation ou non (1 : d�pendant rotation, 0 : ind�pendant)

% if rot == 0
%     coeff = abs(coeff);
% end
cmax = (length(coeff)-1)/2;
TC = zeros(N,1);
TC(1:cmax+1) = coeff(end-cmax:end);
TC(end-cmax+1:end) = coeff(1:cmax);
z = ifft(TC)*N;