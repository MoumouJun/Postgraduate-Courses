%%%%%%%%%%%%%%%%%  
%函数名称 MaxMinDisFun(x,Theta)  
%输入参数：  
%           x  : x为n*m的特征样本矩阵，每行为一个样本，每列为样本的特征  
%         Theta：即θ，可用试探法取一固定分数，如：1/2  
%输出参数：  
%       pattern：输出聚类分析后的样本类别  
%函数功能 ：利用最大最小距离算法聚类样本数据，  
%%%%%%%%%%%%%%%%%%%%%  
function [pattern]=MaxMinDisFun(x,Theta)  
maxDistance=0;  
index=1;%相当于指针指示新中心点的位置  
k=1;      %中心点计数，也即是类别  
center=zeros(size(x));    %保存中心点  
patternNum=size(x,1);  %输入的数据数（样本数）  
%distance=zeros(patternNum,3);%distance每列表示所有样本到每个聚类中心的距离  
minDistance=zeros(patternNum,1);%取较小距离  
pattern=(patternNum);%表示类别  
  
center(1,:)=x(1,:);%第一个聚类中心  
pattern(1)=1;  
  
for i=2:patternNum  
    distance(i,1)=sqrt((x(i,:)-center(1,:))*(x(i,:)-center(1,:))');%欧氏距离，与第1个聚类中心的距离  
    minDistance(i,1)=distance(i,1);  
    pattern(i)=1;%第一类  
    if(maxDistance<distance(i,1))  
        maxDistance=distance(i,1);%与第一个聚类中心的最大距离  
        index=i;%与第一个聚类中心距离最大的样本  
    end  
end  
  
k=k+1;  
center(k,:)=x(index,:);%把与第一个聚类中心距离最大的样本作为第二 个聚类中心  
pattern(index)=2;%第二类  
minDistance(index,1)=0;  
  
while 1  
    for i=2:patternNum   
        if(minDistance(i,1)~=0)  
            distance(i,k)=sqrt((x(i,:)-center(k,:))*(x(i,:)-center(k,:))');%与第k个聚类中心的距离  
           if(minDistance(i,1)>distance(i,k))  
               minDistance(i,1)=distance(i,k);  
               pattern(i)=k;  
           end  
        end  
    end  
    max=0;  
    for i=2:patternNum  
        if((max<minDistance(i,1))&minDistance(i,1)~=0) % (x(i,:)~=center(k,:))    
            max=minDistance(i,1);  
            index=i;  
        end  
    end  
    if(max>(maxDistance*Theta))  
        k=k+1;  
        center(k,:)=x(index,:);  
        pattern(index)=k;  
        minDistance(index,1)=0;  
    else  
           break;  
    end  
end    