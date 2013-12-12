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

 napp = 100;
 ntest = 1000;
 bruit = 0.35;
 [xapp,yapp,xtest,ytest] = dataset('gaussian', napp, ntest, bruit);

 yapp(yapp==-1) = 0;
 ytest(ytest==-1) = 0;

 g = gradiant(xapp,yapp,0.01,1000);

 figure
 plot(xapp(yapp==1,1), xapp(yapp==1,2), '+');
 hold on;
 plot(xapp(yapp==0,1), xapp(yapp==0,2), 'ro');

 xgrid = generateGrid(xapp,100);
 ygrid = reglog(xgrid,g);
 plotFrontiere2(xgrid,ygrid,1);
