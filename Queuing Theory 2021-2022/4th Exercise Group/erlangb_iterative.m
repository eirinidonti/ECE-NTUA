clear all;
close all;
clc;

 % (ii)
 % Implementation of erlang_iterative(ñ,c) ñ = ë/ì and c = number of servers
 function fun = erlangb_iterative(r,c)
   fun = 1;
   for i = 0:1:c
     fun = ((r*fun)/((r*fun)+i));
   endfor
 endfunction
 
 % (b)
 
 Pr = zeros(0,200); % Run Selection
 for i = 1:1:200
   Pr(i) = erlangb_iterative(i*(23/60),i)
 endfor
figure;
stem(Pr,'r',"linewidth",0.5);
title("Blocking Probabilities");
xlabel("number of servers");
ylabel("blocking probability");