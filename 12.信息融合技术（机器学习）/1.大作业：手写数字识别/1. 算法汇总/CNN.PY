# -*- coding: utf-8 -*-
"""
Created on Fri May 18 00:33:37 2018

@author: Liu Jun
"""

import tensorflow as tf
import tensorflow.examples.tutorials.mnist.input_data as input_data #导入mnist数据集
mnist = input_data.read_data_sets("MNIST_data",one_hot=True)
#存储变量的容器——输入，输出，权重，偏置，softmax输出，
x = tf.placeholder(tf.float32, [None,784])
y_ = tf.placeholder(tf.float32,[None,10])
W = tf.Variable(tf.zeros([784,10]))
b = tf.Variable(tf.zeros([10]))
y = tf.nn.softmax(tf.matmul(x, W)+b)
i=0
#使用交叉熵定义损失函数
cross_entropy = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(labels=y_, logits=tf.log(y)))
train_step = tf.train.GradientDescentOptimizer(0.5).minimize(cross_entropy)
init = tf.global_variables_initializer()
sess = tf.InteractiveSession()
sess.run(init)
for i in range(1000):
    batch_x,batch_y = mnist.train.next_batch(100)
    sess.run(train_step,feed_dict={x:batch_x,y_:batch_y})
    i=i+1;
    print('训练中'+str(i))
correct_prediction = tf.equal(tf.arg_max(y, 1),tf.arg_max(y_,1))
accuracy = tf.reduce_mean(tf.cast(correct_prediction,"float"))
print(sess.run(accuracy,feed_dict = {x:mnist.test.images,y_:mnist.test.labels}))
sess.close()

#参数设置
learning_rate = 0.001
training_iters = 60000  #当训练数量达到6W结束
batch_size = 128  #经验值
display_step = 10

n_input = 784   #(image shape = [28,28])
n_classes = 10  #输出类别0~9
dropout = 0.8  # 

#tf Graph input
x = tf.placeholder(tf.float32,[None,n_input])
y = tf.placeholder(tf.float32,[None,n_classes])
keep_prob = tf.placeholder(tf.float32)#drop(keep probability)

#Create model
def conv2d(image,w,b):
    return tf.nn.relu(tf.nn.bias_add(tf.nn.conv2d(image,w,strides=[1,1,1,1],padding='SAME'),b))
def max_pooling(image,k):
    return tf.nn.max_pool(image, ksize=[1,k,k,1], strides=[1,k,k,1], padding='SAME')

weights = {
    'wc1':tf.Variable(tf.random_normal([5,5,1,32])),
    'wc2':tf.Variable(tf.random_normal([5,5,32,64])),
    'wd1':tf.Variable(tf.random_normal([7*7*64,1024])),
    'out':tf.Variable(tf.random_normal([1024,n_classes]))
}
biases = {
    'bc1':tf.Variable(tf.random_normal([32])),
    'bc2':tf.Variable(tf.random_normal([64])),
    'bd1':tf.Variable(tf.random_normal([1024])),
    'out':tf.Variable(tf.random_normal([n_classes]))
}
def conv_net(_X,_weights,_biases,_dropout):

    _X = tf.reshape(_X,[-1,28,28,1])
    conv1 = conv2d(_X,_weights['wc1'],_biases['bc1'])
    conv1 = max_pooling(conv1, k = 2)
    conv1 = tf.nn.dropout(conv1, keep_prob=_dropout)

    conv2 = conv2d(conv1,_weights['wc2'],_biases['bc2'])
    conv2 = max_pooling(conv2, k=2)
    conv2 = tf.nn.dropout(conv2,keep_prob=_dropout)

    dense1 = tf.reshape(conv2,[-1,_weights['wd1'].get_shape().as_list()[0]])
    dense1 = tf.nn.relu(tf.add(tf.matmul(dense1,_weights['wd1']),_biases['bd1']))
    dense1 = tf.nn.dropout(dense1,_dropout)
    out = tf.add(tf.matmul(dense1,_weights['out']),_biases['out'])
    print(out)
    return out

pred = conv_net(x, weights, biases, keep_prob)
cost = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(labels=y, logits=pred))
optimizer = tf.train.AdamOptimizer(learning_rate=learning_rate).minimize(cost)

#
correct_pred = tf.equal(tf.argmax(pred,1),tf.argmax(y,1))
accuracy = tf.reduce_mean(tf.cast(correct_pred,tf.float32))
init = tf.initialize_all_variables()

with tf.Session() as sess:
    sess.run(init)
    step = 1
    while step * batch_size<training_iters:
        batch_xs,batch_ys = mnist.train.next_batch(batch_size)
        sess.run(optimizer,feed_dict = {x:batch_xs,y:batch_ys,keep_prob:dropout})
        if step %display_step==0:
            acc = sess.run(accuracy,feed_dict={x:batch_xs,y:batch_ys,keep_prob:1.})
            loss = sess.run(cost, feed_dict={x: batch_xs, y: batch_ys, keep_prob: 1.})
            print("迭代次数(STEP) " + str(step)+',数据量(Batch_Size)'+str(batch_size) + ", Minibatch Loss= " + "{:.6f}".format(loss) + ", 正确率= " + "{:.5f}".format(acc))

        step += 1
    print("优化完成!")
    print("正确率:",sess.run(accuracy,feed_dict={x: mnist.test.images[:256], y: mnist.test.labels[:256], keep_prob: 1.}))