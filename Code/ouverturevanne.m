if immobilite(vitesse, nbpar)==true %la vanne s'ouvre quand les grains sont tous immobiles
    dt=1; %temps �coul� entre deux iterrations 
    Niter=70; %Nombre d'iterrations
    %nb_grains_total=nbpar; %d�cr�mentation du nombre de grain dans la vanne
    nb_passes=0; %nombre de grains sortis de la vanne
    Masse=0; %incr�ment de la masse pass�e
    Volume=0; %incr�ment du volume pass�
    
    for i=1:Niter
        for j=1:nbpar
            if pos(2,j)==0
                Masse=Masse+tableaugrains(2,j);
                Volume=Volume+tableaugrains(3,j);
                nb_passes=nb_passes+1;
            end
        end
        %nb_grains_total= nb_grains_total - nb_passes;
    end
end

temps=Niter*dt;
debit=nb_passes/temps;
debit_massique=Masse/temps;
debit_volumique=Volume/temps;