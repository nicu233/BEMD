function [ipbe,pn]=p2tri(m,n,my,nx,dx,dy,coor,node,exmj,exmi); 
%INPUT: 
%   [m,n] is the size of the image array A 
%   dx,dy is the mesh size of the image A 
%   coor is the transpose of the input 'xy' from smooth_rbf0 
%   node is the output 'tri' from smooth_rbf0 
%   exmj is the output 'jexm' from pickrc 
%   exmi is the output 'iexm' from pickrc 
%OUTPUT: 
%   ipbe,pn are intermediate variables used to compute the 
%       mean surface 
%输入：
%[m，n]是图像阵列A的大小
%dx，dy是图像A的网格大小
%coor是来自smooth_rbf0的输入“xy”的转置
%node是从smooth_rbf0输出的'tri'
%exmj是pickrc的输出'jexm'
%exmi是pickrc的输出'iexm'
%OUTPUT：
%ipbe，pn是用于计算的中间变量
%平均表面
[knode,ncoor]=size(coor); 
[kelem,nod]=size(node); 
mn=m*n; 
pn(mn,3) = 0.0; 
ipbe=-1*ones(1,mn); 
jexm = length(exmj); 
iexm = length(exmi); 
for ii=1:jexm 
    for jj=1:iexm 
        ij = (exmj(ii)-1)*n+exmi(jj); 
        ipbe(ij) = 0; 
    end 
end 
ip2e(knode,2)=0; 
for ii=1:kelem 
    for jj=1:nod 
        ip = node(ii,jj); 
        ip2e(ip,1) = ii; 
        ip2e(ip,2) = jj; 
    end 
end 
for ii=1:knode 
    iii = round(coor(ii,2)/dy)+1; 
    jjj = round(coor(ii,1)/dx)+1; 
    ip = (iii-1)*n+jjj; 
    ipbe(ip) = ip2e(ii,1); 
    pn(ip,1:3) = 0.0; 
    pn(ip,ip2e(ii,2)) = 1.0; 
end 
% check every element include which knots 
xpmin = nx*dx; 
xpmax = (nx+n-1)*dx; 
ypmin = my*dy; 
ypmax = (my+m-1)*dy; 
for ie=1:kelem 
    x(1) = coor(node(ie,1),1); 
    y(1) = coor(node(ie,1),2); 
    x(2) = coor(node(ie,2),1); 
    y(2) = coor(node(ie,2),2); 
    x(3) = coor(node(ie,3),1); 
    y(3) = coor(node(ie,3),2); 
    area = cal_triarea(x(1),y(1),x(2),y(2),x(3),y(3)); 
    xmin = min(x); 
    xmax = max(x); 
    ymin = min(y); 
    ymax = max(y); 
    xmin = max(xmin,xpmin); 
    xmax = min(xmax,xpmax); 
    ymin = max(ymin,ypmin); 
    ymax = min(ymax,ypmax); 
    ix = round((xmax-xmin)/dx); 
    iy = round((ymax-ymin)/dy); 
    i0 = round((xmin-xpmin)/dx); 
    j0 = round((ymin-ypmin)/dy); 
    for jj=1:iy+1 
        for ii=1:ix+1 
            ij = (jj+j0-1)*n+ii+i0; 
            if (ipbe(ij)==0) 
                xp = xmin + (ii-1)*dx; 
                yp = ymin + (jj-1)*dy; 
                pn(ij,1) = cal_triarea(xp,yp,x(2),y(2),x(3),y(3))/area; 
                pn(ij,2) = cal_triarea(x(1),y(1),xp,yp,x(3),y(3))/area; 
                pn(ij,3) = cal_triarea(x(1),y(1),x(2),y(2),xp,yp)/area; 
                key = 1; 
                for kk=1:3 
                    if (pn(ij,kk) < -1.e-6) | (pn(ij,kk) > (1.+1.e-6)) 
                        key = 0 ; 
                        break ; 
                    end 
                end 
                if (key==1) 
                    ipbe(ij) = ie; 
                end 
            end 
        end 
    end 
end

