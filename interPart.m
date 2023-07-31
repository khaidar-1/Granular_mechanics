function [F1,F2] = interPart(P1,P2,V1,V2,R1,R2)
    %CONSTANTES
    kn=900; %constante de raideur pour interraction normale 
    kt=30;  %constante de raideur pour interraction tangentielle
    amortissement=20; %coefficient damortissement visqueux
    mu=0.005; %coefficient de frottement

    F1=[0;0]; F2=[0;0];

    deltan=norm(P1-P2)-R1-R2; %distance entre deux grains à leur bord (normal)
    norme=norm(P1-P2); %norme du vecteur distance positions
    
    if(deltan<0) %si les grains sont en contact
        %NORMAL
        normale=(P1-P2)/norme; %vecteur unitaire normal de contact
        ddeltan=dot((V1-V2), normale); %produit scalaire
        Fn=-kn*deltan-amortissement*ddeltan; %norme de force applique suivant le vecteur nomale
        F1= F1+Fn.*normale;
        F2= F2-Fn.*normale;
        
        %TANGENTIEL
        tang=[-normale(2)/norme;normale(1)/norme]; %vecteur unitaire tangentiel de contact
        deltat=mu*Fn/kt;
        %ddeltat=dot((-V1+V2), tang); 
        Ft1=abs(-kt*deltat);
        if(Ft1<=mu*Fn)
            F1= F1+Ft1.*tang;
            F2= F2-Ft1.*tang;
        elseif(Ft1>mu*Fn)
            Ft2=-kt*deltat*mu*Fn;
            F1= F1+Ft2.*tang;
            F2= F2-Ft2.*tang;
        end
    end
end

