#include"maxmindistance.h"  
int _tmain(int argc, _TCHAR* argv[])
{
	float s[M][N];
	int i,j;
	for(i=0;i<N;i++)
	{
		cout<<"�������"<<(i+1)<<"������:";
		for(j=0;j<M;j++)
			cin>>s[j][i];
	}
    for(i=0;i<M;i++)  //��ӡ����ֵ
    {  
        for(j=0;j<N;j++)    
            cout<<s[i][j]<<"  ";    
        cout<<"\n";    
    }  
	while(1){
		
		float theta; 
		cout<<"������������ϵ����";
		cin>>theta;  
		maxmindistance(s,theta); 
	}
	return 0;
}

