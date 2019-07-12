%   BEMD.m
%   J.C. Nunes, Y. Bouaoune, E. Deléchelle, N. Oumar, and Ph. Bunel.
%   "Image analysis by bidimensional empirical mode decomposition".
%   Image and Vision Computing Journal (IVC), (to appear), 2003. 

clear all
clear functions
close all
clc

disp('BEMD')

warning off

nb_modes=6; % number of modes

ext_lpe=1   % if ext_lpe==1 interpolation by extrema
            % else                       by crest lines

SDmax=1;            %   standard deviation

precision=0.0003;     %   precision of stop criteria

t1=150;
t2=150;
t3=0;
t4=0;

I=imread('2.jpg');


I=mat2gray(double(I));
%figure, imagesc(I), colormap(gray), title('image'),truesize, drawnow

I=double(I)*255;

figure, imagesc(I), colormap(gray), title('image'),truesize, drawnow

[If,Ires,Imodes]=BEMD_RBF(I,nb_modes,SDmax,ext_lpe,precision);

Iori=I;

sz=size(Imodes);
nbmodes=sz(3);
for j=1:nbmodes
    figure
    subplot(121),imagesc(Imodes(:,:,j)), colormap(gray),title(['mode' num2str(j)])
    Iori=Iori-Imodes(:,:,j);
    subplot(122),imagesc(Iori), colormap(gray),title('residue image ' ), truesize, drawnow
    
end

return

