%   BEMD 
%   Interpolation by radial basis functions from extrema or crest lines
%
%   J.C. Nunes, Y. Bouaoune, E. Del�chelle, N. Oumar, and Ph. Bunel.
%   "Image analysis by bidimensional empirical mode decomposition".
%   Image and Vision Computing Journal (IVC), (to appear), 2003. 

function [I,Ires,If,nbr_extrema]=BEMD_RBF(Iori,nb_modes,SDmaxori,ext_lpe,precision)

SDmax=SDmaxori;             %   SDmax de d�part     Crit�re d'arret d'obtention d'un mode
SDmax_prec=SDmaxori*2;      %   SDmax pr�c�dent 
kzeros=1;                   %   on ne tient pas compte des surfaces inf�rieures � ce scale
difference=0;

if ext_lpe==1
    disp('Interpolation par les extrema')
else
    disp('Interpolation par les lignes cr�tes')
end
t=size(Iori);
If=[];
alpha=1;                    % coefficient multiplicatif du SDmax entre deux modes

nbextrema=0;

for j= 1:nb_modes           % nombre de modes
    I=Iori;
    chaine='mode non trouv�';
    for i= 1:300            % nombre d'it�rations par modes
        SDmax=SDmaxori;     %   standard deviation
        if i==1
            difference=0;
        end
        if j==1
            if i==1
                SDmaxori=SDmaxori;
            end
            SDmax=SDmaxori;
        end
        if j>1
            if i==1
                SDmaxori=SDmaxori*alpha;
            end
            SDmax=SDmaxori;
        end
            
        [Ienv_I,Ienv_S,nb_extr]=Env_Rbf(I,ext_lpe);

        [If(:,:,j),difference,SDmax_prec]=moy_env(I,Ienv_S,Ienv_I,SDmax,SDmax_prec,precision);
        chaine='mode non trouv�';
%        disp(['SDmax_prec= ' num2str(SDmax_prec)])
        
        if difference==1
            chaine='mode trouv�';
            difference=0;
            nbr_extrema(j)=nb_extr;
            SDmax=1;
            disp('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   Obtention d''un Mode')
            break;
        end
        I=If(:,:,j);
    end
    difference=0;
    nbr_extrema(j)=nb_extr;
    
    Iori=Iori-If(:,:,j);

    Ires=Iori;
%    figure
%    subplot(121),imagesc(If(:,:,j)), colormap(gray),  title(['Mode n�' num2str(j) chaine]), 
%    subplot(122),imagesc(Ires), colormap(gray), title('R�sidu'),truesize, drawnow
    
end

return
