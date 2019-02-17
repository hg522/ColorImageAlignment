function alignment = im_align1( i1,i2,N,win_size)
 
  b = im2double(i1);
  r = im2double(i2);
  s = size(b);
  n = N;
  str = int32(s(1)/n);
  stc = int32(s(2)/n);
  st = floor(n/2);
  ed = st + 1;
  sub_r = edge(r(st*str:ed*str,st*stc:ed*stc),'canny');
  sub_b = edge(b(st*str:ed*str,st*stc:ed*stc),'canny');
  ssdMat = [];
    
  for i=-win_size:win_size
    temp = [];
    for j=-win_size:win_size
      sub_r_cir = sub_r;
      sub_r_cir = circshift(sub_r_cir,[i j]);
      ssd = sum(sum((sub_b-sub_r_cir).^2));
      temp = [temp ssd];
    end
    ssdMat = [ssdMat;temp];
  end  
  
  minssd = min(ssdMat(:));
 [x y] = find(ssdMat == minssd);
  xoffset = x - win_size;
  yoffset = y - win_size;
  alignment = [xoffset yoffset];
      
  
  
  
 
	