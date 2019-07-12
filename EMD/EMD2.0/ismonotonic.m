%非主函数，被调用<br>%判断x是否单调，返回0代表不是单调，返回1代表是单调
function u = ismonotonic(x)
    u1 = length(findpeaks(x))*length(findpeaks(-x));%如果最大/最小值有一个为0即可判断程序满足退出条件了
    if u1 > 0
        u = 0;
    else
        u = 1;
    end