images = loadMNISTImages('train-images.idx3-ubyte');%�õ���images��һ��784*60000�ľ�����˼��ÿһ����һ��28*28��ͼ��չ����һ�У�
%һ����60000��ͼ��
labels = loadMNISTLabels('train-labels.idx1-ubyte');
handnumble=1;
num_images=images(:,1:handnumble);
num_images=reshape(num_images,28,28);
display_network(images(:,1:handnumble)); % Show the first 100 images
%  ÿһ����784��Ԫ�أ��ֱ�Ϊ��д��������ع�һ���Ҷ�ֵ
disp(labels(1:handnumble));% command window������ʾ��ǩ
