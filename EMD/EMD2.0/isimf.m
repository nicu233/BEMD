%非主函数，被调用。判断当前x是不是真IMF
function u = isimf(x)
    N  = length(x);
    u1 = sum(x(1:N-1).*x(2:N) < 0);%求x与y=0轴交点的个数
    u2 = length(findpeaks(x))+length(findpeaks(-x));%求极值点个数
    if abs(u1-u2) <= 1
        u = 1;
    else
        u = 0;
    end
end