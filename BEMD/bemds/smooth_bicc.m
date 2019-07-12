function [mean]=smooth_bicc(dx,dy,extm,mean,jexm,iexm); 
%INPUT: 
%   dx,dy is the mesh size of the image array A 
%   extm is the output 'maxmin' from scaledist 
%   mean is the mean surface of the image A 
%   jexm is the output 'jexm' from pickrc 
%   iexm is the output 'iexm' from pickrc 
%OUTPUT: 
%   mean is the smoothed mean surface of the image array A 
%���룺
%dx��dy��ͼ������A�������С
%extm�Ǵ����ű��������'maxmin'
%mean��ͼ��A��ƽ������
%jexm��pickrc�����'jexm'
%iexm��pickrc�����'iexm'
%OUTPUT��
%mean��ͼ������A��ƽ��ƽ������
[m,n] = size(mean); 
exmj = length(jexm); 
exmi = length(iexm); 
%--------------------------------------------- 
for ii=1:exmj 
    y(ii) = (jexm(ii)-1)*dy; 
end 
for ii=1:exmi 
    x(ii) = (iexm(ii)-1)*dx; 
end 
%------------------------------------ 
for jj=1:exmj 
    for ii=1:exmi 
        z(jj,ii) = mean(jexm(jj),iexm(ii)); 
    end 
end 
%---------------------------------------------- 
tol = 1.e-9; 
[pp] = spaps({y,x},z,tol); 
 
for jj=1:m 
    yy(jj)=(jj-1)*dy; 
end 
for ii=1:n 
    xx(ii)=(ii-1)*dx; 
end 
mean = fnval(pp,{yy,xx});


