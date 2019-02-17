
pkg load image;
fprintf('Created By : Himanshu Garg \n')
fprintf('UB ID: 50292195 \n \n')
fprintf('ALIGNMENTS \n \n')

for i = 1:6

  path = strcat("image",int2str(i),".jpg");
  I = imread(path);
  s = size(I);
  
  %code for getting a colored image from r,g,b channels
  slice = int32(s/3);
  b = I(1:slice,:);
  g = I(slice+1:2*slice,:);
  r = I(2*slice+1:end-1,:);
  fI = cat(3,r,g,b);  
  imwrite(fI,strcat("image",int2str(i),"-color.jpg"),"jpg");
  
  %code for aligning the r,g,b channels using ssd
  sample = 5;
  offset = 0;
  win_size = 15;
  al1 = im_align1(b,r,sample,win_size);
  fprintf('****************************** \n \n')
  fprintf(path);
  fprintf('\n\nAlignment of red with blue using SSD   : [%d %d] \n',fliplr(al1));   
  al2 = im_align1(b,g,sample,win_size);
  fprintf('Alignment of green with blue using SSD : [%d %d] \n',fliplr(al2)); 
  r_al = circshift(r,[al1(1) al1(2)]);
  g_al = circshift(g,[al2(1) al2(2)]);
  fIssd = cat(3,r_al,g_al,b);

  figure
  imshow(fIssd);
  title(strcat("image",int2str(i),"-ssd.jpg"));
  imwrite(fIssd,strcat("image",int2str(i),"-ssd.jpg"),"jpg");
  
  %code for aligning the r,g,b channels using ncc
  sample = 5;
  offset = 0;
  [al1 val1] = im_align2(b,r,sample,offset);
  fprintf('Alignment of red with blue using NCC   : [%d %d] \n',fliplr(al1));   
  [al2 val2] = im_align2(b,g,sample,offset);
  fprintf('Alignment of green with blue using NCC : [%d %d] \n',fliplr(al2));   
  r_al = circshift(r,[al1(1) al1(2)]);
  g_al = circshift(g,[al2(1) al2(2)]);
  fINcc = cat(3,r_al,g_al,b);
   
  figure
  imshow(fINcc);
  title(strcat("image",int2str(i),"-ncc.jpg"));
  imwrite(fINcc,strcat("image",int2str(i),"-ncc.jpg"),"jpg");
  
  %code for aligning the r,g,b channels using Harris and RANSAC
  s = size(b);
  n = 0.05;
  numF = 50;
  str = int32(s(1)*n);
  stc = int32(s(2)*n);
  rt = r(str:s(1)-str,stc:s(2)-stc);
  bt = b(str:s(1)-str,stc:s(2)-stc);
  gt = g(str:s(1)-str,stc:s(2)-stc);

  features_r = harris(rt,numF);  %features in [row col] format
  features_r = [features_r(:,1)+str features_r(:,2)+stc];
  features_b = harris(bt,numF);  %features in [row col] format
  features_b = [features_b(:,1)+str features_b(:,2)+stc];
  features_g = harris(gt,numF);  %features in [row col] format  
  features_g = [features_g(:,1)+str features_g(:,2)+stc];
 
  al1 = im_align3(r,features_r,b,features_b);
  fprintf('Alignment of red with blue using Harris   : [%d %d] \n',fliplr(al1));   
  al2 = im_align3(g,features_g,b,features_b);  
  fprintf('Alignment of green with blue using Harris   : [%d %d] \n \n',fliplr(al2));   
  r_al = circshift(r,[al1(1) al1(2)]);
  g_al = circshift(g,[al2(1) al2(2)]);
  fIHarris = cat(3,r_al,g_al,b);
  figure
  imshow(fIHarris);
  title(strcat("image",int2str(i),"-corner.jpg"));
  imwrite(fIHarris,strcat("image",int2str(i),"-corner.jpg"),"jpg");
end



