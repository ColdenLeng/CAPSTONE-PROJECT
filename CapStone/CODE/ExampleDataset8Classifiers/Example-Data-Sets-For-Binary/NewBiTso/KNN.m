function Acc = KNN(feat,label,HO)
%---// Parameter setting for k-value of KNN //
k=5; 

xtrain = feat(HO.training==1,:);  ytrain = label(HO.training==1); 
xvalid = feat(HO.test==1,:);      yvalid = label(HO.test==1); 



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


ypred  = predict(Model,xvalid);

num_valid = length(yvalid);
correct   = 0;
for i = 1:num_valid
  if isequal(yvalid(i),ypred(i))
    correct = correct + 1;
  end
end
Acc = 100 * (correct / num_valid); 
end

