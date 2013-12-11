close all;
clear all;
 %Exercice tp9_2

 function [vect] = perceptron(xapp,yapp,epsilon,niter)
 sizeXapp = size(xapp);
 w = zeros(sizeXapp(2),1); 

 for i=0:niter
 	indeX=floor(rand(1)*sizeXapp(1)+1);

 	xi = xapp(indeX,:);
 	yi = yapp(indeX);
 	
 	if (yi*xi*w <= 0)
 		w = w + epsilon*yi*xi';
 	end
 end

 vect = w;
 endfunction

 load('data/usps_napp10.dat');
BINARY =0;
 %calcul des modeles
if(BINARY ==1)
%Binarisation des données
	scale = max(max(xapp));
	xapp = round(xapp/scale);
	xtest = round(xtest/scale);
end

 %%modeles
 modeles = [];
for(i=1:10) 
	ytmp = yapp;
	ytmp(ytmp != i) = -1;
	modeles = [modeles perceptron(xapp,ytmp,0.01,1000)];
end
allA = xapp*modeles;
[val,indA] = max(allA,[],2);
err = find(indA != yapp);
disp('nb erreur apprentissage');
errApp = size(err)(1)
prc = errApp/size(xapp)(1)*100

allT = xtest*modeles;
[val,indT] = max(allT,[],2);
err = find(indT != ytest);
disp('nb erreur test');
errTest = size(err)(1)
prc = errTest/size(xtest)(1)*100

figure
for(i=1:10)
	subplot(3,4,i);
	imagesc(reshape(modeles(:,i),16,16)')
end

x= xapp(yapp==1|yapp==2,:);
y= yapp(yapp==1|yapp==2,:);
y(y==2)=-1;
w = perceptron(x,y,0.01,1000);
figure
imagesc(reshape(w,16,16)');

