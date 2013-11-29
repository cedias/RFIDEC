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

function [erreurEC] = erreurEC(Y,Ybis)
  erreurEC = sum(abs(Y-Ybis))/size(Y)(1);
endfunction

function [erreurE05] = erreurE05(Y,Ybis)
  e = abs(Y-Ybis);
  indexNe = find(e<=0.5);
  indexEr = find(e>0.5);
  
  e(indexNe)=0;
  e(indexEr)=1;
  erreurE05 = sum(e);
endfunction


%%%%%%%%%%%%%%%%%%%%%--vin---%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sauvegarder une image: print("-dpdf","image.pdf")

%constante
PART = 50;
FIG = 0;
DETAIL = 0;

%programme
dataRed = load("data/winequality-red.csv");
dataWhite = load("data/winequality-white.csv");
datasize = size(dataRed)(1);
datasize2 = size(dataWhite)(1);
perm = randperm(datasize);
data = dataRed(perm,:);
data2 = dataWhite(perm,:);
X = data(:,1:end-1);
X2 = data2(:,1:end-1);
Y = data(:,end);
Y2 = data2(:,end);

%data = RED
%data2 = WHITE
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%VIN ROUGE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w = (X'*X) \ (X'*Y);
Ybis = X*w;

if(FIG==1) then
  figure("RED");
  plot(X,Y,"r+");
  hold on;
  plot(X,Ybis,"g*");
end




disp('= DATA VIN ROUGE==========================================================');
disp('nbDonnees = nombre de donnees')
disp('MC = Erreur au sens des moindres carrés');
disp('PC = Erreur en pourcentage');
disp('EC = Ecart moyen des notes avec les notes réelles');
disp('E05 = nombre derreur de notation à 0.5 près');
disp("================== Erreur Théorique ===================================");

nbDonnees = datasize
MC = erreurMC(Y,Ybis)
PC = erreurP(Y,Ybis)
EC = erreurEC(Y,Ybis)
E05 = erreurE05(Y,Ybis)

if DETAIL == 1 then
disp("============================== Erreur =================================");
end

muMC = 0;
muPC = 0;
muEC = 0;
muE05 = 0;

for i=1 : PART
  [xapp yapp xval yval] = crossval(X,Y,PART,i);

  w2 = (xapp'*xapp)\(xapp'*yapp);
  ytrouve = xval*w2;

  ymodele = xapp*w2;

if FIG == 1 then
  figure(i);
  plot(xval,yval,"b*");
  hold on;
  plot(xval,round(ytrouve),"r+");
end


  
  MC = erreurMC(yapp,ymodele);
  PC = erreurP(yapp,ymodele);
  EC = erreurEC(yapp,ymodele);
  E05 = erreurE05(yapp,ymodele);

  if DETAIL == 1 then
    disp(i)
    disp("=Erreur Apprentissage:");
    disp(MC);
    disp(PC);
    disp(EC);
    disp(E05);
  end
 

  MC = erreurMC(yval,ytrouve);
  PC = erreurP(yval,ytrouve);
  EC = erreurEC(yval,ytrouve);
  E05 = erreurE05(yval,ytrouve);

  if DETAIL == 1 then
    disp(i)
    disp("=Erreur Test:");
    disp(MC);
    disp(PC);
    disp(EC);
    disp(E05);
    disp("\n");
  end

  muMC = MC + muMC;
  muPC = PC + muPC;
  muEC = EC + muEC;
  muE05 = E05 + muE05;


  
end

disp("=========================== En moyenne ==============================");
MC = muMC/PART
PC = muPC/PART
EC = muEC/PART
E05 = muE05/PART


disp("\n");
%%%%%%%%%%%%%%%%%%%%%%%%%%%VIN BLANC%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w = (X2'*X2) \ (X2'*Y2);
Ybis = X2*w;

if(FIG==1) then
  figure("WHITE");
  plot(X2,Y2,"r+");
  hold on;
  plot(X2,Ybis,"g*");
end




disp('= DATA VIN BLANC==========================================================');
disp('nbDonnees = nombre de donnees')
disp('MC = Erreur au sens des moindres carrés');
disp('PC = Erreur en pourcentage');
disp('EC = Ecart moyen des notes avec les notes réelles');
disp('E05 = nombre derreur de notation à 0.5 près');
disp("================== Erreur Théorique ===================================");

nbDonnees = datasize
MC = erreurMC(Y2,Ybis)
PC = erreurP(Y2,Ybis)
EC = erreurEC(Y2,Ybis)
E05 = erreurE05(Y2,Ybis)

if DETAIL == 1 then
disp("============================== Erreur =================================");
end

muMC = 0;
muPC = 0;
muEC = 0;
muE05 = 0;

for i=1 : PART
  [xapp yapp xval yval] = crossval(X2,Y2,PART,i);

  w2 = (xapp'*xapp)\(xapp'*yapp);
  ytrouve = xval*w2;

  ymodele = xapp*w2;

if FIG == 1 then
  figure(i);
  plot(xval,yval,"b*");
  hold on;
  plot(xval,round(ytrouve),"r+");
end


  
  MC = erreurMC(yapp,ymodele);
  PC = erreurP(yapp,ymodele);
  EC = erreurEC(yapp,ymodele);
  E05 = erreurE05(yapp,ymodele);

  if DETAIL == 1 then
    disp(i)
    disp("=Erreur Apprentissage:");
    disp(MC);
    disp(PC);
    disp(EC);
    disp(E05);
  end
 

  MC = erreurMC(yval,ytrouve);
  PC = erreurP(yval,ytrouve);
  EC = erreurEC(yval,ytrouve);
  E05 = erreurE05(yval,ytrouve);

  if DETAIL == 1 then
    disp(i)
    disp("=Erreur Test:");
    disp(MC);
    disp(PC);
    disp(EC);
    disp(E05);
    disp("\n");
  end

  muMC = MC + muMC;
  muPC = PC + muPC;
  muEC = EC + muEC;
  muE05 = E05 + muE05;


  
end

disp("=========================== En moyenne ==============================");
MC = muMC/PART
PC = muPC/PART
EC = muEC/PART
E05 = muE05/PART
