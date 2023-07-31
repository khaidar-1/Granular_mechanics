function [Coeff] = pointsToCoeff(P)
%pointToCoeff Tableau de points -> ax+by+c=0
%   Prend en entree un tableau de point et ressort un tableau de
%   coefficients (a,b,c) de type ax+by+c=0 pour chaque segmement reliant les points
%   Pour une fonction de type x=d, a=inf si droite défini comme montante et
%   a=-inf si inverse, c indique l'absisse

Coeff = zeros(3,length(P)-1);

for i=1:length(P)-1
    Coeff(1,i)=(P(2,i+1)-P(2,i))/(P(1,i+1)-P(1,i));
    Coeff(2,i)=-1;
    Coeff(3,i)=P(2,i)-Coeff(1,i)*P(1,i);

    if abs(Coeff(1,i))==inf
            Coeff(3,i)=P(1,i);
    end
end
end

