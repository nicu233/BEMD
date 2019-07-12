%   moy_env.m
%   BEMD 
%
%   J.C. Nunes, Y. Bouaoune, E. Deléchelle, N. Oumar, and Ph. Bunel.
%   "Image analysis by bidimensional empirical mode decomposition".
%   Image and Vision Computing Journal (IVC), (to appear), 2003. 

function [ID,Difference,SD]=moy_env(I,IS,IF,SDmax,SDmax_prec,precision)

%precision=0.08;    %   précision du critère d'arret

I=double(I);
    
Difference=0;  % Si difference entre la moyenne des 2 enveloppes SUP ET INF
               % et l'image originale est NULLE ======> Difference=1

[t1 t2]=size(I);
eps=1;  % introduit dans le calcul de SD pour éviter des divisions par zéro

ID=I;   % ID=image résidu, on calcule la différence entre l'image I et la moyenne des 2 enveloppes sup et inf 

IS=double(IS);  %enveloppe sup
IF=double(IF);  %enveloppe inf
IM=(IS+IF)/2;   % Moyenne des 2 enveloppes sup et inf

IDif=I-IM;        % Difference entre l'image de départ et l'image moyenne
%figure,imagesc(IDif),colormap(gray),title('IDif'),truesize

SD=sum((IDif(:).^2)./(I(:).^2+eps));
%SD=sum((IDif(:).^2)./(I(:).^2+eps));

a=abs(SD-SDmax_prec);

b=(precision*SD);        % maintenant on prend celui-là 

if a<b
    Difference=1;
    ID=I; 
    disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   a<b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
else      
    if SD<SDmax
        Difference=1;
        ID=I; 
%        figure,imagesc(I),colormap(gray),title('mode obtenu'),truesize
    else  % Difference=0
        Difference=0;
        ID=IDif;        % Difference entre l'image de départ et l'image moyenne
    end
end

clear IMM IS IF Ib IDif

return
