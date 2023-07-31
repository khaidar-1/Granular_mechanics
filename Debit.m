function Debit(instant)
    %% Chargement des fichiers propres � la simulation
    load('.\save\rayons');
    load('.\save\Niter');
    load('.\save\freqrecording');
    load('.\save\masses');
    load('.\save\surfaces');
    load('.\save\dt');
    load('.\save\Npart');
    load('.\save\iouverture');
    
    %% Initialisation
    dernierfichier = Niter/freqrecording;
    freqDeb=100;
    tabPasse=zeros(1,Npart);
    %time=freqDeb*dt:freqDeb*dt:(Niter*dt-freqDeb*dt);
    time=0:freqDeb*dt:Niter*dt;
    debitInst=zeros(1,length(time));
    
    %% Calcul du d�bit
    for w=1:dernierfichier
        if round(mod(w,freqDeb))==0   
            rax=strcat('.\save\positions\PosVit_',sprintf('%.5d',w));
            load(rax);
            
            comptDebit=0;
            for i=1:Npart
                if tabPasse(1,i)~=1 && pos(2,i)<-.5
                    comptDebit=comptDebit+m(i);
                    tabPasse(1,i)=1;
                end
            end
            debitInst(round(w/freqDeb))=comptDebit/(freqDeb*dt);
          
        end
    end
    
    %% Analyse de la figure
    [a,b,c,d] = analyseDebit(debitInst);
    if a>=0 && b>=0 && c>=0
        debitMoy=mean(debitInst(b:c));
    else
        debitMoy=0;
    end
    
    if a>0
        a=time(a);
    end
    if b>0
        b=time(b);
    end
    if c>0
        c=time(c);
    end
    if d>0
        d=time(d);
    end
    
    ylimits=[0 1.5*max(debitInst)];
    xlimits=[0 Niter*dt];
    
    %% Affichage
    figure(1);
    plot(time,debitInst,'r');
    hold on;
    plot(b:c,debitMoy.*ones(1,length(b:c)),'b');
    line([a a],ylimits,'LineStyle','--'); %d�but de l'�coulement
    line([b b],ylimits,'LineStyle','--'); %Debut du r�gime permanent
    line([c c],ylimits,'LineStyle','--'); %Fin du r�gime permanent
    line([d d],ylimits,'LineStyle','--'); %Fin de l'�coulement
    line([instant*dt instant*dt],ylimits); %Fin de l'�coulement
    ylim(ylimits);
    xlim(xlimits);
    legend('D�bit instantan�',strcat('D�bit Moyen :',32,num2str(debitMoy)));
    xlabel('Temps');
    ylabel('D�bit massique kg/m/s');
    title('D�bit massique');
    grid on;
     
    
    %% Th�orie
%     [~,debit_massique_th] = Debit_th();
%     fprintf(strcat('D�bit th�orique :',32,num2str(debit_massique_th),'\n'));
%     fprintf(strcat('D�bit exp�rimental :',32,num2str(debitMoy),'\n'));
end




