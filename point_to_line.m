function [d] = point_to_line(P,a,b,c)
%Calcul la distance algébrique d'un point p à une droite définie comme :
%ax+by+c=0

    x=P(1); y=P(2);
    
   if abs(a)~=inf 
        d=-(a*x+b*y+c)/sqrt(a^2+b^2);
    else 
        d=sign(a)*(c-x);
    end
    
end

