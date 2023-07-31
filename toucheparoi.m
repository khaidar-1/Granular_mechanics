%TEST SI COLLISION AVEC PAROI
function [touche] = toucheparoi(x,y,rayon)
    coef1=2;
    coef2=-2;
    ordo=-6;
    touche=false;
    if (x<3-rayon || x>-3+rayon) && y<rayon
        touche=true;
    end
    if x<-3+rayon && y<coef2*x+ordo+2*rayon
        touche=true;
    end
    if x>3-rayon && y<coef1*x+ordo+2*rayon 
        touche=true;
    
    end 
    
end