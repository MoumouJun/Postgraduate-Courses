import tensorflow as tf
import tensorflow.examples.tutorials.mnist.input_data as input_data 
mnist = input_data.read_data_sets("MNIST_data",one_hot=True)	 #导入训练的MNIST数据集
x = tf.placeholder(tf.float32, [None,784])	#28*28=784
y_ = tf.placeholder(tf.float32,[None,10])   #0~9,共十个类别
W = tf.Variable(tf.zeros([784,10]))	
b = tf.Variable(tf.zeros([10]))
y = tf.nn.softmax(tf.matmul(x, W)+b)  #矩阵乘法 输入*权重+偏置

cross_entropy = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(labels=y_, logits=tf.log(y)))
train_step = tf.train.GradientDescentOptimizer(0.5).minimize(cross_entropy)
init = tf.global_variables_initializer()
sess = tf.InteractiveSession()
sess.run(init)
for i in range(2000):
    batch_x,batch_y = mnist.train.next_batch(128)
    sess.run(train_step,feed_dict={x:batch_x,y_:batch_y})
correct_prediction = tf.equal(tf.arg_max(y, 1),tf.arg_max(y_,1))
accuracy = tf.reduce_mean(tf.cast(correct_prediction,"float"))
print(sess.run(accuracy,feed_dict = {x:mnist.test.images,y_:mnist.test.labels}))  #打印正确率
sess.close()