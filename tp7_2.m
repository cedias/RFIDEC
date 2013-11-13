close all;
clear all;
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




data = load("data/donneesConcrete.dat");
X = data(:,1:5);
Y = data(:,6);
 
w = (X'*X) \ (X'*Y);
plot(X,Y,"r+");
hold on;


Ybis = X*w;
plot(X,Ybis,"g*");

= crossval(X,Y,3,1);



