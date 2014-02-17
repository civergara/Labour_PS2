Labour_PS2
==========
function lc=labourOptimization(hoursGrid,labourIncome,nonLabourIncome,preferenceShock,boundaryIncome,...
    ttau,ggamma,ttheta,aalpha)

n=length(labourIncome(:,1));
taxes=zeros(n,5);
for i=1:5
    for j=1:n
        if labourIncome(j,i)>boundaryIncome
            taxes(j,i)=labourIncome(j,i)*ttau;
        end
    end
end

consumption=nonLabourIncome+labourIncome-taxes;
utility=ggamma*(consumption.^ttheta/ttheta-aalpha*ones(n,1)*hoursGrid)+preferenceShock;

[maxUtility gridLabor]=max(utility');

lc=zeros(n,1);
for i=1:n
    lc(i)=hoursGrid(gridLabor(i));
end

end
