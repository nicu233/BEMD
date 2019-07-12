%主函数
function imf = emd(x)
% Empiricial Mode Decomposition (Hilbert-Huang Transform)
% imf = emd(x)
% Func : findpeaks
    x = transpose(x(:));%矩阵数组转置
    imf = [];
    while ~ismonotonic(x)%如果x不是空的数据，执行if里面的语句
        x1 = x;
        sd = Inf;%均值
        while (sd == 0) || ~isimf(x1)
            s1 = getspline(x1);
            s2 = -getspline(-x1);
            x2 = x1-(s1+s2)/2;
            sd = sum((x1-x2))/numel((x1-x2));
            x1 = x2;
        end
        imf(end+1,:) = x1;
        x = x-x1;
    end
    %imf(end+1,:) = x;

