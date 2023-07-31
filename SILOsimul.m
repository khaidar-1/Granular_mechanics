clear;
close all;
clc;

%% CONSTANTES & PARAMETRES
tic
g=9.81;
rMoy=0.3; %rayon moyen
ecartType=0.03; %ecart type au rayon 0.04
sig=0.2; %masse surfacique
NBparttheo=1000; %nombre de particlues � placer
freqrecording = 1; %fr�quence d'enregistrement de pos et v sur le disque
%TEMPOREL
dt=0.002;
ti=0; tf=20;
Niter=round((tf-ti)/dt);
t=0:Niter+1; %Timeline
%GRAINS
tabgrains = iniGrains(NBparttheo,rMoy,ecartType,sig);
[Npart,pos,lesgrains]=iniPos(tabgrains,rMoy+2*ecartType); %tableau des positions x,y
v=zeros(2,Npart); %tableau des vitesses
f=zeros(2,Npart); %tableau des forces
r=lesgrains(1,:); %rayon des grains
m=lesgrains(3,:); %masse des grains
s=lesgrains(2,:); %surface des grains
[tabVoisin] = tabVois(pos,rMoy);

%% GESTION DE LA VANNE
vanne_ouverte=false; %boolean qui indique si la vanne est ouverte, initialis� � false car la vanne est initialement ferm�e
imm=false;
iouverture = -1; %valeur de i pour la quelle la vanne s'ouvre
tolerance=2.5; %tolerance sur la vitesse pour ouverture

%% SAUVEGARDE SUR DISQUE des donnn�es utiles � l'affichage
%gestion du dossier save
saveINFO = dir('save'); %donn�es sur le dossier save
if isempty(saveINFO) == 0
 rmdir save s
end
mkdir save
mkdir save\positions
%sauvegarde des informations concernant le syst�me
save('.\save\rayons','r'); %sauvegarde des rayons al�atoires
save('.\save\Niter','Niter'); %sauvegarde du nombre d'it�rations
save('.\save\freqrecording','freqrecording'); %sauvegarde de la fr�quence d'enregistrement
save('.\save\masses','m'); %sauvegarde des masses
save('.\save\surfaces','s'); %sauvegarde des surfaces
save('.\save\dt','dt'); %sauvegarde du dt
save('.\save\masseVolumique','sig'); %sauvegarde du dt
save('.\save\Npart','Npart'); %sauvegarde du nombre de particules
[~,~,~,~,dimSilo] = paroi();
save('.\save\dimSilo','dimSilo');

%% DEBUT INTERFACE
fprintf('Nombre d''it�rations : ');
fprintf(int2str(Niter));
fprintf('\n');
fprintf('Nombre de grains : ');
fprintf(int2str(Npart));
fprintf('\n\n');
fprintf('Progression : 0%% ');
prog=0; %pourcentage de progression du calcul


tic
for i=1:Niter+1
    if mod(i,25)==0
        [tabVoisin] = tabVois(pos,rMoy);
    end
    checkVois=zeros(Npart,Npart);
    

    %% FORCES
    f=zeros(2,Npart);
    % FORCE INTERACTION PAROIE
    for j=1:Npart
       if vanne_ouverte==false && i>200 %si la vanne est ferm�e
            [imm,vanne_ouverte]=immobilite(v,vanne_ouverte,tolerance);
       end
       if iouverture==-1 && vanne_ouverte==true %enregistrement de l'it�ration ou la vanne s'est ouverte
           iouverture=i;
       end
       
       Fpar = interParoi(pos(:,j),v(:,j),r(j),imm);
       f(:,j)=f(:,j)+Fpar;
    end 
    % FORCE INTERACTION ENTRE PARTICULES
    for j=1:Npart
        NpartVois=length(tabVoisin{j});
        for l=1:NpartVois
            part=tabVoisin{j}(l);
            if part~=0 && checkVois(j,part)~=1
                 checkVois(j,part)=1; checkVois(part,j)=1;
                [F1,F2]=interPart(pos(:,j),pos(:,part),v(:,j),v(:,part),r(j),r(part));
                f(:,j)=f(:,j)+F1;
                f(:,part)=f(:,part)+F2;
            end
        end
    end
    % FORCE DE PESANTEUR
    for j=1:Npart
        if pos(2,j)<30
            f(:,j)=f(:,j)+[0;-m(j)*g];
        else
            f(:,j)=f(:,j)+[0;-m(j)*g]-0.2.*v(:,j);
        end
    end

    %% INTEGRATION PAR VERLET
    for j=1:Npart
        a=f(:,j)./m(j);
        v(:,j)=v(:,j)+a.*dt;
        pos(:,j)=pos(:,j)+v(:,j).*dt;
    end
    
    %% PROGRESSION
    if mod(i,round(Niter/10))==0
        prog=prog+10;
        fprintf(int2str(prog));
        fprintf('%% ');
    end
    
    
    %% ENREGISTREMENT DU VECTEUR POSITION
    if mod(i,freqrecording)==0
        Nomsave=['./save/positions/PosVit_',sprintf('%.5d',i/freqrecording)];
        save(Nomsave,'pos','v');
    end
end

%% FIN INTERFACE
fprintf('\n');
toc
fprintf('\n');
save('.\save\iouverture','iouverture');
fprintf('Vanne ouverte � l''it�ration :');
disp(iouverture);
clear;
close all;
disp('Calcul TERMIN� ! Mise en Cache du silot...');
toc
SILOpreview();
disp('Video cr�e !');
