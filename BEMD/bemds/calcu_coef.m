function [p2p]=calcu_coef(numb,tri); 
%INPUT: 
%   numb is the number of characteristic points of A 
%   tri is the output 'tri' from smooth_rbf0 
%OUTPUT: 
%   p2p is the array of coefficients used in smooth_rbf0 
%输入：
%numb是A的特征点数
%tri是来自smooth_rbf0的输出'tri'
%OUTPUT：
%p2p是在smooth_rbf0中使用的系数数组
[kelem,nnode]=size(tri); 
jdiage(numb+1)=0; 
for ie=1:kelem 
    for jj=1:nnode 
        ip=tri(ie,jj); 
        jdiage(ip+1)=jdiage(ip+1)+1; 
    end 
end 
maxe=max(jdiage); 
for ip=2:numb+1 
    jdiage(ip)=jdiage(ip)+jdiage(ip-1); 
end 
jdia(numb)=0; 
p2tri(jdiage(numb+1))=0; 
for ie=1:kelem 
    for jj=1:nnode 
        ip=tri(ie,jj); 
        jdia(ip)=jdia(ip)+1; 
        p2tri(jdiage(ip)+jdia(ip))=ie; 
    end 
end 
p2p(numb,2*maxe+1)=0; 
for inod=1:numb 
    i0 = jdiage(inod)+1; 
    i1 = jdiage(inod+1); 
    for ii=i0:i1 
        ie=p2tri(ii); 
        for jj=1:nnode 
            ip=tri(ie,jj); 
            if (ip~=inod) 
                key=1; 
                for kk=1:p2p(inod,1) 
                    kp=p2p(inod,kk+1); 
                    if (ip==kp) 
                        key=0; 
                        break; 
                    end 
                end 
                if (key==1) 
                    p2p(inod,1)=p2p(inod,1)+1; 
                    p2p(inod,p2p(inod,1)+1)=ip; 
                end 
            end 
        end 
    end 
end

