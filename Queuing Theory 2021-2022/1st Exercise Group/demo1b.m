clc;
clear all;
close all;
# Exercise 2
#Á Task
k = 0:0.0001:8;
lambda = [0.5, 1, 3];

for i = 1 : columns(lambda)
  exp(i, :) = exppdf(k, lambda(i)); #Probability Density Function - Exponential
endfor

colors = "rbkm";
figure(1);
hold on;
for i = 1 : columns(lambda)
  plot(k, exp(i, :), colors(i), "linewidth", 1.2);
endfor
hold off;

title("Probability Density Function of Exponential processes");
xlabel("k values");
ylabel("probability");
legend("1/lambda=0.5", "1/lambda=1", "1/lambda=3");

#B Task

# same k, lambda
for i = 1 : columns(lambda)           #Same as before
  exp(i, :) = expcdf(k,lambda(i)); #Cumulative Distribution Function - Exponential
endfor

colors="rbkm";
figure(2);
hold on;
for i = 1 : columns(lambda)
  plot(k,exp(i, :), colors(i), "linewidth", 1.2);
endfor
hold off;

title("Probability Cumulative Function of Exponential processes");
xlabel("k values");
ylabel("probability");
legend("1/lambda=0.5","1/lambda=1","1/lambda=3");

#C Task

# k same  with lambda = 2.5 sec
F = expcdf (k,2.5);
p1=1 - F(30000); # 1 - P(X <= 30000)
fprintf('P(X>30000)= '); p1 # print the probability P(X>30000)
p2=(1-F(50000))./(1-F(20000)); # (1-P(X<=50000))/(1-P(X<=20000))
fprintf('P(X>50000|X>20000)= '); p2 # print the probability P(X>50000|X>20000)
