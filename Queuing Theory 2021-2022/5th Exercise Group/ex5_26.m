% EXERCISE 2 (6) - Eirini Donti
la1_max = 6;
for i = 1:1:90
  la1 = (0.1*la1_max) + (i-1)*0.01*la1_max;
  [Q1, Q2, Q3, Q4, Q5] = mean_clients(la1, la2=1, mu1=6, mu2=5, mu3=8, mu4=7, mu5=6);
  E(i) = (Q1 + Q2 + Q3 + Q4 + Q5)/(la1 + la2);
endfor

la1 = (0.1*la1_max):(0.01*la1_max):(0.99*la1_max);
figure;
plot(la1, E, "r");
title("E(T) Diagram")
xlabel("Lambda 1");
ylabel("E(T)");

