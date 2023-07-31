function [y]=ordParoi(x)

[P,Coeff] = paroi();
a=-1;
% for i=1:length(P)-1
%     if x=<P(1,i+1) && x>=P(1,i)
%         a=i;
%     end
% end

if x<P(1,2)
    a=1;
elseif x>=P(1,2) && x<P(1,3)
    a=2;
elseif x>=P(1,3)
    a=3;
end

k=Coeff(1,a);
c=Coeff(3,a);

f=@(t) k*t + c;
y=f(x);
end

