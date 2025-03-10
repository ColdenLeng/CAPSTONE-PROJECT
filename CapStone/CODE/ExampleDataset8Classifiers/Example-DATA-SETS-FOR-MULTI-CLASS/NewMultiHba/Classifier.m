function Acc = Classifier(feat,label,HO)
%---// Parameter setting for k-value of KNN //
k=5; 

xtrain = feat(HO.training==1,:);  ytrain = label(HO.training==1); 
xvalid = feat(HO.test==1,:);      yvalid = label(HO.test==1); 

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

