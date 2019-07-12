%非主函数，被调用，作用是获得x的上包络线
function s = getspline(x)
    N = length(x);%数组长度（即行数或列数中的较大值）
    p = findpeaks(x);%查找向量中的波峰
    s = spline([0 p N+1],[0 x(p) 0],1:N);%三样条插值函数寻找周围的值
end