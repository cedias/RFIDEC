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

%marginales
loiXC = estimation(Xcond);
loiYC = estimation(Ycond);
loiZC = estimation(Zcond);

%lois jointes
loiJXY = loiXC' * loiYC; 
loiJXZ = loiXC' * loiZC; 
loiJYZ = loiYC' * loiZC;

contJXY = loiJXY*1000;%theorie
contJXZ = loiJXZ*1000;
contJYZ = loiJYZ*1000;

contJXYp = table(Xcond,Ycond);%pratique
contJXZp = table(Xcond,Zcond);
contJYZp = table(Ycond,Zcond);

function [chisq,deg] =  chisq(pratique,theorie)
  cont = (((pratique - theorie).*(pratique - theorie))./theorie);
  chisq = sum(sum(cont));
  deg = prod((size(pratique)-1));
endfunction


[a d] = chisq(contJXYp,contJXY);
[b d2] = chisq(contJXZp,contJXZ);
[c d3] = chisq(contJYZp,contJYZ);

%pour verifier
[x a2 dbis] = chisquare_test_independence(table(Xcond,Ycond));
[x b2 d2bis] = chisquare_test_independence(table(Xcond,Zcond));
[x c2 d3bis] = chisquare_test_independence(table(Ycond,Zcond));

%affichage final
[ a d b d2 c d3 ; a2 dbis b2 d2bis c2 d3bis]