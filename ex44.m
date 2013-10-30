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
gainMoyen = (nbWin-nbPertes)/5000           %----REPONSE 44.1


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
disp("\n44.2  dans Variables => matF1 et matF2");   %----REPONSE 44.2

%44.3

%1000 apprentissage: vect(1:3)

appr = data(:,1:3); %sans les resultats

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

disp("\n44.3 - 1000 apprentissage");    %----REPONSE 44.3
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
disp("\n44.3 - 4000 base de test");      %----REPONSE 44.3
nbWin = 4000-nbPertes

%44.4
%on veut passer la 3eme dim de 37 à 6
matF1b = cat(3,... %concatenation sur 3 dimensions
              sum(matF1(:,:,1:6),3),...
              sum(matF1(:,:,7:12),3),...
              sum(matF1(:,:,13:19),3),...
              sum(matF1(:,:,20:26),3),...
              sum(matF1(:,:,27:33),3),...
              sum(matF1(:,:,34:37),3)
            );

matF2b = cat(3,... %concatenation sur 3 dimensions
              sum(matF2(:,:,1:6),3),...
              sum(matF2(:,:,7:12),3),...
              sum(matF2(:,:,13:19),3),...
              sum(matF2(:,:,20:26),3),...
              sum(matF2(:,:,27:33),3),...
              sum(matF2(:,:,34:37),3)
            );

%gain sur 1000 ech d'apprentissage:

ech = data(1:1000,1:4);
mise = [];

for i=1 : 1000
  a = ech(i,1);
  b = ech(i,2);
  c = floor(ech(i,3)/6)+1; % si cl=0
  if(c == 7)
    c=6;
  end;

  F1 = matF1b(a,b,c);
  F2 = matF2b(a,b,c);

  if(F1>=F2)
    mise = [mise 1];
  else
    mise = [mise 2];
   end
end

ech = mise'- ech(:,4);
ech( ech !=  0 ) = 1;
nbPertes = sum(ech);
disp("\n44.4 - 1000 echantillons");    %----REPONSE 44.4
nbWin = 1000-nbPertes

%gain sur 4000 ech restant:

ech = data(1001:5000,1:4);
mise = [];

for i=1 : 4000
  a = ech(i,1);
  b = ech(i,2);
  c = floor(ech(i,3)/6)+1; % si cl=0
  if(c == 7)
    c=6;
  end;

  F1 = matF1b(a,b,c);
  F2 = matF2b(a,b,c);

  if(F1>=F2)
    mise = [mise 1];
  else
    mise = [mise 2];
   end
end

ech = mise'- ech(:,4);
ech( ech !=  0 ) = 1;
nbPertes = sum(ech);
disp("\n44.4 - 4000 echantillons");    %----REPONSE 44.4
nbWin = 4000-nbPertes

%44.6

%44.6.1 

%44.6.2

function [VRR VL CL F] = genererDonnees(N)
  VRR = binornd(2,0.5,N,1);
  VL = binornd(4,0.5,N,1);
  CL = round(rand(N,1).*37);
  F=[];
  for i=1 : N
  vitesseRotation = 0.2+VRR(i); % vitesse VRR
  nbTour = 0.2+VL(i); % nb tour de la bille suite 
                             % a la vitesse de lancé

  precisionMesureVRR = 0.01; 
  precisionVitesseVL = 0.005;
  precisionCL= 1;

  nbTours = (vitesseRotation+randn(1,1)*(precisionMesureVRR*3)) .* (nbTour+randn(1,1)*(precisionVitesseVL*3));
  chiffre = (nbTours-floor(nbTours))*36;
  Ftemp = round(CL(i)+randn(1,1)*precisionCL*3 + chiffre);
  F = [F ;mod(Ftemp, 37)];
  end

endfunction

[a b c d] = genererDonnees(1000);
tirage = [a b c d];

%44.6.3

distrib = hist(d,unique(d));
uDistrib = zeros(1,37)+(1000/37);

function [chiSq] = calculChiSq(cont,theorie)
  diff = (((cont - theorie).*(cont - theorie))./theorie);
  chiSq = sum(sum(diff));
endfunction

disp("\n44.6.3 - 1000 tirage - 36 degré de liberté ");    %----REPONSE 44.6.3
chisq = calculChiSq(distrib,uDistrib)
chiMax = chi2inv(0.95,36)
