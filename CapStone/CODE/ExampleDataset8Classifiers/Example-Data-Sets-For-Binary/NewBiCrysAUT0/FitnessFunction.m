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

%Example Dataset For Binary 8 Classifications work(FitnessFunctions) with KNN files
Model = fitcknn(xtrain,ytrain,'NumNeighbors',k); %KNN-1
%Model = fitcnb(xtrain,ytrain,'DistributionNames','kernel');%Navie Bayes-2
%Model = fitcensemble(xtrain,ytrain,'Method','AdaBoostM1');%Adaboost-3
%Model = fitctree(xtrain,ytrain);%Decision Tree-4
%Model = fitclinear(xtrain,ytrain);%Linear Classifier-5
%Model = fitcnet(xtrain,ytrain);%Artificial Neural Networks/Deep Learning-6
%Model = fitcsvm(xtrain,ytrain);%Support Vector Machine-7
%Model = fitclinear(xtrain,ytrain,'Learner','Logistic');%Logistic Regression-8

%tr=templateTree('MaxNumSplits',1);%bagging
%Model = fitcensemble(xtrain,ytrain,'Method','Bag','NumLearningCycles',30,'Learners',tr);%bagging



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

