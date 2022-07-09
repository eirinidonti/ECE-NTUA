clc;
clear all;
close all;

# Exercise 3
#A Task
X = 100;             #100 successively randomly 
y = ones(X,1);       #100 by 1 array of ones.
r = exprnd(0.2,1,X); #Generate a random 1 by 100 array of exponential 
                     #distribution with mean LAMBDA = 1/lambda = 0.2 sec.
for i = 1:(X-1)
  r(i+1) = r(i+1) + r(i);
  y(i+1) = y(i+1) + y(i);
endfor
figure(1);
stairs(r,y,color='r'); # the inputs r must be a row vector and y must a matrix
                       # with length(r) rows 
hold on;
xlim("auto")           # set x axis limits automatically
title("Counting Process Poisson With Parameter Lambda = 5 events/sec");
xlabel("sec");
ylabel("N(t)");
    
#B Task
#(0) 100 events
l = 100/r(100);
fprintf('approximation of lambda (100 events) = '); l  
      
#(i) 200 events
X = 200;             #200 successively randomly 
y = ones(X,1);       #200 by 1 array of ones.
r = exprnd(0.2,1,X); #Generate a random 1 by 200 array of exponential 
                     #distribution with mean LAMBDA = 1/lambda = 0.2 sec.
for i = 1:(X-1)
  r(i+1) = r(i+1) + r(i);
  y(i+1) = y(i+1) + y(i);
endfor
figure(2);
stairs(r,y,color='r'); # the inputs r must be a row vector and y must a matrix
                       # with length(r) rows 
hold on;
xlim("auto")           # set x axis limits automatically
title("Counting Process Poisson With Parameter Lambda = 5 events/sec");
xlabel("200 events (sec)");
ylabel("N(t)");
hold on;
l = 200/r(200);
fprintf('approximation of lambda (200 events) = '); l 

#(ii) 300 events
X = 300;             #300 successively randomly 
y = ones(X,1);       #300 by 1 array of ones.
r = exprnd(0.2,1,X); #Generate a random 1 by 300 array of exponential 
                     #distribution with mean LAMBDA = 1/lambda = 0.2 sec.
for i = 1:(X-1)
  r(i+1) = r(i+1) + r(i);
  y(i+1) = y(i+1) + y(i);
endfor
figure(3);
stairs(r,y,color='r'); # the inputs r must be a row vector and y must a matrix
                       # with length(r) rows 
hold on;
xlim("auto")           # set x axis limits automatically
title("Counting Process Poisson With Parameter Lambda = 5 events/sec");
xlabel("300 events (sec)");
ylabel("N(t)");
hold on;
l = 300/r(300);
fprintf('approximation of lambda (300 events) = '); l

#(iii) 500 events
X = 500;             #500 successively randomly 
y = ones(X,1);       #500 by 1 array of ones.
r = exprnd(0.2,1,X); #Generate a random 1 by 500 array of exponential 
                     #distribution with mean LAMBDA = 1/lambda = 0.2 sec.
for i = 1:(X-1)
  r(i+1) = r(i+1) + r(i);
  y(i+1) = y(i+1) + y(i);
endfor
figure(4);
stairs(r,y,color='r'); # the inputs r must be a row vector and y must a matrix
                       # with length(r) rows 
hold on;
xlim("auto")           # set x axis limits automatically
title("Counting Process Poisson With Parameter Lambda = 5 events/sec");
xlabel("500 events (sec)");
ylabel("N(t)");
hold on;
l = 500/r(500);
fprintf('approximation of lambda (500 events) = '); l

#(iv) 1000 events
X = 1000;            #1000 successively randomly 
y = ones(X,1);       #1000 by 1 array of ones.
r = exprnd(0.2,1,X); #Generate a random 1 by 1000 array of exponential 
                     #distribution with mean LAMBDA = 1/lambda = 0.2 sec.
for i = 1:(X-1)
  r(i+1) = r(i+1) + r(i);
  y(i+1) = y(i+1) + y(i);
endfor
figure(5);
stairs(r,y,color='r'); # the inputs r must be a row vector and y must a matrix
                       # with length(r) rows 
hold on;
xlim("auto")           # set x axis limits automatically
title("Counting Process Poisson With Parameter Lambda = 5 events/sec");
xlabel("1000 events (sec)");
ylabel("N(t)");
hold on;
l = 1000/r(1000);
fprintf('approximation of lambda (1000 events) = '); l

#(v) 10000 events
X = 10000;           #10000 successively randomly 
y = ones(X,1);       #10000 by 1 array of ones.
r = exprnd(0.2,1,X); #Generate a random 1 by 10000 array of exponential 
                     #distribution with mean LAMBDA = 1/lambda = 0.2 sec.
for i = 1:(X-1)
  r(i+1) = r(i+1) + r(i);
  y(i+1) = y(i+1) + y(i);
endfor
figure(6);
stairs(r,y,color='r'); # the inputs r must be a row vector and y must a matrix
                       # with length(r) rows 
hold on;
xlim("auto")           # set x axis limits automatically
title("Counting Process Poisson With Parameter Lambda = 5 events/sec");
xlabel("10000 events (sec)");
ylabel("N(t)");
hold on;
l = 10000/r(10000);
fprintf('approximation of lambda (10000 events) = '); l

