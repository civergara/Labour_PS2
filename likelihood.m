Labour_PS2
==========
function l=likelihood(unknownParameters,knownParameters,data,decisionVariable,N)

%data is an n by 3 matrix, that has the following information (in order):
% (1) nonLabourIncome; (2) wage; (3) labour choice

% known parameters are the ones related with the tax system (in order):
% (1) tax rate; (2) boundary income

% unknown parameters is an 1 by 5 matrix that has the following information (in
% order): (1)theta; (2) mu; (3) sigma ; (4) alpha ; (5) gamma

 [x w] =hermquad(N);
 n=length(data);
 grids=length(decisionVariable);
 
 %Part A is the likelihood when observed hours is equal to zero
 
 incomeLabourA=exp(unknownParameters(2)+ unknownParameters(3)*sqrt(2)*x)*decisionVariable;
 taxesA=zeros(N,grids);
 for i=1:N
     for j=1:grids
         if incomeLabourA(i,j)>knownParameters(2)
             taxesA(i,j)=knownParameters(1)*incomeLabourA(i,j);
         end
     end
 end
 
 leisure=zeros(n,N,grids);
 for j=1:grids
     leisure(:,:,j)=decisionVariable(j);
 end
 
 utility=zeros(n,N,grids);
 for i=1:N
     for j=1:grids
         utility(:,i,j)=exp(unknownParameters(5)*((data(:,1)+ones(n,1)*(incomeLabourA(i,j)-...
             taxesA(i,j))).^unknownParameters(1)./...
             unknownParameters(1)-unknownParameters(4)*leisure(:,i,j)));
     end
 end

A=log((exp(unknownParameters(5)*(data(:,1).^unknownParameters(1))/unknownParameters(1))/sqrt(pi))...
    .*sum(ones(n,1)*w'./ sum(utility,3),2));

for i=1:n
    if data(i,3)>0
        A(i)=0;
    end
end

% part B is when hours are positive and wages are observed

incomeLabourB=data(:,2).*ones(n,1)*decisionVariable;

taxesB=zeros(n,grids);
for i=1:n
    for j=1:grids
        if incomeLabourB(i,j)>knownParameters(2)
        taxesB(i,j)=knownParameters(1)*incomeLabourB(i,j);
        end
    end
end

taxesC=zeros(n,1);
for i=1:n
    if data(i,2)*data(i,3)>knownParameters(2)
        taxesC(i)=knownParameters(1)*data(i,2)*data(i,3);
    end
end

numerator=exp(unknownParameters(5)*((data(:,1)+data(:,2).*data(:,3)-taxesC).^unknownParameters(1)...
    ./unknownParameters(1)-unknownParameters(4)*data(:,3)));
denominator= sum(exp(unknownParameters(5)*((data(:,1)*ones(1,grids)+incomeLabourB-taxesB).^unknownParameters(1)...
    ./unknownParameters(1)-unknownParameters(4)*ones(n,1)*decisionVariable)),2);
densityFunction=exp(-((log(data(:,2))-unknownParameters(2)).^2/(2*unknownParameters(3)^2)))./...
    (data(:,2)*sqrt(2*pi)*unknownParameters(3));

B=log(numerator./denominator.*densityFunction);

for i=1:n
    if data(i,3)==0
        B(i)=0;
    end
end

l=sum(A)+sum(B);

end

