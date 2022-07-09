% Eirini Donti 

% (i)
% Implementation of erlang_factorial(ñ,c) ñ = ë/ì and c = number of servers
 
 function fun = erlangb_factorial(r,c)
   sum=0;
   for k = 0:1:c
     sum = sum + (power(r,k)/factorial(k));
   endfor
    fun = (power(r,c)/factorial(c)/sum); 
 endfunction
 
