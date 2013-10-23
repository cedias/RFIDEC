close all;
clear all;
 %Exercice n°44

%data 
loaded = load("data/ex44.dat");
data = loaded.X;

% X = [vRoulette vBille CFB resu]
vRoulette = data(:,1);
vBille = data(:,2);
CFB = data(:,3);
resu = data(:,4);

%taille des classes des Variables Aléatoires
nbClasseVRR = size(unique(vRoulette),1);
nbClasseVL = size(unique(vBille),1);
nbClasseCL = size(unique(CFB),1);
nbClasseF = size(unique(resu),1);


%44.1
%5000 mise aléatoires:

mise = [];
for i=1 : 5000
  mise = [mise round(rand())+1]; % mise = [1 2]
end

VectAlea = mise'- data(:,4);
VectAlea( VectAlea !=  0 ) = 1;  
nbPertes = sum(VectAlea);   
nbWin = 5000-nbPertes;

disp("\n44.1");
gainMoyen = (nbWin-nbPertes)/5000


%44.2
vrr = vRoulette(1:1000);
vl = vBille(1:1000);
cl = CFB(1:1000);
f = resu(1:1000);


vect = [vrr vl cl f]; %1000 premiers echantillons

matF1 = zeros(nbClasseVRR,nbClasseVL, nbClasseCL);
matF2 = zeros(nbClasseVRR,nbClasseVL, nbClasseCL);

for i=1 : 1000
  a = vect(i,1);%VRR
  b = vect(i,2);%VL
  c = vect(i,3)+1;%CL (+1 car une classe = 0)
  d = vect(i,4); %resultat
  if(d == 1)
    matF1(a,b,c) = matF1(a,b,c)+1;
  end;
  if(d == 2)
    matF2(a,b,c) = matF2(a,b,c)+1;
  end;
end

%cont -> proba
matF1 = matF1./sum(sum(sum(matF1))); 
matF2 = matF2./sum(sum(sum(matF2)));

%44.3

%1000 apprentissage: vect(1:3)

appr = vect(:,1:3); %sans les resultats

mise = [];
for i=1 : 1000
  a = appr(i,1);
  b = appr(i,2);
  c = appr(i,3)+1; % si cl=0

  F1 = matF1(a,b,c);
  F2 = matF2(a,b,c);

  if(F1>=F2)
    mise = [mise 1];
  else
    mise = [mise 2];
   end
end

vect = mise'- vect(:,4);
vect( vect !=  0 ) = 1;
nbPertes = sum(vect);

disp("\n44.2 - 1000 apprentissage");
nbWin = 1000-nbPertes

%4000 restant

jeu = data(1001:5000,:);
mise = [];
for i=1 : 4000
  a = jeu(i,1);
  b = jeu(i,2);
  c = jeu(i,3)+1;

  F1 = matF1(a,b,c);
  F2 = matF2(a,b,c);

  if(F1>=F2)
    mise = [mise 1];
  else
    mise = [mise 2];
   end
end

jeu = mise'- jeu(:,4);
jeu( jeu !=  0 ) = 1;
nbPertes = sum(jeu);
disp("\n44.2 - 4000 test");
nbWin = 4000-nbPertes

%44.4

%on veut passer la 3eme dim de 37 à 6

%idée; sommer 6 par 6 les 3emes dimensions
%sum(matF1(:,:,1:6),3)