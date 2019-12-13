images = loadMNISTImages('train-images.idx3-ubyte');%得到的images是一个784*60000的矩阵，意思是每一列是一幅28*28的图像展成了一列，
%一共有60000幅图像。
labels = loadMNISTLabels('train-labels.idx1-ubyte');
handnumble=1;
num_images=images(:,1:handnumble);
num_images=reshape(num_images,28,28);
display_network(images(:,1:handnumble)); % Show the first 100 images
%  每一列有784个元素，分别为手写字体的像素归一化灰度值
disp(labels(1:handnumble));% command window窗口显示标签
