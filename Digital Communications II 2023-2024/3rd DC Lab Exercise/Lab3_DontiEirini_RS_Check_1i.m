%R-S encoding
clear all;
close all;
clc;
n=31; %Αρχικοποιούμε τα χαρακτηριστικά του κώδικα
t=3;
m=log2(n+1);
k=n-2*t;

%%%finding generator polynomial%%%
gen_x=gf([1],m); %παρακάτω βρίσκουμε το γενετήριο πολυώνυμο του κώδικα
a=gf(2,m);
for i=1:2*t
p=gf([1,a^i],m);
gen_x=conv(gen_x,p); %(x+a)(x+a^2)(x+a^3)....
end
mes = randi([0 1],1,k*m); %μήνυμα μήκους 125 bits
gfelem=[]; %θα μετατρέψουμε τα bits του μηνύματος σε στοιχεία του αντίστοιχου σώματος
for i=1:m:k*m
    elem=0;
    for j = 0:m-1
        elem=elem+mes(i+j)*2^(m-1-j);
    end
    gfelem = [gfelem, gf(elem, m)];
end
gfelem=flip(gfelem);
np=gf([1,zeros(1,2*t)],m);
np=conv(np,gfelem);
[q, b] = deconv(np,gen_x);
u_x = np + b; % το κωδικοποιημένο μήνυμα
disp(u_x); %το κωδικοποιημένο μήνυμα
disp('G(x) = ');
disp(gen_x); %δεκαδική αναπαράσταση του γενετήριου πολυωνύμου
disp(log(gen_x)); %αναπαράσταση του γενετήριου πολυωνύμου με εκθέτες του Β
disp(mes);
disp(u_x); %δεκαδική αναπαράσταση του κωδικού πολυωνύμου
for i=1:length(u_x) %αναπαράσταση του κωδικού πολυωνύμου με εκθέτες του α
  if u_x(i)==0
    fprintf('0*x^%d',n-i);
  else 
    fprintf('a^%d*x^%d',log(u_x(i)),n-i);
  end
  if rem(i, 9)==0 && i<n %προσαρμογή στο command window του MATLAB
      fprintf('+\n+');
  elseif i<n
    fprintf('+')
  else
    fprintf('\n');
  end
end