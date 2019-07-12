z = imread('lena.jpg');
z=z(:,:,1);
imf = TwoD_EMD(z,5,0,1); 