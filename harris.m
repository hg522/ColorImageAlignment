function features = harris(img,numF)
 
 I = img;
 s = size(I);
 sx = [-1 0 1;-1 0 1;-1 0 1] * (1/8);
 sy = [1 1 1;0 0 0;-1 -1 -1] * (1/8);
 k = 0.06;
 #th = 0.002;
 border_th = 20;
 gauss = fspecial('gaussian',[3 3],1);
 I = conv2(I,gauss,'same');
 features = [];
 Ix = conv2(I,sx,'same');
 Iy = conv2(I,sy,'same'); 
 Ix2 = Ix .^ 2;
 Ix2 = conv2(Ix2,gauss,'same');
 Iy2 = Iy .^ 2; 
 Iy2 = conv2(Iy2,gauss,'same');
 Ixy = Ix .* Iy; 
 Ixy = conv2(Ixy,gauss,'same');
 Det = (Ix2 .* Iy2) - (Ixy .^ 2);
 trace = (Ix2 + Iy2); 
 R = Det - k*((trace) .^ 2);
 R_Harris = R;
 max_sort = sort(R_Harris(:));
 
 R_max = max(max(R_Harris));
 #thresold = th * R_max;
 mx_mat = ordfilt2(R_Harris, 9, ones(3));
 #R_Harris = (R_Harris == mx_mat) & (R_Harris > thresh); 
 R_l = (R_Harris == mx_mat);
 vals = R_Harris(R_l);
 [row,col] = find(R_l);
 mapmat = [vals row col];
 mapmat = sortrows(mapmat,1);
 if size(mapmat)(1) > numF
  mapmat = mapmat(end-numF:end,:); 
 end 
 corner = [mapmat(:,2) mapmat(:,3)];
 #corner = [row col]; 
 [rem_r1 col]= find(corner < border_th);
 rem_r1 = unique(rem_r1);
 corner(rem_r1,:) = [];
 [rem_r2 col]= find(corner(:,1) > size(I)(1)-border_th);
 rem_r2 = unique(rem_r2);
 corner(rem_r2,:) = [];
 [rem_r3 col]= find(corner(:,2) > size(I)(2)-border_th);
 corner(rem_r3,:) = [];
 rem_r3 = unique(rem_r3);
 
 features = [corner(:,1) corner(:,2)];

 