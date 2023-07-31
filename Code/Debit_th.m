%CALCUL DU DEBIT MASSIQUE THEORIQUE

%PARAMETRES ENTREE
% ouverture est la longueur du trou de l'écoulement du silo
% diam_slio est le diamètre du haut du silo

%PARAMETRES SORTIE
% conditions_verif est un boolean qui renvoie true si les hypothèses du calcul sont vérifiées
% debit_massique_th est le débit massique théorique calculé

function [conditions_verif,debit_massique_th] = Debit_th()

    load('.\save\dimSilo');
    load('.\save\masseVolumique');
    ouverture=dimSilo(2)*2;
    diam_silo=dimSilo(1)*2;

    %CONDITIONS DE CALCULS VERIFIEES
    if diam_silo>8*ouverture
        conditions_verif=true;
    else 
        conditions_verif=false;
    end
    
    %CALCUL DU DEBIT MASSIQUE
    g=9.80665; %constante gravitationnelle en m.s^-2
    k=8; 
    C=0.5; %ompacité
    debit_massique_th=sig*C*g^.5*(diam_silo-k*ouverture)^1.5;
end

