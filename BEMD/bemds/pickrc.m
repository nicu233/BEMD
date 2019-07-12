function [jexm,iexm]=pickrc(maxmin); 
%INPUT: 
%   maxmin is the output 'maxmin' from scaledist 
%-------------------------------------------------- 
%OUTPUT: 
%   jexm is the array of indices of rows of A on which 
%       the number of characteristic points is greater than 
%       the threshold (See Y. Xu, et al, Two-dimensional empirical mode 
%       decomposition by finite elements, Proc. R. Soc. A., 2006) 
%   iexm is the array of indices of columns of A 
%       on which the number of characteristic points 
%       is greater than the threshold 
%输入：
%maxmin是从缩放词的输出'maxmin'
%------------------------------------------------- - 
%OUTPUT：
%jexm是其上的行的索引数组
%特征点数大于％
%阈值的百分比（参见Y. Xu等人，二维经验模式
%分解有限元， R. Soc。 A.，2006）
%iexm是A列的索引数组
%的特征点数
%大于阈值
mscale = 3.0; 
[m,n] = size(maxmin); 
mexm(1:m) = 0; 
nexm(1:n) = 0; 
for ii=1:m 
    for jj=1:n 
        if (maxmin(ii,jj)==1) 
            mexm(ii) = mexm(ii)+1; 
            nexm(jj) = nexm(jj)+1; 
        end 
    end 
end 
max_t = max(mexm); 
min_t = min(mexm); 
ceri = floor((max_t+min_t)/mscale); 
ceri = max(ceri,1); 
exmj = 1; 
jexm(exmj) =1; 
for ii=3:m-2 
    if (mexm(ii) >= ceri)&(jexm(exmj)~=(ii-1)) 
        exmj = exmj+1; 
        jexm(exmj) = ii; 
    end 
end 
exmj =exmj+1; 
jexm(exmj) = m; 
max_t = max(nexm); 
min_t = min(nexm); 
ceri = floor((max_t+min_t)/mscale); 
ceri = max(ceri,1); 
exmi = 1; 
iexm(exmi) = 1; 
for ii=3:n-2 
    if (nexm(ii) >= ceri)&(iexm(exmi)~=(ii-1)) 
        exmi = exmi+1; 
        iexm(exmi) = ii; 
    end 
end 
exmi = exmi+1; 
iexm(exmi) = n;

