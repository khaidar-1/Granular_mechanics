function [P1,Coeff,P2,Coeff2,dimSilo] = paroi()
%g�re la paroi
    d=12; o=1.5; h=2; %param�tres du silot;
    P1=[[-d;50],[-d;h],[-o;0],[o;0],[d;h],[d;50]]; %silot sup�rieur
    l=15;
    P2=[[-o;0],[-l;-3],[-l;-12],[l;-12],[l;-3],[o;0]]; %r�ceptacle
      
    %Droites de la forme ax+by+c=0
    Coeff=pointsToCoeff(P1);
    Coeff2=pointsToCoeff(P2);
    
    dimSilo=[2*d,2*o,h];
end

