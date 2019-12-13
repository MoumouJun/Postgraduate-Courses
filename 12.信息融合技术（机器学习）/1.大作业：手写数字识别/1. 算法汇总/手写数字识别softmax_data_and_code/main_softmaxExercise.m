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
inputSize =inputSize +1;% softmx�����뻹Ҫ����һά��x0=1����Ҳ�Ǧ�j������ά��
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

images = loadMNISTImages('train-images.idx3-ubyte');%�õ���images��һ��784*60000�ľ�����˼��ÿһ����һ
%��28*28��ͼ��չ����һ�У�һ����60000��ͼ��
labels = loadMNISTLabels('train-labels.idx1-ubyte');
labels(labels==0) = 10; % ��Ϊ���������1,2..k����0��ʼ�ģ����������labels�е�0ӳ���10

inputData = images;
inputData = [ones(1,60000); inputData];%ÿ��������Ҫ����һ��x0=1

%%==============================================================================
% For debugging purposes, you may wish to reduce the size of the input data
% in order to speed up gradient checking. 
% Here, we create synthetic dataset using random data for testing

% DEBUG = true; % Set DEBUG to true when debugging.
%debug=0����if����û����
DEBUG = false;
if DEBUG
    inputSize = 9;
    inputData = randn(8, 100);
%     inputData = ones(8, 100);
    inputData = [ones(1,100);inputData];
    labels = randi(10, 100, 1);%��[1,100]���������һ��100*1��������
%     labels =ones(100, 1);
end

% Randomly initialise theta
theta = 0.005 * randn(inputSize*numClasses, 1);
%��inputSize*numClasses��������ʼ��
% theta = 0.005 * ones(numClasses * inputSize, 1);
%%======================================================================
%% STEP 2: Implement softmaxCost
%
%  Implement softmaxCost in softmaxCost.m. 
%�����Ż���������С����ʧ������
[cost, grad] = softmax_regression_vec(theta,inputData ,labels,lambda );
                                     
%%======================================================================
%% STEP 3: Gradient checking
%
%  As with any learning algorithm, you should always check that your
%  gradients are correct before learning the parameters.
% 
% DEBUG = true;
%debug=0����if����û����
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

options.maxIter = 100;%options��һ���ṹ�壻�����������100��
%ͨ����ε���������������֪����
%100-----0.9262
%200-----0.9261
%������ʧ�������ı仯����Ϊ�㣬��������ӵ���������û���ã������Ż���������һ����ʧ�����仯��ֵ����С�����ǲ��ڽ��е���
[softmaxModel,cost_all] = softmaxTrain(inputSize, numClasses, lambda, ...
                            inputData, labels, options);
%���ص�softmaxModelҲ��һ���ṹ��
%     �ڲ��������ӣ�optTheta=785*10�Ż��õ��Ĳ�������ûһ�ж�Ӧһ������785������
%                  inputsize=785������Ŀ
%                  numclasses=10�����Ŀ
%���ص�cost_allΪÿ�ε������Ӧ����ʧ����ֵ
% ʵ���ϣ�������ò��ø��ߵĵ�������
plot(cost_all)
title('����LBFGS�Ż���ʧ�����仯')
xlabel('��������');
ylabel('��ʧ����ֵ');	%���ú�����������
grid on
%%======================================================================
%% STEP 5: Testing
%����ѵ�����ڵ��Ĳ��Ż����ɵ�7850������ֵ���в���
%  To do this, you will first need to write softmaxPredict
%  (in softmaxPredict.m), which should return predictions
%  given a softmax model and the input data.
%  ����10000������������ÿ��������785������ֵ��һ��ʵ��ֵ
images = loadMNISTImages('t10k-images.idx3-ubyte');
labels = loadMNISTLabels('t10k-labels.idx1-ubyte');
labels(labels==0) = 10; % Remap 0 to 10Ϊ�˷��㣬����0���ɵ�10�����

inputData = images;
inputData = [ones(1,size(inputData,2)); inputData];%ÿ��������Ҫ����һ��x0=1

% You will have to implement softmaxPredict in softmaxPredict.m
[pred] = softmaxPredict(softmaxModel, inputData);
%��������1��ѵ���Ż��õ��Ĳ���ֵsoftmaxmodel.opttheta=��785*10��
 %      2��softmaxmodel.inputsize=785
  %     3)softmaxmodel.numclasses=10
   %    4)inputdata�������ݵ��롾785*10000��
%�������
%ÿ�������������������Ĳ�������theta'*data
%ͨ��������������������е����ֵ��ΪԤ�����𣬷���pred��
acc = mean(labels(:) == pred(:));%���˵��������ȷ��ͳ���ж��ٸ�����ͬ�ģ��������ռ�ٷֱ�
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
