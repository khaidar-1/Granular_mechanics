function [nbpar,position,tableaugrains]=iniPos(tabgrains,r)
    close all
    Nlim=50; %max de boucles
    Nbpart=size(tabgrains,2); %nombre de grains au début
    [P,~,~,~] = paroi(); %informations sur le silo
    
    %Dimension du cube
    l=abs(P(1,1));
    h=35;
    ymin=P(2,2);
   
    pos=zeros(2,Nbpart); %stockage de toutes les positions
    nbpar=0;
    indice=0;
    tgrains=zeros(3,Nbpart);

    %INITIALISATION DES POSITIONS DES PARTICULES
    for i=1:Nbpart
        k=1;
        boolean = false; %boolean qui indique si le grain est placable
        while k<Nlim && boolean==false
            boolean=true;
            x=rand*2*(l-r)-(l-r); %position en x
            y=rand*h+ymin; %position en y
            coordonnees=[x;y];
            
            %Test collision avec les autres boules
            for j=1:Nbpart
                delta=norm(coordonnees-pos(:,j))-2*r;
                if delta<0
                    boolean=false;
                end
            end
            
            k=k+1;
        end
        
        if boolean==true %si la boule est placable
            nbpar=nbpar+1;
            indice=indice+1;
            pos(1,indice)=x;
            pos(2,indice)=y;
            tgrains(:,indice)=tabgrains(:,i);   
        end
    end
    
    %Creation du tableau des positions sans les colonnes nulles
    position=zeros(2,nbpar);
    tableaugrains=zeros(3,nbpar);
    for i=1:nbpar
        position(:,i)=pos(:,i);
        tableaugrains(:,i)=tgrains(:,i);
    end
end