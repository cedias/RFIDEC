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

function [loi] = estimation(ech)
  maxEch=max(ech);  %OU loi = hist(ech,unique(ech))
  taille = size(ech,2);
  loi = [];
  for i=1 : maxEch
    loi = [loi size(find(ech==i),2)/taille]
  end
endfunction
  
  
%3
Px = [0.3 0.7];
Py = [0.34 0.41 0.25];

X = echantillon(1000,Px);
Y = echantillon(1000,Py);

loiX = estimation(X);
loiY = estimation(Y);

Px - loiX
Py - loiY


