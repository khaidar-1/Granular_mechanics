%TEST POUR SAVOIR SI LES BOULES SONT IMMOBILES
function[imm, vanne_ouverte]=immobilite(v,vanne_ouverte,tol)
    imm=true; %les particules bougent encore
    moyVitesse=moyTab(v); %vitesse moyenne

    if moyVitesse>tol
        imm=false;
    end
    
    if imm==true
        vanne_ouverte=true;
    end
end