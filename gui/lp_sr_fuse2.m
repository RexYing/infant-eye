function [Y,YO] = lp_sr_fuse2(M1, M2, zt, ap, mp, D,overlap,epsilon,O1,O2)
%    LP-SR
%    Input:
%    M1 - input image A
%    M2 - input image B
%    zt - maximum decomposition level
%    ap - coefficient selection highpass (see selc.m) 
%    mp - coefficient selection base image (see selb.m) 
%    D  - Dictionary for sparse representation
%    overlap - the overlapped pixels between two neighbor patches
%    epsilon - sparse reconstuction error
%    Output:
%    Y  - fused image   
%
%    The code is edited by Yu Liu, 01-09-2014.
%    Update: fusion of original images using the data from M1 and M2
%    Update: O1 - original image A; O2 - original image B


% whos
% check inputs 
[z1 s1] = size(M1);
[z2 s2] = size(M2);
% M1=double(M1);
% M2=double(M2);
if (z1 ~= z2) | (s1 ~= s2)
  error('Input images are not of same size');
end;

% define filter 
w  = [1 4 6 4 1] / 16;

% cells for selected images
E = cell(1,zt);
% Update-start:
EO = cell(1,zt);
% Update-end:
% tic
% loop over decomposition depth -> analysis
for i1 = 1:zt 
    tic
  % calculate and store actual image size 
  [z s]  = size(M1); 
  zl(i1) = z; sl(i1)  = s;
  
  % check if image expansion necessary 
  if (floor(z/2) ~= z/2), ew(1) = 1; else, ew(1) = 0; end;
  if (floor(s/2) ~= s/2), ew(2) = 1; else, ew(2) = 0; end;

  % perform expansion if necessary
  if (any(ew))
  	M1 = adb(M1,ew);
  	M2 = adb(M2,ew);
    
    % Update-start:
    nsize = size(M1);
    tmp1 = zeros(nsize(1),nsize(2),3);
    tmp2 = tmp1;
    for cf = 1:3
        tmp1(:,:,cf) = adb(O1(:,:,cf),ew);
        tmp2(:,:,cf) = adb(O2(:,:,cf),ew);
    end
    O1 = tmp1;
    O2 = tmp2;
    % Update-end:
  end;	

  % perform filtering 
  G1 = conv2(conv2(es2(M1,2), w, 'valid'),w', 'valid');
  G2 = conv2(conv2(es2(M2,2), w, 'valid'),w', 'valid');
  % Update-start:
  nsize = size(G1);
  tmp1 = zeros(nsize(1),nsize(2),3);
  tmp2 = tmp1;
  for cf = 1:3
      tmp1(:,:,cf) = conv2(conv2(es2(O1(:,:,cf),2), w, 'valid'),w', 'valid');
      tmp2(:,:,cf) = conv2(conv2(es2(O2(:,:,cf),2), w, 'valid'),w', 'valid');
  end
  GO1 = tmp1;
  GO2 = tmp2;
  % Update-end:
  
  % decimate, undecimate and interpolate 
  M1T = conv2(conv2(es2(undec2(dec2(G1)), 2), 2*w, 'valid'),2*w', 'valid');
  M2T = conv2(conv2(es2(undec2(dec2(G2)), 2), 2*w, 'valid'),2*w', 'valid');
  % Update-start:
  nsize = size(M1T);
  tmp1 = zeros(nsize(1),nsize(2),3);
  tmp2 = tmp1;
  for cf = 1:3
      tmp1(:,:,cf) = conv2(conv2(es2(undec2(dec2(GO1(:,:,cf))), 2), 2*w, 'valid'),2*w', 'valid');
      tmp2(:,:,cf) = conv2(conv2(es2(undec2(dec2(GO2(:,:,cf))), 2), 2*w, 'valid'),2*w', 'valid');
  end
  O1T = tmp1;
  O2T = tmp2;
  % Update-end:
%   toc76

% tic
  % select coefficients and store them
  % Update-start:
  [tmp1,tmp2] = selc2(M1-M1T, M2-M2T, ap,O1-O1T, O2-O2T);
%   E(i1) = {selc(M1-M1T, M2-M2T, ap)};
  E(i1) = {tmp1};
  EO(i1) = {tmp2};
  % Update-end:
% toc
  % decimate 
%  tic
  M1 = dec2(G1);
  M2 = dec2(G2);
  % Update-start:
  nsize = size(M1);
  tmp1 = zeros(nsize(1),nsize(2),3);
  tmp2 = tmp1;
  for cf = 1:3
      tmp1(:,:,cf) = dec2(GO1(:,:,cf));
      tmp2(:,:,cf) = dec2(GO2(:,:,cf));
  end
  O1 = tmp1;
  O2 = tmp2;
  % Update-end:
%   toc
% toc
% feature ('memstats')

end;
% toc
% select base coefficients of last decompostion stage
% tic
%M1 = selb(M1,M2,mp);
% Update-start:
% M1=sparse_fusion(M1,M2,D,overlap,epsilon);
[M1,O1]=sparse_fusion2(M1,M2,D,overlap,epsilon,O1,O2);
% Update-end:
%size(M1)
% toc
% whos
% feature ('memstats')
% toc
% loop over decomposition depth -> synthesis
% tic
for i1 = zt:-1:1
  % undecimate and interpolate 
%   tic
  M1T = conv2(conv2(es2(undec2(M1), 2), 2*w, 'valid'), 2*w', 'valid');
  % add coefficients
  M1  = M1T + E{i1};
%   toc
  % select valid image region 
  M1 	= M1(1:zl(i1),1:sl(i1));
%   feature ('memstats')
% whos
  % Update-start: 
  % undecimate and interpolate 
  nsize = size(M1T);
  tmp1 = zeros(nsize(1),nsize(2),3);
  for cf = 1:3
    tmp1(:,:,cf) = conv2(conv2(es2(undec2(O1(:,:,cf)), 2), 2*w, 'valid'), 2*w', 'valid');
  end
  O1T = tmp1;
  % add coefficients
  O1  = O1T + EO{i1};
  % select valid image region 
  O1 	= O1(1:zl(i1),1:sl(i1),:);
  % Update-end:
end;

% feature ('memstats')
% copy image
Y = M1;
% Update-start: 
YO = O1;
% Update-end: 
% toc
