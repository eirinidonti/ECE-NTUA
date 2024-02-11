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
for i=1:2*t %εκθέτη 1 ως 2*t
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