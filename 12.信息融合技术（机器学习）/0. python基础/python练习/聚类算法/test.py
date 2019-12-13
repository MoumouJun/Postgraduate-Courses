# -*- coding: utf-8 -*-
"""
Notepad++:视图 –> 显示符号 –> 显示空格与制表符,该缩进的都缩进了。
"""
'''
聚类算法通常会得到一种分类（K-MEANS、 K-medoids、 最大最小距离算法…），将n个点聚合成k类，
同一聚类（即插槽簇）中的对象相似度较高；而不同类中的对象相似度较小。
信息融合技术课程作业：
谱系聚类法((Spectral Clustering))，给出六个样本特征矢量如下，按照最小距离原则进行聚类----
x1(0,3,1,2,0)',x2(1,3,0,1,0)',x3(3,3,0,0,1)',
x4(1,1,0,2,0)',x5(3,2,1,2,1)',x6(4,1,1,1,0)'.
x[6]={[],[],[],[],[],[]};

1.确定第一个聚合中心Z1，一般取第一个样本x1或者空间原点0;
2.计算其他所有样本到Z1的欧式距离（多维情况），最大距离样本作为第二个聚类中心;
3.根据确定其他的聚合中心；
4.最近邻原则把所有样本归属最近的聚合中心

'''
'''
python基础：矩阵，列表，数组
嵌套循环：while，for
'''
from numpy import *
import numpy as np    

M=5#样本维数
N=6#样本个数

theta=0.5
min= np.empty((N))
minindex= np.empty((N))
clas= np.empty((N))

a = np.array([[0,3,1,2,0],[1,3,0,1,0], [3,3,0,0,1],[1,1,0,2,0],
             [3,2,1,2,1],[4,1,1,1,0]],dtype=int)  # 创建5*6维数组 
a=np.mat(a)  #由二维数组创建矩阵
a=a.T   #矩阵转置
print (a[0])
print (a[:,0])
print (a[2,3])

#CenterTemp=0
D12=0.0 #第一个聚类和第二个聚类中的距离,即所有样本中最远的两个样本（欧氏距离）
DisTemp= np.empty((N,20))
#print (DisTemp(0,1))

i=0
while(i <N ):
	DistSample=sqrt(sum(square(a[:,i] - a[:,0]))) #numpy库函数，求解向量之间的欧氏距离
	DisTemp[0,i]=DistSample
	if DisTemp[0,i] > D12 :
		D12=DisTemp[0,i]
		CenterTemp=i
	i=i+1
print (D12)#测试第二个聚类中心距离与第一个的距离（样本最远距离）
print (CenterTemp)
print (DisTemp[0,5])
print (DisTemp[1,5])
center= np.empty(N)
center[0]=0
center[1]=CenterTemp #第二个聚类中心（即确定第二个聚类为哪一个样本）
print(center[0])
k=1      #缓存聚类中心的数目
CenterTemp=0

DisTheshold=D12
#center[k]]


while DisTheshold>(theta*D12):
	for j in range (0 ,N):
		DistSample=sqrt(sum(square(a[:,j]-a[:,0]))) #numpy库函数，求解向量之间的欧氏距离
		DisTemp[k,j]=DistSample
	for j in range (0 ,N):
		DistSample=D12
		for l in range (0,k):
			if DisTemp[l][j]<DistSample:
				DistSample=DisTemp[l][j]
				CenterTemp=j
		min[j]=DistSample
		minindex[j]=CenterTemp
	CenterTemp=0
	max=0
	for j in range (0,N):
		if min[j]>max:
			max=min[j]
			CenterTemp=j
	if max>theta*D12:
		k=k+1
    #    center[k]=CenterTemp
	DisTheshold=max
    
for j in range (0,N):
	clas[j]=minindex[j]
	print (clas[j])


