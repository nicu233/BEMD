%   Env_Rbf.m
%   BEMD 
%   Interpolation by radial basis functions from extrema or crest lines
%
%   J.C. Nunes, Y. Bouaoune, E. Deléchelle, N. Oumar, and Ph. Bunel.
%   "Image analysis by bidimensional empirical mode decomposition".
%   Image and Vision Computing Journal (IVC), (to appear), 2003. 

function [Ienvmin,Ienvmax,nbr_extrema]=Env_Rbf(I,ext_lpe)
global name

%   si ext_lpe==1 interpolation par les extrema sinon par les lignes crètes

[t1 t2]=size(I);
CONN=8;
h=1;
I2=double(I);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcul de l'image des minima
if ext_lpe==1
    IMin=imregionalmin(I2);
    IMin=double(IMin);
    Imin=IMin.*I2;
else
    I2_inv=double(imcomplement(double(I2)))*255;
    IMin=watershed(I2_inv,CONN);
    IMin=IMin==0;
    IMin=double(IMin);
    Imin=IMin.*I2;
    clear I2_inv
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Calcul de l'image maxima
if ext_lpe==1
    IMax=imregionalmax(I2);
    IMax=double(IMax);
    Imax=IMax.*I2;
else
    IMax=watershed(I2,CONN);
    IMax=IMax==0;
    IMax=double(IMax);
    Imax=IMax.*I2;
end

%%%%%%%%%%%%%%%%%%%%%%  Les minima  %%%%%%%%%%%%%%%%%%%%%%%
% Calcul enveloppe min
[x,y,z] = find(Imin);   % on calcule l'env inf à partir des valeurs numériques min régionaux
datamin.Location(1,:)=x(:);
datamin.Location(2,:)=y(:);
datamin.Value=z';

nbr_extrema=length(y);

if length(y)<4
    Ienvmin=I;
    Ienvmax=I;
    disp(['Pourquoi nbre de min si petit, nombre de min=' num2str(length(y))])
    return
else    
    clear x y z

    rbfmin=fastrbf_fit(datamin,0.00000001);

    clear datamin

    gmin=fastrbf_grideval(rbfmin,'spacing',1,'size',[t1,t2],'accuracy',0.001);

    Ienvmin=gmin.Value; % enveloppe inf

    clear gmin
end

%%%%%%%%%%%%%%%%%%%%%%  Les minima  %%%%%%%%%%%%%%%%%%%%%%%
% Calcul enveloppe max
[x,y,z] = find(Imax);      % on calcule l'env max à partir des valeurs numériques max régionaux

datamax.Location(1,:)=x(:);
datamax.Location(2,:)=y(:);
datamax.Value=z';

nbr_extrema=nbr_extrema+length(y);

if length(y)<4
    Ienvmin=I;
    Ienvmax=I;
    disp(['Pourquoi nbre de max si petit, nombre de max=' num2str(length(y))])
    return
else
    clear x y z

    rbfmax=fastrbf_fit(datamax,0.00000001);

    clear datamax

    gmax=fastrbf_grideval(rbfmax,'spacing',1,'size',[t1,t2],'accuracy',0.001);

    Ienvmax=gmax.Value;
    clear gmax
end

clear gmax I2 rbfmax rbfmin IMax IMin
return