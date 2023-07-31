function [F]=SILOpreview()
    tic
    close all;
    load('.\save\rayons');
    load('.\save\Niter');
    load('.\save\freqrecording');
    load('.\save\iouverture');
    load('.\save\dt');
    load('.\save\masseVolumique');
    load('.\save\dimSilo');
    dernierfichier = Niter/freqrecording;
    frmRate=24;
    freqAffichage=round(1/(dt*frmRate));
    time=0;
    
    
    %détermine le nombre de particules
    load('.\save\positions\PosVit_00001');
    nbpart=length(pos);
    %gestion du dossier du cache
    saveINFO = dir('save\img');
    if isempty(saveINFO) == 0
        rmdir save\img s
    end
    mkdir save\img
    %spaceline
    ex=20; %limites en x
    [P,~,P2,~] = paroi();
    figure('Name','Silot','units','normalized','outerposition',[0 0 1 1])
    F(round(dernierfichier/freqAffichage)-1) = struct('cdata',[],'colormap',[]);
    
    writerObj = VideoWriter('silo.avi');
    writerObj.FrameRate = frmRate;
    open(writerObj);

    for w=1:round(dernierfichier/freqAffichage)-1  % affichage des fichiers save      
        rax=strcat('.\save\positions\PosVit_',sprintf('%.5d',freqAffichage*w));
        load(rax);
        
        figure(1);
        clf;
        subplot(3,1,[1;2]);
        time=time+freqAffichage*dt;
        
        %affichage des parois et des grains
        for j=1:length(pos) %particules
            hold on; 
            [X,Y]=coordCercle(pos(1,j),pos(2,j),r(j));
            fill(X,Y,norm(v(:,j)));
            hold on;
        end
        for j=1:length(P)-1 %silot
            if freqAffichage*w<iouverture || iouverture ==-1
            line([P(1,j),P(1,j+1)],[P(2,j),P(2,j+1)]);
            else
                if j~=3
                    line([P(1,j),P(1,j+1)],[P(2,j),P(2,j+1)]);
                end
            end
        end
        for j=1:length(P2)-1 %réceptacle
            line([P2(1,j),P2(1,j+1)],[P2(2,j),P2(2,j+1)]);
        end
        line([-15 15],[30,30]);
        %réglages de l'affichage
        axis([-ex ex -15 15]);
        axis equal
        title('LE SILOT A GRAINS');
        grid on;
        colorbar;
        caxis([0 20]); %Echelle de couleur
        colormap('jet');
        
        %affichage du textbox
        nombrepart=strcat('Nombre de grains : ',32,int2str(nbpart));
        vitmoy=strcat('Vitesse moyenne : ',32,num2str(sprintf('%1.3f',moyTab(v))),' m/s');
        if w*freqAffichage<iouverture
            vanne='Vanne fermée';
        else
            vanne='Vanne ouverte !';
        end
        timestr=strcat(num2str(time),'s');
        masseVol=strcat('Masse Surfacique :',32,num2str(sig),32,'kg/m2');
        ouverture=strcat('Ouverture :',32,num2str(dimSilo(2)),32,'m');
        str={nombrepart,vitmoy,vanne,timestr, masseVol,ouverture};
        annotation('textbox',[0.68 0.46 0.1 0.1], 'String',str,'FitBoxToText','on'); 
        
        subplot(3,1,3);
        Debit(w*freqAffichage);
        
        drawnow; 
        
        %sauvegarde de la frame courante
        writeVideo(writerObj,getframe(1));
    end
    toc
    disp('Fin de la mise en cache !');
    close(writerObj);
  
end

