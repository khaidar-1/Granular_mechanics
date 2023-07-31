 function [tabgrains] = iniGrains(nbgrains,rMoy,ecartType,sig)
    tabgrains=zeros(3,nbgrains); %tableau des grains vides
    for i=1:nbgrains
        tabgrains(1,i)=normrnd(rMoy,ecartType); %rayon des grains
        tabgrains(2,i)=2*pi*tabgrains(1,i)^2; %aire de la section des grains
        tabgrains(3,i)=sig*tabgrains(2,i); %masse de la section du grain       
    end
end