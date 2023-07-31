function [xp,yp]=coordCercle(x,y,r)
%dessine un cercle au point x,y de rayon r
    ang=0:0.5:2*pi; 
    xp=x+r*cos(ang);
    yp=y+r*sin(ang);
end