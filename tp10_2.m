close all;
clear all;
 %Exercice tp10

 function [y] = reglog(x,w)
 	y = 1 ./(1+exp(-x*w));
 endfunction

function [g] = gradiant(x,y,epsilon,nbIt)
	%init
	w = zeros(size(x)(2),1);
	for i=1:nbIt
		w = w + epsilon*(x'*(y-reglog(x,w)));
	end
	g = w;
endfunction


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 load('data/usps_napp10.dat');

  %%modeles
 modeles = [];
for(i=1:10) 
	ytmp = yapp;
	ytmp(ytmp != i) = 0;
	ytmp(ytmp == i) = 1;
	modeles = [modeles gradiant(xapp,ytmp,0.01,1000)];
end

allA = reglog(xapp,modeles);
[val,indA] = max(allA,[],2);
err = find(indA != yapp);
disp('nb erreur apprentissage');
errApp = size(err)(1)
prc = errApp/size(xapp)(1)*100

allT = reglog(xtest,modeles);
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
y(y==2)=0;
w = gradiant(x,y,0.01,1000);
figure
imagesc(reshape(w,16,16)');