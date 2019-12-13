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
end%��������ڱ���options�򹹽��ṹ��options

if ~isfield(options, 'maxIter')
    options.maxIter = 400;
end%����ṹ��options�����ڱ���maxiter�򹹽���
%��������if���������������ˣ���������if��Ч

% initialize parameters
theta = 0.005 * randn(numClasses* inputSize, 1);%ͬ�������ĵ�һ����ʼ������7850��

%%
% Use minFunc to minimize the function
addpath minFunc/%����ǰ·����������·����minFunc/��ʾ��ǰ·��
options.Method = 'lbfgs'; %ѡ���Ż���ʧ�������� 
minFuncOptions.display = 'on';%����һ���µĽṹ��minFuncOptions��'display',�������Ƽ�����̵���ʾ����

[softmaxOptTheta, cost,cost_all] = minFunc( @(theta) softmax_regression_vec(theta,inputData,labels,lambda),theta, options);
%���Բ���ȥ�˽����minfunc������ʹ�÷�����ֻ��Ҫ֪����ô�ü��ɣ�
%�ú��������룺1���Ż�����@(theta) softmax_regression_vec(theta,inputData,labels,lambda)-----�ú������ж����������Ҫ@ָ���Ż�����Ϊtheta
%             2��theta---�����ĳ�ʼֵ��7850*1��
 %            3��options---�Ż������ã���������100���Ż�����lbfgs
%�ú����������1����ʾ��ʾ����������ÿһ�εı仯ֵ
 %            2��softmaxopttheta:��������ʱ��Ӧ��7850������ֵ��7850*1��
 %            3��cost:��������ʱ��Ӧ����С��ʧ����ֵ��1*1��
%%ͨ��L-BFGS�õ���ѵ�cost��gradient 
%minFunc----------Ϊһ�����������ݰ��������и����Ż��㷨
% softmax_regression_vec(theta,inputData,labels,lambda)------��ȫ��ͬ�ڵڶ����ĺ���
%%
% Fold softmaxOptTheta into a nicer format
softmaxModel.optTheta = reshape(softmaxOptTheta,inputSize, numClasses );
softmaxModel.inputSize = inputSize;
softmaxModel.numClasses = numClasses;
                          
end                          
