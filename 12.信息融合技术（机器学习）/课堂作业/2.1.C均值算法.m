
x=[0,0;1,0;0,1;1,1;2,1;1,2;2,2;3,2;6,6;7,6;8,6;6,7;7,7;8,7;9,7;7,8;8,8;9,8;8,9;9,9];
% x,y轴范围
xmin=-2;
xmax=8;
ymin=-2;
ymax=8;
[N,M]=size(x);
% 选取存储中心点的位置，分别为前两类的中心，后一次两类中心,初始化前一次中心点
% A1,B1
A1=x(1,:);
B1=x(2,:);
A2=[];
B2=[];
% 定义两个暂存聚类过程中的类别
while(1)
temp1=[];
temp2=[];
for i=1:N
    D1=pdist2(x(i,:),A1,'euc');
    D2=pdist2(x(i,:),B1,'euc');
    if D1>D2
        temp2=[temp2;x(i,:)];
    else
         temp1=[temp1;x(i,:)];
    end
end
% 更新下一次中心位置
[n,m]=size(temp1);
A2=sum(temp1)/n;
B2=sum(temp2)/(8-n);
% 算法停止准则
if isequal(A1,A2)&&isequal(B1,B2)
    break;
else
%中心点更新
    A1=A2;
    B1=B2;
end
end
disp('类别1的中心位置:');
disp(A2);
disp('类别2的中心位置:');
disp(B2);
% 显示最终分类结果
plot(temp1(:,1),temp1(:,2),'ro','MarkerFaceColor','r');
hold on
plot(temp2(:,1),temp2(:,2),'go','MarkerFaceColor','g');
hold on
plot(A2(:,1),A2(:,1),'ko','MarkerFaceColor','k');
hold on
plot(B2(:,1),B2(:,1),'ko','MarkerFaceColor','k');
axis([xmin xmax ymin ymax]);
xlabel('x1');
ylabel('x2');