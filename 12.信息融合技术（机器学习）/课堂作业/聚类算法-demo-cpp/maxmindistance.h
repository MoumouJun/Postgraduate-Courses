#include <iostream>    
#include <math.h>    
using namespace std;  
/*数学概念：n维空间，欧式空间，欧式距离，
*模式识别：聚类——最大最小距离算法（）
*/  
const int N=6;//给定N个样本  
const int M=5;  //样本维数

/*
最大最小距离算法：
首先根据确定的距离阈值寻找聚类中心，然后根据最近邻规则把模式样本划分到各聚类中心对应的类别中 
问题提出——算法描述——实例解析
个人疑问：
*/
int maxmindistance(float sample[M][N],float theta)  
{   
    int center[N];//保存聚类中心,聚类中心≤样本数     
    float D[20][N];//样本点之间的距离存入D数组    
    float min[N];    
    int minindex[N];   //非中心样本属于哪一个聚类   
    int clas[N];   
    float theshold; //距离阈值（实际大于此值，则进行聚类分裂）
    float D12=0.0;//第一个聚类和第二个聚类中的距离,即所有样本中最远的两个样本（欧氏距离）
    float tmp=0;  //欧式距离缓存值  
    int index=0;  //聚类中心（为哪一个样本）缓存值  
    center[0]=0;//以原点为第一个聚类中心，然后寻找新的聚类（集合）中心    
    int i,k=0,j,l;   
	//遍历求得其他所有样本与第一个样本（聚类中心）的距离，其中距离最大值的样本	
    for(j=0;j<N;j++)   
    {   
		for(i=0;i<M;i++)
			tmp+=(sample[i][j]-sample[i][0])*(sample[i][j]-sample[i][0]);    
        D[0][j]=(float)sqrt(tmp); //循环结束第一行存入的为每个样本与第一个样本（第一聚类中心）的距离   
		tmp=0;
        if(D[0][j]>D12)  //找出最大距离
        {  
            D12=D[0][j]; 
            index=j;  
        }    
    }    
    center[1]=index;//第二个聚类中心（即确定第二个聚类为哪一个样本）    
    k=1;   //聚类中心数-1
    index=0;    
    theshold=D12;    
	//当存在两样本距离阈值大于设定值，则存在聚类中心；
	//当所有距离均小于阈值，则非中心样本必属于其中一个聚类中心；
    while(theshold>theta*D12)  //theta*D12即每个聚类的范围，theta由外部参数传入（0~1）
    {    
        for(j=0;j<N;j++)  //各样本到上一个聚类中心（初次进入时为到Z2）的距离
        {    
			for(i=0;i<M;i++)
				tmp+=(sample[i][j]-sample[i][center[k]])*(sample[i][j]-sample[i][center[k]]);    
            D[k][j]=(float)sqrt(tmp); 	//距离值继续存到 D[][]中
			tmp=0;
        }    
        for(j=0;j<N;j++)  //
        {    
            float tmp=D12;     
            for(l=0;l<=k;l++)    
                if (D[l][j]<tmp)   
                {  
                    tmp=D[l][j];  
                    index=l;  
                }    
            min[j]=tmp;           //横向比较选出最小的保存  
            minindex[j]=index;    //并存入它们的下标  
        }//min-operate    
        float max=0;index=0;    
        for(j=0;j<N;j++)    //轮询最大距离
            if(min[j]>max)   
            {  
                max=min[j];      //更新最大距离，直至实际最大值 
                index=j;         //
            }    
        if (max>theta*D12)  //新的聚类中心 
        {  
            k++;  		//聚类中心的数据加一
            center[k]=index;  //分别确定第三个和第三个以上聚类中心为哪一个样本	
        }// add a center    
        theshold=max;// prepare to loop next time    
    }  //求出所有中心,final array min[] is still useful 
	    for(j=0;j<N;j++)    
        clas[j]=minindex[j];  //   
	
    //for(i=0;i<M;i++)  //打印样本值
    //{  
    //    for(j=0;j<N;j++)    
    //        cout<<sample[i][j]<<"  ";    
    //    cout<<"\n";    
    //}    
 
    cout<<"聚类中心数目："<<k+1<<" \n";    
    cout<<"聚类中心对应的样本号:";    
    for(l=0;l<k;l++)   
        cout<<center[l]+1<<"--";  //依次打印各中心聚类为哪一个样本
    cout<<center[k]+1;    
    cout<<"\n";    
    for(j=0;j<N;j++)    // 表征6个样本其值所属的聚类中心
        cout<<clas[j]+1<<"  "; //每一个样本对应一个聚类中心，即每个聚类中心包含哪几个样本
    cout<<"\n";    
    return k;  
}   