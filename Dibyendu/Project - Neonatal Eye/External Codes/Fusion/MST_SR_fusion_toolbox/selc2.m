function [Y,YO] = selc2(M1, M2, ap, O1, O2)
%Y = selc(M1, M2, ap) coefficinet selection for highpass components 
%
%    M1  - coefficients A
%    M2  - coefficients B
%    mp  - switch for selection type
%          mp == 1: choose max(abs)
%          mp == 2: salience / match measure with threshold == .75 (as proposed by Burt et al)
%          mp == 3: choose max with consistency check (as proposed by Li et al)
%          mp == 4: simple choose max
%
%    Y   - combined coefficients

%    (Oliver Rockinger 16.08.99)
%    Update: fusion of original images using the data from M1 and M2
%    Update: O1 - original image A; O2 - original image B

% check inputs 
[z1 s1] = size(M1);
[z2 s2] = size(M2);
if (z1 ~= z2) | (s1 ~= s2)
  error('Input images are not of same size');
end;

% switch to method
switch(ap(1))
 	case 1, 
 		% choose max(abs)
 		mm = (abs(M1)) > (abs(M2));
  	Y  = (mm.*M1) + ((~mm).*M2);
    % Update-start:
    YO  = (repmat(mm,[1,1,3]).*O1) + (repmat((~mm),[1,1,3]).*O2);
    % Update-end:
    
 	case 2,
  	% Burts method 
  	um = 3; th = .75;
  	% compute salience 
  	S1 = conv2(es2(M1.*M1, floor(um/2)), ones(um), 'valid'); 
  	S2 = conv2(es2(M2.*M2, floor(um/2)), ones(um), 'valid'); 
  	% compute match 
  	MA = conv2(es2(M1.*M2, floor(um/2)), ones(um), 'valid');
  	MA = 2 * MA ./ (S1 + S2 + eps);
  	% selection 
    m1 = MA > th; m2 = S1 > S2; 
    w1 = (0.5 - 0.5*(1-MA) / (1-th));
    Y  = (~m1) .* ((m2.*M1) + ((~m2).*M2));
    Y  = Y + (m1 .* ((m2.*M1.*(1-w1))+((m2).*M2.*w1) + ((~m2).*M2.*(1-w1))+((~m2).*M1.*w1)));
  	% Update-start:
    YO  = repmat((~m1),[1,1,3]) .* ((repmat(m2,[1,1,3]).*O1) + (repmat((~m2),[1,1,3]).*O2));
    YO  = YO + (repmat((~m1),[1,1,3]) .* ((repmat(m2,[1,1,3]).*O1.*(1-repmat(w1,[1,1,3])))+((repmat(m2,[1,1,3])).*O2.*repmat(w1,[1,1,3])) + (repmat((~m2),[1,1,3]).*O2.*(1-repmat(w1,[1,1,3])))+(repmat((~m2),[1,1,3]).*O1.*repmat(w1,[1,1,3]))));
    % Update-end:
    
  case 3,	       
  	% Lis method 
  	um = 3;
    % first step
  	A1 = ordfilt2(abs(es2(M1, floor(um/2))), um*um, ones(um));
  	A2 = ordfilt2(abs(es2(M2, floor(um/2))), um*um, ones(um));
    % second step
  	mm = (conv2(double((A1 > A2)), ones(um), 'valid')) > floor(um*um/2);
  	Y  = (mm.*M1) + ((~mm).*M2);
    % Update-start:
    YO  = (repmat(mm,[1,1,3]).*O1) + (repmat((~mm),[1,1,3]).*O2);
    % Update-end:
 
  case 4, 
  	% simple choose max 
  	mm = M1 > M2;
  	Y  = (mm.*M1) + ((~mm).*M2);
    % Update-start:
    YO  = (repmat(mm,[1,1,3]).*O1) + (repmat((~mm),[1,1,3]).*O2);
    % Update-end:
  
  otherwise,
  	error('unkown option');
end;  
 



