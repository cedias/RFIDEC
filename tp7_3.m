close all;
clear all;
disp("\n\n");
%Exercices:tp 7-2


function [xapp, yapp, xval, yval] = crossval(x, y, n, index)

% fonction de division d'une base de donnees:
% On realise n parties
%    - (n-1) sont mises dans xapp
%    - 1 est mise dans xval
% L'argument index sert a determiner la partie mise dans xval
%
% USE:
%  [xapp, yapp, xval, yval] = crossval(x, y, n, index)
%  x, y  : BD
%  n     : nombre de divisions de la base
%  index : indice a isoler
% 

xapp = [];
yapp = [];
xval = [];
yval = [];

%classes = unique(y)';
%for c = classes
  %keyboard
  ind = 1:size(x,1); %find(y==c);
  ind_deb = floor(length(ind)/n * (index-1))+1;
  ind_fin = floor(length(ind)/n * index ) ;
  if i == n % aller au bout de la BD pour le dernier morceau
    ind_fin = length(ind);
  endif

  indval = ind_deb : ind_fin;
  indapp = setdiff(1:length(ind), indval);

  xapp = [xapp; x(ind(indapp),:)];
  yapp = [yapp; y(ind(indapp),:)];
  xval = [xval; x(ind(indval),:)];
  yval = [yval; y(ind(indval),:)];
%endfor
 endfunction

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [erreurMC] = erreurMC(Y,Ybis)
  erreurMC = sum((Y - Ybis).*(Y-Ybis))/size(Y)(1);
endfunction

function [erreurP] = erreurP(Y,Ybis)
  erreurP = sum((abs(Y-Ybis)./Y)*100)/size(Y)(1);
endfunction


%%%%%%%%%%%%%%%%%%%%%--vin---%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sauvegarder une image: print("-dpdf","image.pdf")

%constante
PART = 3;

%programme
data = load("data/winequality-red.csv");
datasize = size(data)(1);
perm = randperm(datasize);
data = data(perm,:);
X = data(:,1:end-1);
Y = data(:,end);
 
w = (X'*X) \ (X'*Y);

figure(42);
plot(X,Y,"r+");
hold on;

Ybis = X*w;
plot(X,Ybis,"g*");

disp('=DATA Beton==========================================================');
disp('MC = Erreur au sens des moindres carrés');
disp('PC = Erreur en pourcentage');
disp("==================Erreur Théorique===================================");
MC = erreurMC(Y,Ybis)
PC = erreurP(Y,Ybis)

disp("==============================Erreur=================================");

muMC = 0;
muPC = 0;

for i=1 : PART
  [xapp yapp xval yval] = crossval(X,Y,PART,i);

  w2 = (xapp'*xapp)\(xapp'*yapp);
  ytrouve = xval*w2;

  ymodele = xapp*w2;

  figure(i);
  plot(xval,yval,"b*");
  hold on;
  plot(xval,ytrouve,"r+");

  disp(i)
  disp("=Erreur Apprentissage:");
  MC = erreurMC(yapp,ymodele)
  PC = erreurP(yapp,ymodele)

  disp("=Erreur Test:");
  MC = erreurMC(yval,ytrouve)
  PC = erreurP(yval,ytrouve)

  muMC = MC + muMC;
  muPC = PC + muPC;

  disp("\n");
end

disp("===========================En moyenne ==============================");
MC = muMC/PART
PC = muPC/PART
