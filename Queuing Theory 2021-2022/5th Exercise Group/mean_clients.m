function [Q1,Q2,Q3,Q4,Q5] = mean_clients(la1,la2,mu1,mu2,mu3,mu4,mu5)
  [r1,r2,r3,r4,r5,ret] = intensities(la1,la2,mu1,mu2,mu3,mu4,mu5);
    Q1 = r1/(1-r1);
    Q2 = r2/(1-r2);
    Q3 = r3/(1-r3);
    Q4 = r4/(1-r4);
    Q5 = r5/(1-r5);
    d = [Q1, Q2, Q3, Q4, Q5]
   % fprintf("E(T) = ");
   % display((Q1+Q2+Q3+Q4+Q5)/(la1+la2));
endfunction
