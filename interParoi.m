function [Fpar] = interParoi(P,V,R,imm)
    %% CONSTANTES
    %silot
    k=900; %coefficient elastique
    lambda=10; %coeff de frottement visqueux
    lambdavit=0.1; %Coeff frottement
    %receptacle
    k2=k; %coefficient elastique
    lambda2=20; %coeff de frottement visqueux
    
    %% INITIALISATIONS
    Fpar=[0;0]; %force d'interaction avec la paroi renvoyée par la fonction
    x=P(1); y=P(2); %coordonnées de la particules
    [Points,Coeff,~,Coeff2]=paroi(); %Chargement des fonctions de paroi
    d=zeros(1,length(Coeff)); %tableau des distance de la particule au parois du silot
    d2=zeros(1,length(Coeff2)); %tableau des distance de la particule aux parois du receptacle
    if P(1)<Points(1,3)+.5*R || P(1)>Points(1,4)-.5*R
        surPentes=true; % absisse sur les pentes
    else
        surPentes=false;
    end
    
    %% CALCUL DES FORCES
    if  P(2)>0
        %GESTION SILOT
        for i=1:length(Coeff)
            d(i)=point_to_line(P,Coeff(1,i),Coeff(2,i),Coeff(3,i))-R;

            if d(i)<0
                omega=atan(Coeff(1,i));
                % Calcul du vecteur normal
                if omega==0
                      vectnorm=[0;1];
                      vecttan=[-1;0];
                elseif omega==pi/2
                      vectnorm=[-1;0];
                      vecttan=[0;-1];
                elseif omega==-pi/2
                      vectnorm=[1;0];
                      vecttan=[0;-1];
                else   
                    if surPentes==true
                      vectnorm=-[Coeff(1,i);Coeff(2,i)]./norm([Coeff(1,i);Coeff(2,i)]);
                      vecttan=[1;Coeff(1,i)]./norm([1;Coeff(1,i)]);
                    else
                      vectnorm=zeros(2,1);
                      vecttan=zeros(2,1); 
                    end
                end
                if imm==true
                    if Coeff(1,i)~=0
                        Fpar=Fpar-lambda.*dot(V,vectnorm).*vectnorm-k*d(i).*vectnorm-lambdavit*dot(V,vecttan).*vecttan;
                    end
                else 
                    Fpar=Fpar-lambda.*dot(V,vectnorm).*vectnorm-k*d(i).*vectnorm-lambdavit*dot(V,vecttan).*vecttan;
                end
            end
        end
    end
    
    if imm==true && P(2)<-1
        %GESTION RECEPTACLE
        for i=1:length(Coeff2)
            d2(i)=point_to_line(P,Coeff2(1,i),Coeff2(2,i),Coeff2(3,i));
            omega=atan(Coeff2(1,i));
            % Calcul du vecteur normal
            if omega==0
                      vectnorm=[0;1];
            elseif omega==pi/2
                      vectnorm=[-1;0];
            elseif omega==-pi/2
                      vectnorm=[1;0];
            else
                  d2(i)=-d2(i);
                  vectnorm=-[Coeff2(1,i);Coeff2(2,i)]./norm([Coeff2(1,i);Coeff2(2,i)]);
            end
            if (d2(i)-R)<0
                Fpar=Fpar-lambda2.*dot(V,vectnorm).*vectnorm-k2*(d2(i)-R).*vectnorm; %force d'amortissement
            end
        end
    end
end
