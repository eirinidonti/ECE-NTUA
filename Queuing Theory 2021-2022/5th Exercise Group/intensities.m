% Exercise 2 - Eirini Donti 

function [r1,r2,r3,r4,r5,ret] = intensities(la1,la2,mu1,mu2,mu3,mu4,mu5)
  r1=(la1/mu1);
  r2=((la2+(2/7)*la1)/mu2);
  r3=((4/7)*la1/mu3);
  r4=((3/7)*la1/mu4);
  r5=(((4/7)*la1+la2)/mu5); 
  if((r1<1)&&(r2<1)&&(r3<1)&&(r4<1)&&(r5<1))
     ret=1;
  else
     ret=0;
  endif
    r1
    fprintf("\n");
    r2
    fprintf("\n");
    r3
    fprintf("\n");
    r4
    fprintf("\n");
    r5 
endfunction

