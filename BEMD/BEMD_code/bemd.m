function imf=bemd(im)
%if nargin~=1 
 % [filename, pathname] = uigetfile( {'*.bmp', 'Bitmap Files (*.bmp)';'*.jpg', 'Jpeg Files (*.jpg)';'*.jpeg', 'Jpeg Files (*.jpeg)'}, 'Open a image file');
 % fn=strcat(pathname,filename);
 % im=imread(fn);
%end
%x=1:120;
%y=1:110;
%[x,y]=meshgrid(y,x);
%im=40*sin(2*pi/40*x)+40*sin(2*pi/60*y)+30*sin(2*pi/14*x)+50*sin(2*pi/17*y)+190*sin(2*pi/0.2*x)+190*sin(2*pi/0.3*y);
%im=5*sin(2*pi/40*x+2*pi/60*y)+6*sin(2*pi/14*x+2*pi/17*y)+50*sin(2*pi/0.2*x+2*pi/0.3*y);
dim=size(im);
if size(dim,2)>2
    im=rgb2gray(im);
end
figure;imshow(im);
im=imresize(im,[128,108],'bicubic');
i=0;
im=double(im); 
  figure;surf(im);
title('original mesh');
ch=1.4;
cw=1.4;
rim=im;
while 1
    if max(max(im))<8
        i=i+1;
        imf(i,:,:)=im;
        figure;imshow(im);
        surf(im);
        break;
    else
        maxs=maxsurf(im,ch,cw);
        mins=minsurf(im,ch,cw);
        m=(maxs+mins)/2;
        im=im-m;
        sd=std(std(im));
        if sd<8
            i=i+1;
            imf(i,:,:)=im;
           figure;imshow(im);
           surf(im);
            rim=rim-im;
            im=rim;
        end
   end
end
disp(strcat(num2str(i),'imfs was decomposed'));
dim=size(im);
z=zeros(dim);
z1=z;
 for j=1:i

   z1(x,y)=imf(j,:,:);

   figure;imshow(c)
   z=z+z1;
end
   figure;imshow(c)
for x=1:220
    for y = 1:220
        z2(x,y)=imf(1,x,y); z3=1/(pi^2*x*y);      
    end
end
H=conv2(z2,z3);
figure;imshow(H);

%z=uint8(z);
%figure;imshow(z);

%x=1:243;
%y=1:305;
%h(x,y)=1/(pi^2*x*y);
%dim=size(im);
%b=zeros(dim);
%b1=b;
%for  j=1:i
%    b1(:,:)=imf(j,:,:)
%   b= b1
%    c=conv2(b,1/(pi^2*x*y);
 %  figure;imshow(c);
% end
    
