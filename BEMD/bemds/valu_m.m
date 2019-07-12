function  [mean]=valu_m(m,n,itri,ipbe,pn,disp,jexm,iexm); 
%INPUT: 
%   [m,n] is the size of the image A 
%   itri is the output 'tri' from smooth_rbf0 
%   ipbe is the output 'ipbe' from p2tri 
%   pn is the ouput 'pn' from p2tri 
%   disp is the output 'zm' from smooth_rbf0 
%   jexm is the output 'jexm' from pickrc 
%   iexm is the output 'iexm' from pickrc 
%-------------------------------------------------------------- 
%OUTPUT: 
%   mean is the mean surface of the image A 
%输入：
%[m，n]是图像A的大小
%itri是从smooth_rbf0输出的'tri'
%ipbe是来自p2tri的输出'ipbe'
%pn是来自p2tri的输出'pn'
%disp是来自smooth_rbf0的输出'zm'
%jexm是pickrc的输出'jexm'
%iexm是pickrc的输出'iexm'
%--------------------------------------------------------------
%OUTPUT：
%mean是图像A的平均表面

[kelem,nnode] = size(itri); 
knode = length(ipbe); 
mean(m,n) = 0.0; 
exmj = length(jexm); 
exmi = length(iexm); 
for ir=1:exmj 
    for ic=1:exmi 
        ii=(jexm(ir)-1)*n+iexm(ic); 
        ie = ipbe(ii); 
        if (ie <= 0)  
            break; 
        else 
          mean(jexm(ir),iexm(ic)) = pn(ii,1)*disp(itri(ie,1))+pn(ii,2)*disp(itri(ie,2))+pn(ii,3)*disp(itri(ie,3)); 
        end        
    end 
end

