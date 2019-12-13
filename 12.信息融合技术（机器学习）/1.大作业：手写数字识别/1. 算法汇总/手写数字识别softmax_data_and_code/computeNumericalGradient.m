function numgrad = computeNumericalGradient(J, theta)
%% computeNumericalGradient函数的功能是：给定一个方程J(theta)，给定的方式是@你想使用的方程，
%然后你再给一个theta的值，那么这个函数就可以利用求导定义的那个公式来求出这个J方程在theta这点的导数，如果
%theta是一个向量，那么就是求出J方程在theta这点所有未知量的偏导数，因此得出的结果是一个向量，以 numgrad
%给出。
numgrad = zeros(size(theta));%初始化
EPSILON=0.0001;
for i=1:size(theta)  %每一个i是J方程对theta的第i个变量求偏导数。
    theta_plus=theta;
    theta_minu=theta;
    theta_plus(i)=theta_plus(i)+EPSILON;%用定义公式求偏导，那么theta这点的很小的增量或减量中只有第i个
    %变量增加或减少了EPSILON
    theta_minu(i)=theta_minu(i)-EPSILON;
    numgrad(i)=(J(theta_plus)-J(theta_minu))/(2*EPSILON);
end

end
