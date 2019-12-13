function [softmaxModel,cost_all] = softmaxTrain(inputSize, numClasses, lambda, inputData, labels, options)
%softmaxTrain Train a softmax model with the given parameters on the given
% data. Returns softmaxOptTheta, a vector containing the trained parameters
% for the model.
%
% inputSize: the size of an input vector x^(i)
% numClasses: the number of classes 
% lambda: weight decay parameter
% inputData: an N by M matrix containing the input data, such that
%            inputData(:, c) is the cth input
% labels: M by 1 matrix containing the class labels for the
%            corresponding inputs. labels(c) is the class label for
%            the cth input
% options (optional): options
%   options.maxIter: number of iterations to train for

if ~exist('options', 'var')
    options = struct;
end%如果不存在变量options则构建结构体options

if ~isfield(options, 'maxIter')
    options.maxIter = 400;
end%如果结构体options不存在变量maxiter则构建结
%上述两个if在主函数都存在了，所以两个if无效

% initialize parameters
theta = 0.005 * randn(numClasses* inputSize, 1);%同主函数的第一步初始化参数7850个

%%
% Use minFunc to minimize the function
addpath minFunc/%将当前路径加入搜索路径，minFunc/表示当前路径
options.Method = 'lbfgs'; %选择优化损失函数方法 
minFuncOptions.display = 'on';%创建一个新的结构体minFuncOptions（'display',用来控制计算过程的显示，）

[softmaxOptTheta, cost,cost_all] = minFunc( @(theta) softmax_regression_vec(theta,inputData,labels,lambda),theta, options);
%可以不用去了解这个minfunc函数的使用方法，只需要知道怎么用即可；
%该函数的输入：1）优化函数@(theta) softmax_regression_vec(theta,inputData,labels,lambda)-----该函数含有多个参数，需要@指明优化对象为theta
%             2）theta---参数的初始值【7850*1】
 %            3）options---优化的设置：迭代次数100；优化方法lbfgs
%该函数的输出：1）显示显示迭代过程中每一次的变化值
 %            2）softmaxopttheta:迭代结束时对应的7850个参数值【7850*1】
 %            3）cost:迭代结束时对应的最小损失函数值【1*1】
%%通过L-BFGS得到最佳的cost与gradient 
%minFunc----------为一个给定的数据包，里面有各种优化算法
% softmax_regression_vec(theta,inputData,labels,lambda)------完全相同于第二步的函数
%%
% Fold softmaxOptTheta into a nicer format
softmaxModel.optTheta = reshape(softmaxOptTheta,inputSize, numClasses );
softmaxModel.inputSize = inputSize;
softmaxModel.numClasses = numClasses;
                          
end                          
