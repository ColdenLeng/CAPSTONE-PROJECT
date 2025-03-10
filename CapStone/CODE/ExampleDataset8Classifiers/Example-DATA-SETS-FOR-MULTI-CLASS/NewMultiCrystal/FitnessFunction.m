% Notation: This fitness function is for demonstration 

function cost = FitnessFunction(feat,label,X,HO)
if sum(X == 1) == 0
  cost = 1;
else
  cost = jwrapperKNN(feat(:, X == 1),label,HO);
end
end


function error = jwrapperKNN(sFeat,label,HO)
%---// Parameter setting for k-value of KNN //
k = 5; 
xtrain = sFeat(HO.training == 1,:);
ytrain = label(HO.training == 1); 
xvalid = sFeat(HO.test == 1,:); 
yvalid = label(HO.test == 1); 

%8 classification For Multi-Class Data Sets
Model  = fitcknn(xtrain,ytrain,'NumNeighbors',k);%KNN
%Model = fitcnb(xtrain,ytrain,'DistributionNames','kernel')%NavieBayes
%Model  = fitctree(xtrain,ytrain); %Decision Tree
%Model = fitcnet(xtrain,ytrain);% Artificial Neural Networks/Deep Learning
%Model = fitcecoc(xtrain,ytrain);%Support Vector Machine
%Model = fitcensemble(xtrain,ytrain,"Method","AdaBoostM2"); 

%t = templateLinear();%Multi-Linear
%Model = fitcecoc(xtrain,ytrain,'Learners',t);%Multi-Linear


%t = templateLinear('Learner','Logistic');%Multi-Logistic
%Model = fitcecoc(xtrain,ytrain,'Learners',t);%Multi-Logistic

%tr=templateTree('MaxNumSplits',1);%multi-bagging
%fitcensemble(xtrain,ytrain,'Method','Bag','NumLearningCycles',30,'Learners',tr);%Multi-Bagging


pred      = predict(Model,xvalid);
num_valid = length(yvalid); 
correct   = 0;
for i = 1:num_valid
  if isequal(yvalid(i),pred(i))
    correct = correct + 1;
  end
end
Acc   = correct / num_valid; 
error = 1 - Acc;
end

