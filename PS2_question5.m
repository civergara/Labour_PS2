Labour_PS2
==========
%% Problem Set 2 Labour Economics
%  Question 5: ContraFactual Experiment

%% Previous Revenue

revenueBefore=zeros(n,1);
for i=1:n
    if wage(i)*labourChoice(i)>80
        revenueBefore(i)=wage(i)*labourChoice(i)*ttau;
    end
end     

%% New Optimization

ttau=.2;

labourChoice=labourOptimization(hoursGrid,labourIncome,nonLabourIncome,preferenceShock,boundaryIncome,...
    ttau,ggamma,ttheta,aalpha);

histfit(labourChoice,5)
xlabel('Work Hours')
ylabel('Frequency')
axis([-20 60 0 300])

mean(labourChoice)
std(labourChoice)

%% Revenue After the Reform 

revenueAfter=zeros(n,1);
for i=1:n
    if wage(i)*labourChoice(i)>80
        revenueAfter(i)=wage(i)*labourChoice(i)*ttau;
    end
end     

sum(revenueBefore)
sum(revenueAfter)

%% Equivalent Constant Marginal Tax Rate

revenueDifference=@(ttau) abs(sum(labourOptimization(hoursGrid,labourIncome,nonLabourIncome,preferenceShock,0,...
    ttau,ggamma,ttheta,aalpha).*wage*ttau)-sum(revenueBefore))

[tax diff] = fminunc(revenueDifference,.5)

labourChoice=labourOptimization(hoursGrid,labourIncome,nonLabourIncome,preferenceShock,0,...
    tax,ggamma,ttheta,aalpha);

histfit(labourChoice,5,'kernel')
xlabel('Work Hours')
ylabel('Frequency')
axis([-20 60 0 300])

mean(labourChoice)
std(labourChoice)

