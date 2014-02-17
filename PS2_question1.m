Labour_PS2
==========
%% Problem Set 2 Labor Economics
%  Question 1: Generate Data Set and observe Labour Choice

clear all
close all

%% Parameters
n=1000;
hoursGrid=[0 10 20 30 40];
mmu=1;
ssigma=0.55;
ttau=0.3;
ttheta=0.3;
aalpha=0.1;
ggamma=2;
boundaryIncome=80;

%% Data generator

rng(10086)
wage=exp(mmu+ssigma.*randn(n,1));

rng(5403)
nonLabourIncome=(10+(100-10).*rand(n,1))*ones(1,5);

rng(4384)
preferenceShock=-evrnd(-0,1,[n,5]);

%% Results

labourIncome=wage*hoursGrid;

labourChoice=labourOptimization(hoursGrid,labourIncome,nonLabourIncome,preferenceShock,boundaryIncome,...
    ttau,ggamma,ttheta,aalpha);

mean(labourChoice)
std(labourChoice)

%% Non Labour Income for each Hours Grid

% Grid 1
nonLabourIncomeGrid1=zeros(sum(labourChoice==hoursGrid(1)),1);
wagesGrid1=zeros(sum(labourChoice==hoursGrid(1)),1);
j=1;
while j<=length(nonLabourIncomeGrid1)
    for i=1:n
        if labourChoice(i)==hoursGrid(1)
            nonLabourIncomeGrid1(j)=nonLabourIncome(i,1);
            wagesGrid1(j)=wage(i);
            j=j+1;
        end
    end
end

% Grid 2
nonLabourIncomeGrid2=zeros(sum(labourChoice==hoursGrid(2)),1);
wagesGrid2=zeros(sum(labourChoice==hoursGrid(2)),1);
j=1;
while j<=length(nonLabourIncomeGrid2)
    for i=1:n
        if labourChoice(i)==hoursGrid(2)
            nonLabourIncomeGrid2(j)=nonLabourIncome(i,1);
            wagesGrid2(j)=wage(i);
            j=j+1;
        end
    end
end

% Grid 3
nonLabourIncomeGrid3=zeros(sum(labourChoice==hoursGrid(3)),1);
wagesGrid3=zeros(sum(labourChoice==hoursGrid(3)),1);
j=1;
while j<=length(nonLabourIncomeGrid3)
    for i=1:n
        if labourChoice(i)==hoursGrid(3)
            nonLabourIncomeGrid3(j)=nonLabourIncome(i,1);
            wagesGrid3(j)=wage(i);
            j=j+1;
        end
    end
end

% Grid 4
nonLabourIncomeGrid4=zeros(sum(labourChoice==hoursGrid(4)),1);
wagesGrid4=zeros(sum(labourChoice==hoursGrid(4)),1);
j=1;
while j<=length(nonLabourIncomeGrid4)
    for i=1:n
        if labourChoice(i)==hoursGrid(4)
            nonLabourIncomeGrid4(j)=nonLabourIncome(i,1);
            wagesGrid4(j)=wage(i);
            j=j+1;
        end
    end
end

% Grid 5
nonLabourIncomeGrid5=zeros(sum(labourChoice==hoursGrid(5)),1);
wagesGrid5=zeros(sum(labourChoice==hoursGrid(5)),1);
j=1;
while j<=length(nonLabourIncomeGrid5)
    for i=1:n
        if labourChoice(i)==hoursGrid(5)
            nonLabourIncomeGrid5(j)=nonLabourIncome(i,1);
            wagesGrid5(j)=wage(i);
            j=j+1;
        end
    end
end

%% Plots

% Distribution of work hours
histfit(labourChoice,5)
xlabel('Work Hours')
ylabel('Frequency')

% Distribution of non-labour income
histfit(nonLabourIncomeGrid1,10,'kernel')
xlabel('Non Labour Income')
ylabel('Frequency')

histfit(nonLabourIncomeGrid2,10,'kernel')
xlabel('Non Labour Income')
ylabel('Frequency')

histfit(nonLabourIncomeGrid3,10,'kernel')
xlabel('Non Labour Income')
ylabel('Frequency')

histfit(nonLabourIncomeGrid4,10,'kernel')
xlabel('Non Labour Income')
ylabel('Frequency')

histfit(nonLabourIncomeGrid5,10,'kernel')
xlabel('Non Labour Income')
ylabel('Frequency')

% Distribution of wages
histfit(wagesGrid1,10,'kernel')
xlabel('Wage')
ylabel('Frequency')

histfit(wagesGrid2,10,'kernel')
xlabel('Wage')
ylabel('Frequency')

histfit(wagesGrid3,10,'kernel')
xlabel('Wage')
ylabel('Frequency')

histfit(wagesGrid4,15,'kernel')
xlabel('Wage')
ylabel('Frequency')

histfit(wagesGrid5,10,'kernel')
xlabel('Wage')
ylabel('Frequency')
