function maxs=maxsurf(sm,ch,cw)
% computing  the surface from scattered surface data using hierarchical b_spline
%input parameters: sm:输入的二维数组或者灰度图象矩阵
%ch,cw:控制网格的点数是缩放后的图象大小的1/(ch*cw)
%err:the minimun error用im的各个极大值点做散乱数据逼近求出它的极大包络曲面时的容许误差(%)
%output: maxs,与im相对应的极大包络曲面
%sm=imread('d:\xw.jpg');
%im=imread('d:\lk.bmp');
%sm=rgb2gray(sm);
%sm=imresize(sm,[height width],'bicubic');
sm=double(sm);
[height,width]=size(sm);
imm=double(sm);
figure;surf(imm);
bw=imregionalmax(sm,4);
bw=double(bw);
bw=sparse(bw);
[row,col]=find(bw);
num=length(row);
for i=1:num
    bw(row(i),col(i))=sm(row(i),col(i));
end
sm=bw;
[row,col,v]=find(sm);%row,col of sm,v value of sm in sm(row,col)
num=length(row);
%初始网格的大小:gr,gl
gr=floor(height/ch);
gl=floor(width/cw);
phi=zeros(gr+1,gl+1);
delta=phi;
omiga=phi;
nheight=gr-3;
nwidth=gl-3;
dh=height/nheight;
dw=width/nwidth;
for i=1:num
     row(i)=row(i)/dh;
     col(i)=col(i)/dw;
end
for p=1:num
       %i=floor(row(p))-1;
       %j=floor(col(p))-1;
       i=floor(row(p));
       j=floor(col(p));
       s=row(p)-floor(row(p));
       t=col(p)-floor(col(p));
       dn=0;%(3)的分母
       omiga1=zeros(4,4);
       for k=0:3
           for l=0:3
              omiga1(k+1,l+1)=wkl(k,l,s,t);
              dn=dn+omiga1(k+1,l+1)^2;
           end
       end
       for k=0:3
           for l=0:3
               phi(k+1,l+1)=omiga1(k+1,l+1)*v(p)/dn;
               delta(i+k+1,j+l+1)=delta(i+k+1,j+l+1)+omiga1(k+1,l+1)^2*phi(k+1,l+1);
               omiga(i+k+1,j+l+1)=omiga(i+k+1,j+l+1)+omiga1(k+1,l+1)^2;
           end
       end
 end
 for i=1:gr
     for j=1:gl
         if omiga(i,j)~=0
             phi(i,j)=delta(i,j)/omiga(i,j);
         else
             phi(i,j)=0;
         end
     end
 end
%  ZI = INTERP2(X,Y,Z,XI,YI)   ZI = INTERP2(Z,XI,YI) assumes X=1:N and Y=1:M where [M,N]=SIZE(Z).
for x=1:nheight
    for y=1:nwidth
        i=x-1;
        j=y-1;
        maxs(x,y)=0;
        for k=0:3
            for l=0:3
              maxs(x,y)=maxs(x,y)+wkl(k,l,0,0)*phi(i+k+1,j+k+1);
           end
        end
    end
end  
x1=1:(nheight-1)/(height-1):nheight;
y1=1:(nwidth-1)/(width-1):nwidth;
[x1,y1] = meshgrid(y1,x1);
maxs=interp2(maxs,x1,y1);
figure;
surf(maxs);