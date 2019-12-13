clear all
close all
clc
%% CS294A/CS294W Softmax Exercise 

%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the
%  softmax exercise. You will need to write the softmax cost function 
%  in softmaxCost.m and the softmax prediction function in softmaxPred.m. 
%  For this exercise, you will not need to change any code in this file,
%  or any other files other than those mentioned above.
%  (However, you may be required to do so in later exercises)

%%======================================================================
%% STEP 0: Initialise constants and parameters
%
%  Here we define and initialise some constants which allow your code
%  to be used more generally on any arbitrary input. 
%  We also initialise some parameters used for tuning the model.

inputSize = 28 * 28; % Size of input vector (MNIST images are 28x28)
inputSize =inputSize +1;% softmx的输入还要加上一维（x0=1），也是θj向量的维度
numClasses = 10;     % Number of classes (MNIST images fall into 10 classes)

lambda = 1e-4; % Weight decay parameter

%%======================================================================
%% STEP 1: Load data
%
%  In this section, we load the input and output data.
%  For softmax regression on MNIST pixels, 
%  the input data is the images, and 
%  the output data is the labels.
%

% Change the filenames if you've saved the files under different names
% On some platforms, the files might be saved as 
% train-images.idx3-ubyte / train-labels.idx1-ubyte

images = loadMNISTImages('train-images.idx3-ubyte');%得到的images是一个784*60000的矩阵，意思是每一列是一
%幅28*28的图像展成了一列，一共有60000幅图像。
labels = loadMNISTLabels('train-labels.idx1-ubyte');
labels(labels==0) = 10; % 因为这里类别是1,2..k，从0开始的，所以这里把labels中的0映射成10

inputData = images;
inputData = [ones(1,60000); inputData];%每个样本都要增加一个x0=1

%%==============================================================================
% For debugging purposes, you may wish to reduce the size of the input data
% in order to speed up gradient checking. 
% Here, we create synthetic dataset using random data for testing

% DEBUG = true; % Set DEBUG to true when debugging.
%debug=0下面if程序没有用
DEBUG = false;
if DEBUG
    inputSize = 9;
    inputData = randn(8, 100);
%     inputData = ones(8, 100);
    inputData = [ones(1,100);inputData];
    labels = randi(10, 100, 1);%从[1,100]中随机生成一个100*1的列向量
%     labels =ones(100, 1);
end

% Randomly initialise theta
theta = 0.005 * randn(inputSize*numClasses, 1);
%把inputSize*numClasses个参数初始化
% theta = 0.005 * ones(numClasses * inputSize, 1);
%%======================================================================
%% STEP 2: Implement softmaxCost
%
%  Implement softmaxCost in softmaxCost.m. 
%建立优化函数（最小化损失函数）
[cost, grad] = softmax_regression_vec(theta,inputData ,labels,lambda );
                                     
%%======================================================================
%% STEP 3: Gradient checking
%
%  As with any learning algorithm, you should always check that your
%  gradients are correct before learning the parameters.
% 
% DEBUG = true;
%debug=0下面if程序没有用
if DEBUG
 numGrad = computeNumericalGradient( @(theta) softmax_regression_vec(theta,inputData ,labels,lambda) ,theta);

    % Use this to visually compare the gradients side by side
    disp([numGrad grad]); 

    % Compare numerically computed gradients with those computed analytically
    diff = norm(numGrad-grad)/norm(numGrad+grad);
    disp(diff); 
    % The difference should be small. 
    % In our implementation, these values are usually less than 1e-7.

    % When your gradients are correct, congratulations!
end

%%======================================================================
%% STEP 4: Learning parameters
%
%  Once you have verified that your gradients are correct, 
%  you can start training your softmax regression code using softmaxTrain
%  (which uses minFunc).

options.maxIter = 100;%options是一个结构体；下面的最大迭代100次
%通过多次调整迭代次数可以知道：
%100-----0.9262
%200-----0.9261
%由于损失函数最后的变化基本为零，不变后增加迭代次数都没有用，所以优化中设置了一个损失函数变化阀值，当小于它是不在进行迭代
[softmaxModel,cost_all] = softmaxTrain(inputSize, numClasses, lambda, ...
                            inputData, labels, options);
%返回的softmaxModel也是一个结构体
%     内部有三个子：optTheta=785*10优化得到的参数矩阵，没一列对应一个类别的785个参数
%                  inputsize=785特征数目
%                  numclasses=10类别数目
%返回的cost_all为每次迭代后对应的损失函数值
% 实际上，我们最好采用更高的迭代次数
plot(cost_all)
title('采用LBFGS优化损失函数变化')
xlabel('迭代次数');
ylabel('损失函数值');	%设置横坐标纵坐标
grid on
%%======================================================================
%% STEP 5: Testing
%利用训练集在第四步优化生成的7850个参数值进行测试
%  To do this, you will first need to write softmaxPredict
%  (in softmaxPredict.m), which should return predictions
%  given a softmax model and the input data.
%  载入10000个测试样本，每个样本有785个特征值和一个实际值
images = loadMNISTImages('t10k-images.idx3-ubyte');
labels = loadMNISTLabels('t10k-labels.idx1-ubyte');
labels(labels==0) = 10; % Remap 0 to 10为了方便，数字0当成第10个类别

inputData = images;
inputData = [ones(1,size(inputData,2)); inputData];%每个样本都要增加一个x0=1

% You will have to implement softmaxPredict in softmaxPredict.m
[pred] = softmaxPredict(softmaxModel, inputData);
%输入量：1）训练优化得到的参数值softmaxmodel.opttheta=【785*10】
 %      2）softmaxmodel.inputsize=785
  %     3)softmaxmodel.numclasses=10
   %    4)inputdata测试数据导入【785*10000】
%输出量：
%每个样本都进行所有类别的参数运算theta'*data
%通过查找样本在所有类别中的最大值作为预测的类别，放在pred里
acc = mean(labels(:) == pred(:));%相等说明分类正确，统计有多少个是相同的，并求出所占百分比
fprintf('Accuracy: %0.3f%%\n', acc * 100);

% Accuracy is the proportion of correctly classified images
% After 100 iterations, the results for our implementation were:
%
% Accuracy: 92.200%
%
% If your values are too low (accuracy less than 0.91), you should check 
% your code for errors, and make sure you are training on the 
% entire data set of 60000 28x28 training images 
% (unless you modified the loading code, this should be the case)
