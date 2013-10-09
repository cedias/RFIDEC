close all;
clear all;
 %Exercice n°31

%1
function [tx] = txCorrelation(mat)
tx = cov(mat(:,1),mat(:,2))/(std(mat(:,1))*std(mat(:,2)));
endfunction

data = load("data/dataSautHaut.dat");
moyTaille = mean(data(:,1));
moyPerf = mean(data(:,2));
etTaille = std(data(:,1));
etPerf = std(data(:,2));
txCor = txCorrelation(data);

[moyTaille moyPerf etTaille etPerf txCor]

X=data(:,1);
Y=data(:,2);
%plot(X,Y,"r+")

%2
function [tab] = tableauCont(data,M,N)
  X=data(:,1);
  ecartX = range(X)+0.001;
  tailleX = ecartX/M;
  minX = min(X);
  maxX = max(X);

  Y=data(:,2);
  ecartY = range(Y)+0.001;
  tailleY = ecartY/N;
  minY = min(Y);
  maxY = max(Y);

  tab = zeros(M,N);

  for i=1:M
    for j=1:N
      tab(i,j) = length(find( X >= minX + tailleX * (i-1) & ...
			      X < minX + tailleX * i & ...
			      Y >= minY + tailleY * (j-1) & ...
			      Y <  minY + tailleY * j));
    endfor
  endfor
endfunction

function [chiSq] = calculChiSq(cont)
droite = sum(cont,2);
bas = sum(cont);
total = sum(bas);

theorie = droite*bas;
theorie = theorie./total;

diff = (((cont - theorie).*(cont - theorie))./theorie);
chiSq = sum(sum(diff));
endfunction

cont = tableauCont(data,3,3);
chisq1 = calculChiSq(cont)

cont = tableauCont(data,4,2);
chisq2 = calculChiSq(cont)