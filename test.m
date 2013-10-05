clear all;
close all;

%matrice notes
nbEleve = 15;
ecartType = 4;
notes = randn(nbEleve, 2);
notes = notes .* ecartType;
notes(:,1)+= 10;
notes(:,2)+= 8;
notes = max(notes,0);
notes = min(notes,20);
notes = round(notes);


%matrice boucle
for i=1:10
  for j=1:10
    if mod(i+j,2)== 0 % pair
      matrix(i,j)=ceil(rand(1,1)*100)*2;
    else
      matrix(i,j)= i+j;
    endif
  endfor
endfor

%plot
Vx=-5:0.5:10;
Fx=Vx.*Vx+Vx-1;
%figure
%plot(Vx,Fx,"g*");


