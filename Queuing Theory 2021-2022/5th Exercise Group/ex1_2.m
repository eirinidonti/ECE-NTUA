%Exercise 1 - Eirini Donti

% (a)
a = 0.001:0.001:0.999;
l=10000;
l1=10000*a;
mu1=14650;
l2=10000*(1-a);
mu2=11720;

[U1,R1,Q1,X1,P1] = qsmm1(l1,mu1);
[U2,R2,Q2,X2,P2] = qsmm1(l2,mu2);

totClients = Q1 + Q2;
totTime = totClients/l;
figure;
plot(a,totTime);
xlabel("a parameter");
ylabel("Average response time");

[min_value,min_a] = min(min(totTime,[],1));
fprintf("Minimun value of E(T)\n");
min_value
fprintf("for a = ");
display(0.001*(min_a+1));

