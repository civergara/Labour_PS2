Labour_PS2
==========
%% Problem Set 2 Labour Economics
%  Question 4: Estimate Likelihood

%% Likelihood

data=[nonLabourIncome(:,1), wage, labourChoice];
knownParameters=[ttau, boundaryIncome];
N=5;

newLikelihood=@(unknownParameters) -likelihood(unknownParameters,knownParameters,data,hoursGrid,N);

%% Selection of initial values
 
% For mu and sigma we can use the moments of the observed wages

observedWages=zeros(n-sum(labourChoice==hoursGrid(1)),1);
j=1;
while j<=length(observedWages)
    for i=1:n
        if labourChoice(i)>hoursGrid(1)
            observedWages(j)=log(wage(i));
            j=j+1;
        end
    end
end

% For theta and alpha let's assume 0.1 and for gamma 1. 

%% Solution of the optimization problem

% unknown parameters have to be assigned in the following order: [ttheta, mmu, ssigma, aalpha, ggamma]

solution=fminunc(newLikelihood,[.1,mean(observedWages),std(observedWages),.1,1])

