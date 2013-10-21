close all;
clear all;
 %Exercice n°40

%1

function [ech] = echantillon(n,loi)
  sumCum = cumsum(loi);
  tire = [];
  for i = 1 : n 
    tire = [tire find(sumCum > rand())(1)];
  end
  ech = tire;
endfunction


%2

function [loi] = estimation(ech) %fonctionne sur une seule dimension...
  maxEch=max(ech);  %OU loi = hist(ech,unique(ech))./tailleEch
  taille = size(ech,2);
  loi = [];
  for i=1 : maxEch
    loi = [loi size(find(ech==i),2)/taille];
  end
endfunction
  
  
%3
Px = [0.3 0.7];
Py = [0.34 0.41 0.25];
Pz = [0.49  0.51];


X = echantillon(1000,Px);
Y = echantillon(1000,Py);
Z = echantillon(1000,Pz);

loiX = estimation(X);
loiY = estimation(Y);

diffX = Px - loiX;
diffY = Py - loiY;

%4

  %1 -> X, Y et Z sont les échantillons. Oui on retrouve bien les marginales (à l'erreur d'échantillonage près)
  %2 -> NON, ne représente pas la loi jointe, represente la loi jointe SOUS CONDITIONS que Px,Py et Pz indépendants...


%5

%X ne change pas
Xcond = X;

%on tire Y en fonction de Xcond selon 
Py_x = [0.2 0.2 0.6; 0.4 0.5 0.1];
%on tire Z en fonction de Xcond selon
Pz_x = [0.7 0.3; 0.4 0.6];

Ycond = [];
Zcond = [];

for i=1 : 1000
  Ycond = [Ycond echantillon(1,Py_x(Xcond(i),:))];
  Zcond = [Zcond echantillon(1,Py_x(Xcond(i),:))];
end;

function [chiSq] = calculChiSq(cont)
  droite = sum(cont,2);
  bas = sum(cont);
  total = sum(bas);

  theorie = droite*bas;
  theorie = theorie./total;

  diff = (((cont - theorie).*(cont - theorie))./theorie);
  chiSq = sum(sum(diff));
endfunction

%echantillon indépendants (theorie)
XY= [X' Y']; 
XZ= [X' Z'];
ZY= [Z' Y'];

%echantillon conditionnel (Pratique)
XYcond = [Xcond' Ycond'];
XZcond = [Xcond' Zcond'];
ZYcond = [Zcond' Ycond'];
