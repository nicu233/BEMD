function [maxi,mini] = findextm(B); 
%INPUT: 
%   B is the image 
%----------------------------------------------- 
%OUTPUT: 
%   maxi is the transform matrix of A with 1's indicating 
%       a local maximum and 0's elsewhere 
%   mini is the transform matrix  of A with 1's indicating 
%       a local minimum and 0's elsewhere 
%输入：
%B是图像
%-----------------------------------------------％
%OUTPUT：
%maxi是A的变换矩阵，表示为1
%其他地方最大值为0，其他地方为0
%mini是A的变换矩阵，表示为1
%其他地方的本地最低和0的百分比
    kscale = 1; 
    [m,n] = size(B); 
    maxi = imextendedmax(B,0);%确定大于某阈值的极大值和小于某阈值的极小值这些函数报灰度图像作为输入参数，而把二值图像作为输出参数。在输出的二值图像中，局部极大值和局部极小值设为1，其他值设为0. 
    mini = imextendedmin(B,0); 
    maxi_d = bwdist(maxi); %计算元素之间的距离
    mini_d = bwdist(mini); 
    maxi_w = watershed(maxi_d);%分水岭函数切割图像 
    mini_w = watershed(mini_d);     
    % deal with the maxmium 
    tmax = max(max(maxi_w)); 
    index(1:tmax)=0;%矩阵索引     
    for ii=1:m 
        for jj=1:n 
            if (maxi_w(ii,jj)>0) 
                index(maxi_w(ii,jj)) = index(maxi_w(ii,jj))+1; 
            end 
        end 
    end 
    tmin = min(index(1:tmax)); 
    for ii=1:m 
        for jj=1:n 
            if (maxi(ii,jj)==1)&(index(maxi_w(ii,jj)) <= kscale*tmin) 
                maxi(ii,jj)=0; 
            end 
        end 
    end 
    % deal with the minmium 
    tmax = max(max(mini_w)); 
    index(1:tmax)=0; 
    for ii=1:m 
        for jj=1:n 
            if (mini_w(ii,jj)>0) 
                index(mini_w(ii,jj)) = index(mini_w(ii,jj))+1; 
            end 
        end 
    end 
    tmin = min(index(1:tmax)); 
    for ii=1:m 
        for jj=1:n 
            if (mini(ii,jj)==1)&(index(mini_w(ii,jj)) <= kscale*tmin) 
                mini(ii,jj)=0; 
            end 
        end 
    end

