fs = 1000;
ts = 1/fs;
t=0:ts:0.3;
z = sin(2*pi*10*t) + sin(2*pi*100*t);
plot(t,z);
imf=emd(z);
emd_visu(z,t,imf)  % EMD×¨ÓÃ»­Í¼º¯Êý