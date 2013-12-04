close all;
clear all;
 %Exercice n°tp8
load('data/usps_napp10.dat'); % pas de data= car le nom des variables est codé dans le fichier
 % creation de xapp, yapp, xtest, ytest: à vous de vérifier les dimensions

function [proba] = borne(modele)
	proba = modele;
	if (modele==1)
		proba = 0.99999;
	end
	if (modele==0)
		proba = 0.00001;
	end
endfunction

function [likelyhood] = likelyhood(image,modele)
	%si 0 1-p
	%si 1 p
	likelyhood=1;
	for i=1:256
		proba = borne(modele(1,i));
		
			if (image(1,i)==0)
				likelyhood=likelyhood*(1-proba);
			end
			if (image(1,i)==1)
				likelyhood= likelyhood*proba;
			end	
			
	end
endfunction

function [likelyhoodVector] = likelyhoodModeles(image,modeles)
	likelyhoodVector = [];
	for i=1 : 10
		likelyhoodVector = [likelyhoodVector; likelyhood(image,modeles(i,:))]; 
	end
endfunction

function [classe] = classifyMaxLikelyhood(image,modeles)
 [a,b] = max(likelyhoodModeles(image,modeles));
 classe = b;
endfunction 



%Binarisation des données
scale = max(max(xapp));
xapp = round(xapp/scale);
xtest = round(xtest/scale);

%calcul modeles
modeles =[];
for i=1 :10
	muK = mean(xapp(i:i+10,:));
	modeles = [modeles;muK];
end
yFound=[];
for i=1 :1907
	yFound =[yFound; classifyMaxLikelyhood(xtest(i,:),modeles)];
end

size(find(yFound==ytest(1:1907)))(1)/1907*100 % 31,253%







% verification
%ch = reshape(xapp(50,:),16,16)'; % remise en carre de l'image
%subplot(1,2,2); % division en 2 pour affichage utlérieur
%imagesc(ch); % affichage

