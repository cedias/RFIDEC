close all;
clear all;
%Exercice n°tp 6

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
  g = 2*x'*(y-x*w);
g
endfunction

%Descente de gradient
function [a,b] = getModDesc(x,y,epsi)
  w0 =  [0;0];
  ya = y';
  xa = [x' ones(size(x,2),1)];
  for i=1:1000
  w0 = w0 - epsi*grad(xa,ya,w0);
  end
  a=w0(1);
  b=w0(2);
endfunction
%----------------------------------------------------------------------------------
%variables
nbEch = 100;
a = 3;
b = 5;
noiseVsq = 40;

[x y] = genData(nbEch,a,b,noiseVsq);
%plot
figure
plot(x,y,"b+");
hold on;

%getModStat:
[as bs] = getModStat(x,y);

xs = [1:0.2:100];
ys = xs.*as+bs;

disp("STATISTIQUE");
disp("[a a_retrouvé]");
[a as] 
disp("[b b_retrouvé]");
[b bs]

plot(xs,ys,"r*"); 

%getModMinSQ:
[am bm] = getModMinSQ(x,y);

xm = [1:0.2:100];
ym = xm.*am+bm;
disp("MINSQ");
disp("[a a_retrouvé]");
[a am] 
disp("[b b_retrouvé]");
[b bm]

plot(xm,ym,"g+"); 

%getModDesc:
[ag bg] = getModDesc(x,y,0.001);

xg = [1:0.2:100];
yg = xg.*ag+bg;


disp("GRADIENT");
disp("[a a_retrouvé]");
[a ag] 
disp("[b b_retrouvé]");
[b bg]

plot(xg,yg,"b-"); 