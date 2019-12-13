
x=[0,0;1,0;0,1;1,1;2,1;1,2;2,2;3,2;6,6;7,6;8,6;6,7;7,7;8,7;9,7;7,8;8,8;9,8;8,9;9,9];
% x,y�᷶Χ
xmin=-2;
xmax=8;
ymin=-2;
ymax=8;
[N,M]=size(x);
% ѡȡ�洢���ĵ��λ�ã��ֱ�Ϊǰ��������ģ���һ����������,��ʼ��ǰһ�����ĵ�
% A1,B1
A1=x(1,:);
B1=x(2,:);
A2=[];
B2=[];
% ���������ݴ��������е����
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
% ������һ������λ��
[n,m]=size(temp1);
A2=sum(temp1)/n;
B2=sum(temp2)/(8-n);
% �㷨ֹͣ׼��
if isequal(A1,A2)&&isequal(B1,B2)
    break;
else
%���ĵ����
    A1=A2;
    B1=B2;
end
end
disp('���1������λ��:');
disp(A2);
disp('���2������λ��:');
disp(B2);
% ��ʾ���շ�����
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