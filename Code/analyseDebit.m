function [a,b,c,d] = analyseDebit(debit)
%Analyse le d�bit instantan�, valeur exprim�es en indice de tableau
%a : d�but �coulement, b : d�but r�gime permanent, c : fin r�gime permanent

a=-1; %d�but de l'�coulement
b=-1; %d�but du r�gime permanent
c=-1; %fin du r�gime permanent
d=-1; %fin de l'�couement

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

