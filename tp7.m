close all;
clear all;
%Exercices: tp 7

%Generation de données
function [x y] = genData(n,a,b,noiseVSq)
%randn
  x = [1:n];
  y = (x .* a) + b;
  noise = rand(1,n)*noiseVSq;
  y =  y+noise;
endfunction

%Recuperation Modèle Stat
function [a b] = getModStat(x,y)
a = cov(x,y)/var(x);
b = mean(y) - a*mean(x);
endfunction

%Recuperation Mode minCarre
function [a,b] = getModMinSQ(x,y)
xa = [x' ones(size(x,2),1)];
ya = y';
w = (xa'*xa)\(xa'*ya);
a = w(1);
b = w(2);
endfunction

%gradiant
function [g] = grad(x,y,w)
  g = -2*x'*(y-x*w);
endfunction

%Descente de gradient
function [a,b] = getModDesc(x,y,epsi,iter,nbEch)
  w0 =  [0;0];
  ya = y';
  xa = [x' ones(size(x,2),1)];
  for i=1:iter
  w0 = w0 - epsi*grad(xa,ya,w0)*1/nbEch;
  end
  a=w0(1);
  b=w0(2);
endfunction
%----------------------------------------------------------------------------------
%variables
nbEch = 100;
a = 1;
b = 2;
noiseVsq = 5;
epsi = 0.0001;
iter = 1000;

[x y] = genData(nbEch,a,b,noiseVsq);

%plot
figure
plot(x,y,"b+");
hold on;

%getModStat:
[as bs] = getModStat(x,y);

xs = [1:0.2:100];
ys = x*as+bs;

disp("STATISTIQUE");
disp("[a a_retrouvé]");
[a as] 
disp("[b b_retrouvé]");
[b bs]

plot(x,ys,"r"); 

%getModMinSQ:
[am bm] = getModMinSQ(x,y);

xm = [1:0.2:100];
ym = x*am+bm;
disp("MINSQ");
disp("[a a_retrouvé]");
[a am] 
disp("[b b_retrouvé]");
[b bm]

plot(x,ym,"g"); 

%getModDesc:
[ag bg] = getModDesc(x,y,epsi,iter,nbEch);

xg = [1:0.2:100];
yg = x*ag+bg;


disp("GRADIENT");
disp("[a a_retrouvé]");
[a ag] 
disp("[b b_retrouvé]");
[b bg]

plot(x,yg,"b"); 

%analyse solution
%solution Analytique: [as bs] et [am bm]
figure
plot(a,b,"g+");
hold on;

 w0 =  [0;0];
  ya = y';
  xa = [x' ones(size(x,2),1)];
  for i=1:iter
    w0 = w0 - epsi*grad(xa,ya,w0)*1/nbEch;
    plot(w0(1),w0(2),"r+")
  end
  a=w0(1);
  b=w0(2);
