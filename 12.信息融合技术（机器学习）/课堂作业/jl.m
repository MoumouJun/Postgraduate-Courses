clear all  
clc  
x=[0,3,1,2,0; 1,3,0,1,0; 3,3,0,0,1; 1,1,0,2,0; 3,2,1,2,1;4,1,1,1,0]  
Theta=0.5;  
[pattern,centerIndex]=MaxMinDisFun(x,0.5) 
function [classes,centerIndex]=MaxMinDisFun(x,Theta)  
maxDistance=0;  
start=1;    %��ʼѡһ�����ĵ�  
index=start;%�൱��ָ��ָʾ�����ĵ��λ��  
k=1;        %���ĵ������Ҳ�������  
dataNum=size(x,1);  %�����������  
centerIndex=zeros(dataNum,1); %�������ĵ�  
distance=zeros(dataNum,1);    %��ʾ������������ǰ�������ĵľ���  
minDistance=zeros(dataNum,1); %ȡ��С����  
classes=zeros(dataNum,1);     %��ʾ���  
  
centerIndex(1)=index;%�����һ����������  
classes(:)=k;        %��ʼ���ȫΪk  
%%  
for i=1:dataNum  
    distance(i)=sqrt((x(i,:)-x(centerIndex(1),:))*(x(i,:)-x(centerIndex(1),:))');%ŷ�Ͼ��룬���1���������ĵľ���  
    classes(i)=k;%��1��  
    if(maxDistance<distance(i))  
        maxDistance=distance(i);%���һ���������ĵ�������  
        index=i;%���һ���������ľ�����������  
    end  
end  
%%  
minDistance=distance;  
% minDistance(index,1)=0;  
maxVal=maxDistance;  
while(maxVal>(maxDistance*Theta))%�ж��µľ��������Ƿ���������  
    k=k+1;  
    centerIndex(k)=index;%�ж��µľ��������Ƿ���������,��������������������  
    for i=1:dataNum   
            distance(i)=sqrt((x(i,:)-x(centerIndex(k),:))*(x(i,:)-x(centerIndex(k),:))');%���k���������ĵľ���  
           if(minDistance(i)>distance(i))  
               minDistance(i)=distance(i);  
               classes(i)=k;%���յ�ǰ����ٷ�ʽ���࣬�ĸ����ͷ��ĸ����  
           end  
    end  
    %����minDistance�����ֵ  
    maxVal=0;  
    for i=1:dataNum  
        if((maxVal<minDistance(i)))   
            maxVal=minDistance(i);  
            index=i;  
        end  
    end  
%     centerIndex(k+1)=index;%�µľ�������  
    aaa=0;  
end  
end    