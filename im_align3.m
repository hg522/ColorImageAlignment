function alignment = im_align3(iTemp,fTemp,iRef,fRef)
 
 alignment = [];
 iT = iTemp; 
 iR = iRef; 
 s = size(I);
 fShift = [0 0];
 maxCount = 0;
 k = 300;
 
 for l = 1:k
   iTf = fTemp;
   iRf = fRef;
   idx_temp=randperm(length(fTemp(:,1)),1);
   idx_ref=randperm(length(fRef(:,1)),1);
   count = 0;
   temp_pt = [fTemp(idx_temp,1) fTemp(idx_temp,2)];
   ref_pt = [fRef(idx_ref,1) fRef(idx_ref,2)];
   
   shift = ref_pt - temp_pt;
   iTf = [iTf(:,1)+shift(1) iTf(:,2)+shift(2)];  
   win = 1; 
   for i = 1:size(iTf)(1)
     fpt = [iTf(i,1) iTf(i,2)];
     for j = 1:size(fRef)(1)
       rpt = [fRef(j,1) fRef(j,2)];
       dist = rpt - fpt;
       if dist(1) <= win && dist(1) >= -win && dist(2) <= win && dist(2) >= -win
         count+=1;
        break;
       end
     end
   end
   if count > maxCount
     fShift = shift;
     maxCount = count;
   end
 end
 
 
 alignment = abs([fShift(1) fShift(2)]);

 