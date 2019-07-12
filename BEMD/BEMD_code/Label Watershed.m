%读取原始图像
I = imread('haha.gif');
subplot(3,4,1);
imshow(I);
title('原始灰度图');

%%计算灰度梯度
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');
Ix = imfilter(double(I), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
subplot(3,4,2);
imshow(gradmag,[]);
title('灰度梯度图');

%%标记前景目标（内部约束）

%基于重建（reconstruct）的开—闭运算相对基本的开—闭运算来说，在不影响目标图象的前提下，去除图象中的碎片效果更好
%对灰度图象进行“opening-by-reconstruction”运算
I = imcomplement(I);   %对图像进行求反运算
se =strel('disk',20);   %创建由指定形状shape对应的结构元素
Ie = imerode(I, se);    %腐蚀图像
Iobr = imreconstruct(Ie,I);%数学形态学重建图像
subplot(3,4,3);
imshow(Iobr);
title('基于reconstruct的open操作');
%对进行开运算后的图象进行“closing-by-reconstruction”运算
%对重建前后的图象都要进行求补运算
%Following the opening with a closing can remove the dark spots and stem marks
Iobrd = imdilate(Iobr,se);
Iobrcbr = imreconstruct(imcomplement(Iobrd),imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
subplot(3,4,4);
imshow(Iobrcbr);
title('基于reconstruct的close操作');
%计算Iobrcbr的局部最大值，以得到更好的前景目标
%fgm = imextendedmax(Iobrcbr,30);%30是自定义的数值，明显不具有普遍性，原来是：
fgm = imregionalmax(Iobrcbr); %确定所有局部最大值，fgm是一个二值图像
subplot(3,4,5);
imshow(fgm);
title('局部最大值图像');
%将前景目标叠加到原图上(在实际应用中可以去除这步）
I2 = I;
I2(fgm) = 255; %I2与fgm重叠部分区fgm，不重叠的部分取255
subplot(3,4,6);
imshow(I2);
title('前景目标叠加到原图上');

%赵伟自己加的图像
%subplot(3,4,12);imshow(I);title('I:原图的求反图');

%清除标记边缘的模糊点
se2 = strel(ones(3,3));
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);
%去除所有小于特定像素数（此处设定为20）的斑点污渍
fgm4 = bwareaopen(fgm3, 20);  %用于从对象中移除小对象，此处指灰度值小于20的对象,fgm4是二值图
I3 = I;
I3(fgm4) = 255; %I3与fgm4重叠部分区fgm4，不重叠的部分取255
subplot(3,4,7);
imshow(I3);
title('修改局部最大值叠加在原图上');

%%计算背景标记(外部约束)

%将基于重建的开闭运算图象转化为二值图象
bw = im2bw(Iobrcbr,graythresh(Iobrcbr));  %grayshresh计算一个合适的阈值
subplot(3,4,8);
imshow(bw);
title('基于重建的阈值化二值图');
%计算距离函数，产生外部约束
D = bwdist(bw);
%将不属于目标的像素置为—inf
D = -D;
D(bw) = -Inf;  %D与bw重叠部分区bw，不重叠的部分取-Inf
DL = watershed(D);
bgm = DL == 0; %DL不变,bgm中非0元素变成0，0变成1,此处用来求取分割边界
subplot(3,4,9);
imshow(bgm);
title('分水岭脊线');

%%分水岭算法分割

%重构梯度图
gradmag2 = imimposemin(gradmag, bgm | fgm4);
%分割
L = watershed(gradmag2);

%{自己的代码
J = imread('haha.gif');
I4 = J;
L = imcomplement(L);
I4(imdilate(L == 0, ones(3, 3)) | bgm | fgm4 ) = 255;  %前景及边界处设置为255  
%}自己的代码

%分割线
subplot(3,4,10);
imshow(L);
title('分割线');

subplot(3,4,12);
imshow(I4);
title('分水岭分割结果');

%%
%{
J=I3;
J=imcomplement(J);
K = imcomplement(L);
subplot(3,4,11);imshow(K);title('分割后的图像重建');
%}

%{

%%直观显示结果
I4 = I;
I4(imdilate(L == 0, ones(3, 3)) | bgm | fgm4) = 255;
figure, imshow(I4)
title('Markers and object boundaries superimposed on original image (I4)')
%
Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');
figure, imshow(Lrgb)
title('Colored watershed label matrix (Lrgb)')
%
figure, imshow(I), hold on
himage = imshow(Lrgb);
set(himage, 'AlphaData', 0.3);
title('Lrgb superimposed transparently on original image');
%}
