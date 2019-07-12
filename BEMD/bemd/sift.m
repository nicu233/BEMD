 function [ h_imf,residue ] = sift( input_image )
% This function sifts for a single IMF of the given 2D signal input
% Pre-processing
[len,bre] = size(input_image);
x = 1:len;
y = 1:bre;
input_image_temp = input_image;
while(1)
    % Finding the extrema in the 2D signal
    [zmax,imax,zmin,imin] = extrema2(input_image_temp);
    [xmax,ymax] = ind2sub(size(input_image_temp),imax);%ÇóË÷Òý
    [xmin,ymin] = ind2sub(size(input_image_temp),imin);
    % Interpolating the extrema to get the extrema suraces
    [zmaxgrid , ~, ~] = gridfit(ymax,xmax,zmax,y,x);
    [zmingrid, ~, ~] = gridfit(ymin,xmin,zmin,y,x);
    % Averaging the extrema to get the Zavg surface
    zavggrid = (zmaxgrid + zmingrid)/2;
    % Computation of the h_imf (IMF for the 'h' input)
    h_imf = input_image_temp - zavggrid;
    % Computing IMF SD
    %eps = 0.00000001;
    num = sum((h_imf-input_image_temp).^2);
    den = sum((input_image_temp).^2); %+ eps;
    SD = num/den;
    % Checking the IMF accuracy
    if SD<0.2
        break;
    else
        input_image_temp = h_imf;
    end
end
% Computation of the Residue after IMF computation
residue = input_image - h_imf;
