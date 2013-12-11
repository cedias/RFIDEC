close all;
clear all;
 %Exercice tp9

 function [vect] = perceptron(xapp,yapp,epsilon,niter)
 sizeXapp = size(xapp);
 w = zeros(sizeXapp(2),1); 

 for i=0:niter
 	
 	indeX=mod(i,sizeXapp(1))+1;
 	xi = xapp(indeX,:);
 	yi = yapp(indeX);
 	
 	if (yi*xi*w <= 0)
 		w = w + epsilon*yi*xi';
 	end
 end

 vect = w;
 endfunction


 napp = 100;
 ntest = 1000;
 bruit = 0.35;
 [xapp,yapp,xtest,ytest] = dataset('gaussian', napp, ntest, bruit);
 figure
 plot(xapp(yapp==1,1), xapp(yapp==1,2), '+');
 hold on;
 plot(xapp(yapp==-1,1), xapp(yapp==-1,2), 'ro');
 hold on;
 pvect = perceptron(xapp,yapp,0.01,1000);

 yapp = sign(xapp*pvect);
 ytest = sign(xtest*pvect);
xgrid = generateGrid(xapp,100);
plotFrontiere(xgrid,yapp);
plot(xapp,xapp*pvect)




 