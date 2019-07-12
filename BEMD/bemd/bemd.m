function [ imf_sum ] = bemd( input_image )
% BEMD This program calculates the Bidimensional EMD of a 2-d signal using
% the process of sifting. It is dependent on the function SIFT.
%tic
% Make a 'double' copy of the image
input_image_d = cast(input_image,'double');
% Assigning the initial values of 'h' (data for sifting) and 'k' (imf index)
%分配初始值'h'（筛选数据）和'k'i（imf索引）
h_func = input_image_d;
k=1;%筛选参数
% The process of Sifting
while(k<4)
    [imf_temp,residue_temp] = sift(h_func); 
    imf_matrix(:,:,k) = imf_temp; %#ok<AGROW>
    %figure;
    %imshow(uint8(residue_temp));
    %figure;
    %imshow(mat2gray(imf_temp));
    k = k+1;
    h_func = residue_temp;
    imf_matriy(:,:,k) = residue_temp;
end
k=2
imf_sum=0;
while(k<4)
    imf=imf_matriy(:,:,k);
    imf_sum=imf+imf_sum;
    k=k+1;
end
% Assigning the final residue to the last IMF index
%imf_matrix(:,:,k) = residue_temp
% End of BEMD Computation
%toc

