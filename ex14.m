clear all;
close all;

% exercice n°14 

%chargement notes
notes = load("data/ex14.dat");

%calcul coefficient corrélation linéaire: covariance/produit variances

%moyennes des notes
moy = mean(notes);


%coeff
Coeff = cov(notes(:,1),notes(:,2))/(std(notes(:,1))*std(notes(:,2)));

%plot
figure
plot(notes(:,1),notes(:,2),"b+");
hold on;
%changement
exCoeff = Coeff;
notes = [40 70;notes];
Coeff = cov(notes(:,1),notes(:,2))/(std(notes(:,1))*std(notes(:,2)));
[exCoeff Coeff]

plot(notes(1,1),notes(1,2),"r+");
