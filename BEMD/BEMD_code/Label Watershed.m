%��ȡԭʼͼ��
I = imread('haha.gif');
subplot(3,4,1);
imshow(I);
title('ԭʼ�Ҷ�ͼ');

%%����Ҷ��ݶ�
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');
Ix = imfilter(double(I), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
subplot(3,4,2);
imshow(gradmag,[]);
title('�Ҷ��ݶ�ͼ');

%%���ǰ��Ŀ�꣨�ڲ�Լ����

%�����ؽ���reconstruct���Ŀ�����������Ի����Ŀ�����������˵���ڲ�Ӱ��Ŀ��ͼ���ǰ���£�ȥ��ͼ���е���ƬЧ������
%�ԻҶ�ͼ����С�opening-by-reconstruction������
I = imcomplement(I);   %��ͼ�����������
se =strel('disk',20);   %������ָ����״shape��Ӧ�ĽṹԪ��
Ie = imerode(I, se);    %��ʴͼ��
Iobr = imreconstruct(Ie,I);%��ѧ��̬ѧ�ؽ�ͼ��
subplot(3,4,3);
imshow(Iobr);
title('����reconstruct��open����');
%�Խ��п�������ͼ����С�closing-by-reconstruction������
%���ؽ�ǰ���ͼ��Ҫ����������
%Following the opening with a closing can remove the dark spots and stem marks
Iobrd = imdilate(Iobr,se);
Iobrcbr = imreconstruct(imcomplement(Iobrd),imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
subplot(3,4,4);
imshow(Iobrcbr);
title('����reconstruct��close����');
%����Iobrcbr�ľֲ����ֵ���Եõ����õ�ǰ��Ŀ��
%fgm = imextendedmax(Iobrcbr,30);%30���Զ������ֵ�����Բ������ձ��ԣ�ԭ���ǣ�
fgm = imregionalmax(Iobrcbr); %ȷ�����оֲ����ֵ��fgm��һ����ֵͼ��
subplot(3,4,5);
imshow(fgm);
title('�ֲ����ֵͼ��');
%��ǰ��Ŀ����ӵ�ԭͼ��(��ʵ��Ӧ���п���ȥ���ⲽ��
I2 = I;
I2(fgm) = 255; %I2��fgm�ص�������fgm�����ص��Ĳ���ȡ255
subplot(3,4,6);
imshow(I2);
title('ǰ��Ŀ����ӵ�ԭͼ��');

%��ΰ�Լ��ӵ�ͼ��
%subplot(3,4,12);imshow(I);title('I:ԭͼ����ͼ');

%�����Ǳ�Ե��ģ����
se2 = strel(ones(3,3));
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);
%ȥ������С���ض����������˴��趨Ϊ20���İߵ�����
fgm4 = bwareaopen(fgm3, 20);  %���ڴӶ������Ƴ�С���󣬴˴�ָ�Ҷ�ֵС��20�Ķ���,fgm4�Ƕ�ֵͼ
I3 = I;
I3(fgm4) = 255; %I3��fgm4�ص�������fgm4�����ص��Ĳ���ȡ255
subplot(3,4,7);
imshow(I3);
title('�޸ľֲ����ֵ������ԭͼ��');

%%���㱳�����(�ⲿԼ��)

%�������ؽ��Ŀ�������ͼ��ת��Ϊ��ֵͼ��
bw = im2bw(Iobrcbr,graythresh(Iobrcbr));  %grayshresh����һ�����ʵ���ֵ
subplot(3,4,8);
imshow(bw);
title('�����ؽ�����ֵ����ֵͼ');
%������뺯���������ⲿԼ��
D = bwdist(bw);
%��������Ŀ���������Ϊ��inf
D = -D;
D(bw) = -Inf;  %D��bw�ص�������bw�����ص��Ĳ���ȡ-Inf
DL = watershed(D);
bgm = DL == 0; %DL����,bgm�з�0Ԫ�ر��0��0���1,�˴�������ȡ�ָ�߽�
subplot(3,4,9);
imshow(bgm);
title('��ˮ�뼹��');

%%��ˮ���㷨�ָ�

%�ع��ݶ�ͼ
gradmag2 = imimposemin(gradmag, bgm | fgm4);
%�ָ�
L = watershed(gradmag2);

%{�Լ��Ĵ���
J = imread('haha.gif');
I4 = J;
L = imcomplement(L);
I4(imdilate(L == 0, ones(3, 3)) | bgm | fgm4 ) = 255;  %ǰ�����߽紦����Ϊ255  
%}�Լ��Ĵ���

%�ָ���
subplot(3,4,10);
imshow(L);
title('�ָ���');

subplot(3,4,12);
imshow(I4);
title('��ˮ��ָ���');

%%
%{
J=I3;
J=imcomplement(J);
K = imcomplement(L);
subplot(3,4,11);imshow(K);title('�ָ���ͼ���ؽ�');
%}

%{

%%ֱ����ʾ���
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
