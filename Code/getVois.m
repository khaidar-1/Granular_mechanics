function [tab] = getVois(Pos,j,rMoy)
    Rlim=5*rMoy;
    Npart=length(Pos);
    P=Pos(:,j);
    compteur=1;
    
    tab(1)=0;
    
    for i=1:Npart
        if norm(P-Pos(:,i))<Rlim && i~=j
            tab(1,compteur)=i;
            compteur=compteur+1;
        end
    end
end

