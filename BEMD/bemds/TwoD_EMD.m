function IMF_all=TwoD_EMD(A,imf_num,errmax,imax); 
%INPUT: 
%   A is the image to be decomposed, given as a rectangular matrix 
%   imf_num is the number of intrinsic mode functions to be taken from A 
%   errmax is the maximum error for sift_bicubic 
%   imax is the maximum number of iterations in sift_bicubic 
%------------------------------------------------------------------- 
%OUTPUT: 
%   IMF_all is a 3D array containing each instrinsic mode function 
%       as well as the final residue 
%A是要分解的图像，给定为矩形矩阵
%imf_num是从A获取的固有模式函数的数量
%errmax是sift_bicubic的最大错误
%imax是sift_bicubic中的最大迭代次数
%-------------------------------------------------------------------
%OUTPUT：
%IMF_all是一个包含每个内在模式功能的3D阵列
%以及最终残留物
figure;
imagesc(A); 
colormap(gray);%输出一个灰色系的曲面图
IMF_all=[]; 
[m,n]=size(A); 
dx=1/n; 
dy=1/m; 
for it=1:imf_num 
    IMF=sift_bicubic(errmax,imax,dx,dy,A); 
    figure(it+5) 
    imagesc(IMF); 
    colormap(gray);
    A = double(A);
    A=A-IMF; 
    IMF_all(:,:,it)=IMF; 
end 
IMF_all(:,:,it+1)=A; 
figure;
imagesc(A); 
colormap(gray); 

