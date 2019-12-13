function numgrad = computeNumericalGradient(J, theta)
%% computeNumericalGradient�����Ĺ����ǣ�����һ������J(theta)�������ķ�ʽ��@����ʹ�õķ��̣�
%Ȼ�����ٸ�һ��theta��ֵ����ô��������Ϳ��������󵼶�����Ǹ���ʽ��������J������theta���ĵ��������
%theta��һ����������ô�������J������theta�������δ֪����ƫ��������˵ó��Ľ����һ���������� numgrad
%������
numgrad = zeros(size(theta));%��ʼ��
EPSILON=0.0001;
for i=1:size(theta)  %ÿһ��i��J���̶�theta�ĵ�i��������ƫ������
    theta_plus=theta;
    theta_minu=theta;
    theta_plus(i)=theta_plus(i)+EPSILON;%�ö��幫ʽ��ƫ������ôtheta���ĺ�С�������������ֻ�е�i��
    %�������ӻ������EPSILON
    theta_minu(i)=theta_minu(i)-EPSILON;
    numgrad(i)=(J(theta_plus)-J(theta_minu))/(2*EPSILON);
end

end
