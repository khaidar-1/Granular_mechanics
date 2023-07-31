function [P1,Coeff,P2,Coeff2,dimSilo] = paroi()
%gère la paroi
    d=12; o=1.5; h=2; %paramètres du silot;
    P1=[[-d;50],[-d;h],[-o;0],[o;0],[d;h],[d;50]]; %silot supérieur
    l=15;
    P2=[[-o;0],[-l;-3],[-l;-12],[l;-12],[l;-3],[o;0]]; %réceptacle
      
    %Droites de la forme ax+by+c=0
    Coeff=pointsToCoeff(P1);
    Coeff2=pointsToCoeff(P2);
    
    dimSilo=[2*d,2*o,h];
end

