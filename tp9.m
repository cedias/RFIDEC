close all;
clear all;
 %Exercice tp9

 function [vect] = perceptron(xapp,yapp,epsilon,niter)
 sizeXapp = size(xapp);
 w = zeros(sizeXapp(2),1); 

 for i=0:niter
 	
 	indeX=floor(rand(1)*100+1);
 	xi = xapp(indeX,:);
 	yi = yapp(indeX);
 	
 	if (yi*xi*w <= 0)
 		w = w + epsilon*yi*xi';
 	end
 end

 vect = w;
 endfunction



 function [vect] = perceptronDraw(xapp,yapp,epsilon,niter)

 xgrid = generateGrid(xapp,100);
 sizeXapp = size(xapp);
 w = zeros(sizeXapp(2),1); 
 
 for i=0:niter
 	
 	indeX=floor(rand(1)*100+1);
 	xi = xapp(indeX,:);
 	yi = yapp(indeX);
 	
 	if (yi*xi*w <= 0)
 		w = w + epsilon*yi*xi';
 		plot(xapp(yapp==1,1), xapp(yapp==1,2), '+');
		hold on;
		plot(xapp(yapp==-1,1), xapp(yapp==-1,2), 'ro');
		ygrid = xgrid*w;
		plotFrontiere(xgrid, ygrid);
		hold off; % pour que l'itération suivante écrase la précédente
		drawnow % pour forcer l'affichage maintenant
		sleep(0.1);
 	end
 end

 vect = w;

 endfunction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 napp = 100;
 ntest = 1000;
 bruit = 0.35;
 [xapp,yapp,xtest,ytest] = dataset('gaussian', napp, ntest, bruit);



 figure
 plot(xapp(yapp==1,1), xapp(yapp==1,2), '+');
 hold on;
 plot(xapp(yapp==-1,1), xapp(yapp==-1,2), 'ro');
 
 pvect = perceptron(xapp,yapp,0.01,1000);

 yapp = sign(xapp*pvect);
 ytest = sign(xtest*pvect);
xgrid = generateGrid(xapp,100);
	ygrid=xgrid*pvect;
plotFrontiere(xgrid,ygrid);

perceptronDraw(xapp,yapp,0.01,1000);



 