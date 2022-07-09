clc;
clear all;
close all;

# B Task

#(â)
lambda = 5 # clients/sec
mu = 5.0001:0.0001:10;
[U, R, Q, X] = qsmm1(lambda,mu);

# First Diagram
#subplot(4,1,1);
figure(1);
plot(mu,U, "b");
title("Server Utilization - Service Rate Diagram");
xlabel("Service Rate MU");        #Service rate MU or ì
ylabel("Server Utilization U");   #utilization rate U or ñ

# Second Diagram
#subplot(4,1,2)
figure(2);
plot(mu,R, "b");
axis([5 10 0 200]);
title("Server Response Time - Service Rate Diagram");
xlabel("Service Rate MU");        #Service rate MU or ì
ylabel("Server Response Time R"); #Server Response Time R or E[T]

# Third Diagram
#subplot(4,1,3)
figure(3);
plot(mu,Q, "b");
axis([5 10 0 200]);
title("Average number of requests in the system - Service Rate Diagram");
xlabel("Service Rate MU");        # Service rate MU or ì
ylabel("Average number of requests in the system Q"); 
                                  #Average number of requests
                                  #in the system Q or E[n(t)]
# Fourth Diagram
#subplot(4,1,4)
figure(4);
plot(mu,X, "b");
axis([5 10 0 10]);
title("Server throughput - Service Rate Diagram");
xlabel("Service Rate MU");        #Service rate MU or ì
ylabel("Server throughput X"); #Server throughput X or ã
# the system is ergodic, so we always have X = lambda  