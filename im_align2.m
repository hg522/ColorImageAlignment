function [alignment max_corrMap] = im_align2( i1,i2,N,off )
 
  b = i1;
  r = i2;
  s = size(b);
  n = N;
  str = int32(s(1)/n);
  stc = int32(s(2)/n);
  st = floor(n/2);
  ed = st + 1;
  sub_r = edge(r(st*str:ed*str,st*stc:ed*stc),'canny');
  sub_b = edge(b(st*str:ed*str,st*stc:ed*stc),'canny');
  corrMap = normxcorr2(sub_r,sub_b);
  [max_corrMap, ind_max] = max(abs(corrMap(:)));
  [y_peak,x_peak] = ind2sub(size(corrMap),ind_max(1));
  offset = [(x_peak-size(sub_r,2)) (y_peak-size(sub_r,1))];
  xoffset = offset(1);
  yoffset = offset(2);
  alignment = [yoffset xoffset];
  
  
 
	