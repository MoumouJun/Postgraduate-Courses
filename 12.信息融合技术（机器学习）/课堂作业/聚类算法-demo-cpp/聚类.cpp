#include"maxmindistance.h"  
int _tmain(int argc, _TCHAR* argv[])
{
	float s[M][N];
	int i,j;
	for(i=0;i<N;i++)
	{
		cout<<"请输入第"<<(i+1)<<"个样本:";
		for(j=0;j<M;j++)
			cin>>s[j][i];
	}
    for(i=0;i<M;i++)  //打印样本值
    {  
        for(j=0;j<N;j++)    
            cout<<s[i][j]<<"  ";    
        cout<<"\n";    
    }  
	while(1){
		
		float theta; 
		cout<<"请输入最大距离系数：";
		cin>>theta;  
		maxmindistance(s,theta); 
	}
	return 0;
}

