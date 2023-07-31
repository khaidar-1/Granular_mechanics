function [moy]=moyTab(v)
    normeTab = zeros(1,length(v));
    for i=1:length(v)
        normeTab(i)=norm(v(:,i));
    end
    moy=mean(normeTab);
end

