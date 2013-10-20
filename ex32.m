close all;
clear all;
 %Exercice n°32

% _ <=> "Sachant"
% _E_ <=> "Et" 


Px = [0.3 0.7];
Py_x = [0.2 0.2 0.6; 0.4 0.5 0.1];
Pz_x = [0.7 0.3; 0.4 0.6];

%1 - sans loi jointe
Py = Px * Py_x
Pz = Px * Pz_x

%2
Px_E_y = [Py_x(1,:)*Px(1) ; Py_x(2,:)*Px(2)]
Px_E_z = [Pz_x(1,:)*Px(1) ; Pz_x(2,:)*Px(2)]

%1 - avec loi jointe
PyJoin = sum(Px_E_y)
PzJoin = sum(Px_E_z)

%3
Pxyz = zeros(2,3,2);
for i = 1 : 2
  for j = 1 : 3
    for k = 1 : 2
      Pxyz(i,j,k)=Px(i)*Py_x(i,j)*Pz_x(i,j);
      end
    end
 end
PxEz = sum(Pxyz,1);



%4
indPxPy = (sum(sum(Px_E_y - Px' * Py)))**2 
indPxPz = (sum(sum(Px_E_z - Px' * Pz)))**2 
indPyPz = (sum(sum(Py_E_z - Py' * Pz)))**2 
