function [smax,smin] = extremos(matriz)
% Peaks through columns or rows.
smax = [];
smin = [];
for n = 1:length(matriz(1,:))
 [~,imaxfil,~,iminfil] = extrema(matriz(:,n)); clear temp
 if ~isempty(imaxfil)     % Maxima indexes
  imaxcol = repmat(n,length(imaxfil),1);
  smax = [smax; imaxfil imaxcol]; %#ok<AGROW>
 end
 if ~isempty(iminfil)     % Minima indexes
  imincol = repmat(n,length(iminfil),1);
  smin = [smin; iminfil imincol]; %#ok<AGROW>
 end
end