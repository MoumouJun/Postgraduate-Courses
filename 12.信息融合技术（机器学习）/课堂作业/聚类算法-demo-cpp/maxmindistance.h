#include <iostream>    
#include <math.h>    
using namespace std;  
/*��ѧ���nά�ռ䣬ŷʽ�ռ䣬ŷʽ���룬
*ģʽʶ�𣺾��ࡪ�������С�����㷨����
*/  
const int N=6;//����N������  
const int M=5;  //����ά��

/*
�����С�����㷨��
���ȸ���ȷ���ľ�����ֵѰ�Ҿ������ģ�Ȼ���������ڹ����ģʽ�������ֵ����������Ķ�Ӧ������� 
������������㷨��������ʵ������
�������ʣ�
*/
int maxmindistance(float sample[M][N],float theta)  
{   
    int center[N];//�����������,�������ġ�������     
    float D[20][N];//������֮��ľ������D����    
    float min[N];    
    int minindex[N];   //����������������һ������   
    int clas[N];   
    float theshold; //������ֵ��ʵ�ʴ��ڴ�ֵ������о�����ѣ�
    float D12=0.0;//��һ������͵ڶ��������еľ���,��������������Զ������������ŷ�Ͼ��룩
    float tmp=0;  //ŷʽ���뻺��ֵ  
    int index=0;  //�������ģ�Ϊ��һ������������ֵ  
    center[0]=0;//��ԭ��Ϊ��һ���������ģ�Ȼ��Ѱ���µľ��ࣨ���ϣ�����    
    int i,k=0,j,l;   
	//����������������������һ���������������ģ��ľ��룬���о������ֵ������	
    for(j=0;j<N;j++)   
    {   
		for(i=0;i<M;i++)
			tmp+=(sample[i][j]-sample[i][0])*(sample[i][j]-sample[i][0]);    
        D[0][j]=(float)sqrt(tmp); //ѭ��������һ�д����Ϊÿ���������һ����������һ�������ģ��ľ���   
		tmp=0;
        if(D[0][j]>D12)  //�ҳ�������
        {  
            D12=D[0][j]; 
            index=j;  
        }    
    }    
    center[1]=index;//�ڶ����������ģ���ȷ���ڶ�������Ϊ��һ��������    
    k=1;   //����������-1
    index=0;    
    theshold=D12;    
	//������������������ֵ�����趨ֵ������ھ������ģ�
	//�����о����С����ֵ�����������������������һ���������ģ�
    while(theshold>theta*D12)  //theta*D12��ÿ������ķ�Χ��theta���ⲿ�������루0~1��
    {    
        for(j=0;j<N;j++)  //����������һ���������ģ����ν���ʱΪ��Z2���ľ���
        {    
			for(i=0;i<M;i++)
				tmp+=(sample[i][j]-sample[i][center[k]])*(sample[i][j]-sample[i][center[k]]);    
            D[k][j]=(float)sqrt(tmp); 	//����ֵ�����浽 D[][]��
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
            min[j]=tmp;           //����Ƚ�ѡ����С�ı���  
            minindex[j]=index;    //���������ǵ��±�  
        }//min-operate    
        float max=0;index=0;    
        for(j=0;j<N;j++)    //��ѯ������
            if(min[j]>max)   
            {  
                max=min[j];      //���������룬ֱ��ʵ�����ֵ 
                index=j;         //
            }    
        if (max>theta*D12)  //�µľ������� 
        {  
            k++;  		//�������ĵ����ݼ�һ
            center[k]=index;  //�ֱ�ȷ���������͵��������Ͼ�������Ϊ��һ������	
        }// add a center    
        theshold=max;// prepare to loop next time    
    }  //�����������,final array min[] is still useful 
	    for(j=0;j<N;j++)    
        clas[j]=minindex[j];  //   
	
    //for(i=0;i<M;i++)  //��ӡ����ֵ
    //{  
    //    for(j=0;j<N;j++)    
    //        cout<<sample[i][j]<<"  ";    
    //    cout<<"\n";    
    //}    
 
    cout<<"����������Ŀ��"<<k+1<<" \n";    
    cout<<"�������Ķ�Ӧ��������:";    
    for(l=0;l<k;l++)   
        cout<<center[l]+1<<"--";  //���δ�ӡ�����ľ���Ϊ��һ������
    cout<<center[k]+1;    
    cout<<"\n";    
    for(j=0;j<N;j++)    // ����6��������ֵ�����ľ�������
        cout<<clas[j]+1<<"  "; //ÿһ��������Ӧһ���������ģ���ÿ���������İ����ļ�������
    cout<<"\n";    
    return k;  
}   