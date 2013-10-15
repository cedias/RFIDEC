close all;
clear all;
 %Exercice n°32

% _ <=> "Sachant"
% _E_ <=> "Et" 

function [Pb] = prob(Pa,Pa_b)
 Pb = Pa*Pa_b;
endfunction

X = [0.3 0.7];
Y_X = [0.2 0.2 0.6; 0.4 0.5 0.1]
Z_X = [0.7 0.3; 0.4 0.6]

%1
Y = prob(X,Y_X)
Z = prob(X,Z_X)


function [Pa_E_b] = probJ(Pa, Pb_a)
Pa_E_b = Pa * Pb_a;
endfunction

%2
Px_E_y = probJ(X,Y_X)
Px_E_z = probJ(X,Z_X)


%3
Py_E_z = sum(X) + sum(sum(Y_X)) + sum(sum(Z_X))