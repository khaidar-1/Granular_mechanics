function [a,b,c,d] = analyseDebit(debit)
%Analyse le débit instantané, valeur exprimées en indice de tableau
%a : début écoulement, b : début régime permanent, c : fin régime permanent

a=-1; %début de l'écoulement
b=-1; %début du régime permanent
c=-1; %fin du régime permanent
d=-1; %fin de l'écouement

    for i=2:length(debit)
        if a==-1 && debit(i)>0
            a=i-1;
        end
        if b==-1 && a~=-1 && debit(i)<=debit(i-1) 
            b=i-1;
        end
    end

j=length(debit)-1;
    if debit(length(debit))==0
        while j>=2

            if d==-1 && debit(j)>0
                d=j+1;
            end
            if c==-1 && d~=-1 && debit(j)<=debit(j+1) 
                c=j+1;
            end

            j=j-1;
        end
    else
        c=length(debit);
        d=c;
    end
end

