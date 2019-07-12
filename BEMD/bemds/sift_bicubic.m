function IMF=sift_bicubic(errmax,imax,dx,dy,A); 
%INPUT: 
%   errmax is the maximum error 
%   imax is the maximum number of iterations 
%   dx,dy is the mesh size of the image A 
%   A is the image 
%***************************************************** 
%OUTPUT: 
%   IMF is the instrinsic mode function of the image A 
%输入：
%errmax是最大误差
%imax是最大迭代次数
%dx，dy是图像A的网格大小
%A是图像
%***********************
%OUTPUT：
%IMF是图像A的本征模式函数
[m,n]=size(A); 
xya(2,m*n) = 0.0; 
for ii=1:m 
    for jj=1:n 
        ij=(ii-1)*n+jj; 
        xya(1,ij)=(jj-1)*dy; 
        xya(2,ij)=(ii-1)*dx; 
    end 
end 
%------------------------------------------- 
for it=1:imax, 
    [maxi,mini] = findextm(A); 
    clear xy 
    clear zm 
    numb = 0; 
    maxmin = max(maxi,mini); 
    [maxmin] = scaledist(maxmin,A); 
    num = sum(sum(maxmin)); 
    xy(2,num) = 0.0; 
    zm(num) = 0.0; 
    for ii=1:m 
        for jj=1:n 
            if (maxmin(ii,jj)==1); 
               numb = numb+1; 
               xy(1,numb)=(jj-1)*dy; 
               xy(2,numb)=(ii-1)*dx; 
               zm(numb)=A(ii,jj); 
            end 
        end 
    end 
    %-------------------------------- 
    [zm,tri]=smooth_rbf0(xy,zm); 
    [jexm,iexm]=pickrc(maxmin); 
    coor = xy'; 
    my = 0; 
    nx = 0; 
    [ipbe,pn]=p2tri(m,n,my,nx,dx,dy,coor,tri,jexm,iexm); 
    %------------------------------------------------ 
    [mean]=valu_m(m,n,tri,ipbe,pn,zm,jexm,iexm); 
    %------------------------------------------------- 
    [mean]=smooth_bicc(dx,dy,maxmin,mean,jexm,iexm); 
    A = double(A);
    A=A-mean; 
    err=0.0; 
    ynorm=0.0; 
    for ii=1:m 
        for jj=1:n 
            err=err+mean(ii,jj)*mean(ii,jj); 
            ynorm=ynorm+A(ii,jj)*A(ii,jj); 
        end 
    end 
    %---------------------------------------------- 
    err=sqrt(err); 
    ynorm=sqrt(ynorm); 
    if (ynorm>1) 
        err=err/ynorm;         
    end 
    if ( err<=errmax) 
        err; 
        break 
    end     
    if( it==imax ) 
        'Warning: too many iterations,and now the sifting will be forced stop'; 
        break  
    end 
end 
IMF=A;
