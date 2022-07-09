# C Task

clc;
clear all;
close all;

#(i)
lambda = 5; # ë = 5
mu = 10;    # ì = 10
arrivals_lambda_i = [lambda/1, lambda/2, lambda/3, lambda/4];
departure_mu_i = [mu, mu, mu, mu];
printf("(i)\n");
transition_rhythm_matrix = ctmcbd(arrivals_lambda_i,departure_mu_i)

#(ii)
Pr = ctmc(transition_rhythm_matrix);#Compute stationary or transient 
#state occupancy probabilities for a continuous-time Markov chain
printf("(ii)\n");
printf("Pr(i) =\n")
for i = 1:5
   Pr(i)
endfor
#(iii)
mean_number_of_clients = 0;

for i = 1:1:5
  mean_number_of_clients = mean_number_of_clients + Pr(i)*(i-1);
endfor
printf("(iii)\n");
printf("Mean number of clients in system = "); mean_number_of_clients
#(iv)
printf("(iv)\n");
printf("Blocking Probability = "); Pr(5)
#(v)
for i = 1:1:5
  cnt =0;
  for k = 0:0.01:50
    cnt = cnt + 1;
    Prob = ctmc(transition_rhythm_matrix, k, [1, 0, 0, 0, 0]);
    Probability(cnt) = Prob(i);
    if Prob - Pr < 0.01
      break;
    endif
  endfor
  t = 0:0.01:k;
  figure;
  plot(t, Probability, "linewidth",1.4);
  xlim([0 0.432]);
  xlabel("Time");
  ylabel("Probability");
  legend("(v)");
endfor
