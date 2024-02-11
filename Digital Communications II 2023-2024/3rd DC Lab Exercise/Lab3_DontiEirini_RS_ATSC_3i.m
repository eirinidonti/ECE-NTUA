%%RS_encoding_ATSC
clear all;
close all;
clc;
%Αρχικοποιούμε τα χαρακτηριστικά του κώδικα
m=8;
k=187;
t=10;
n=k+2*t;
%%%finding generator polynomial%%%
d=primpoly(8);
gen_x=gf([1],m,d); %παρακάτω βρίσκουμε το γενετήριο πολυώνυμο του κώδικα
a=gf(2,m,d);
for i=0:2*t-1
    p=gf([1,a^i],m,d);
gen_x=conv(gen_x,p);%(x+1)(x+a)(x+a^2)(x+a^3)...(x+a^(2*t-1))
end
gen_x
for i=1:2*t+1
    fprintf('a^{%d}*x^{%d}',log(gen_x(i)),2*t+1-i);
    if i<2*t+1
        fprintf(' + ');
    else
        fprintf('\n');
    end
end
mes=randi([0 1],1,k*m); %μήνυμα
mes=zeros(1,k*m);
gfelem=[]; %θα μετατρέψουμε τα bits του μηνύματος σε στοιχεία του αντίστοιχου σώματος
for i=1:m:k*m %μπορεί να γίνει και με χρήση της bi2de
    elem=0;
    for j=0:m-1
        elem=elem+mes(i+j)*2^(m-1-j);
    end
    gfelem=[gfelem, gf(elem,m)];
end
gfelem=flip(gfelem);
np=gf([1,zeros(1,2*t)],m);
np=conv(np,gfelem);
[q,b]=deconv(np,gen_x);
u_x=np+b;%το κωδικοποιημένο μήνυμα 
disp(u_x); %το κωδικοποιημένο μήνυμα 
disp(gen_x); %δεκαδική αναπαράσταση του γενετήριου πολυωνύμου
disp(log(gen_x)); %αναπαράσταση του γενετήριου πολυωνύμου με εκθέτες του a
disp(mes);
disp(u_x); %δεκαδική αναπαράσταση του κωδικού πολυωνύμου 
for i=1:length(u_x)     %αναπαράσταση του κωδικού πολυωνύμου με εκθέτες του a
    if u_x(i)==0
        fprintf('0*x^%d',n-i);
    else
        fprintf('a^%d*x^%d',log(u_x(i)),n-i);
    end
    if rem(i,9)==0 && i<n
            fprintf(' +  \n + ');
    elseif i<n
        fprintf(' + ');
    
    else
        fprintf('\n');
    end
end
