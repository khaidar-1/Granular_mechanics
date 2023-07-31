function [tabVoisin] = tabVois(Pos,rMoy)
    Npart=length(Pos);
    %tabVoisin=zeros(Npart,1);
%     tabVoisin=cell(
    for i=1:Npart
        tabVoisin{i}=getVois(Pos,i,rMoy);
    end
end

