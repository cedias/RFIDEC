close all;
clear all;
 %Exercice n°tp10_3

 function [vect] = SVM(xapp,yapp,epsilon,lbd,niter)
 sizeXapp = size(xapp);
 w = zeros(sizeXapp(2),1); 

 for i=0:niter
 	
 	indeX=floor(rand(1)*100+1);
 	xi = xapp(indeX,:);
 	yi = yapp(indeX);
 	
 	if (yi*xi*w < 1)
 		w = w + epsilon*yi*xi';
 	end
 	w = w-2*epsilon*lbd*w;
 	

 end

 vect = w;
 endfunction

 napp = 100;
 ntest = 1000;
 bruit = 0.35;
 [xapp,yapp,xtest,ytest] = dataset('gaussian', napp, ntest, bruit);

 w = SVM(xapp,yapp,0.01,0.1,1000);


 figure
 plot(xapp(yapp==1,1), xapp(yapp==1,2), '+');
 hold on;
 plot(xapp(yapp==-1,1), xapp(yapp==-1,2), 'ro');

 xgrid = generateGrid(xapp,100);
 ygrid = xgrid*w;
 plotFrontiere(xgrid,ygrid);
