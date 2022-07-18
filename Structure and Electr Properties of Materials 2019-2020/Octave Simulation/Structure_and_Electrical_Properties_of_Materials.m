# Eirini Dontis

# Exercise 2.1 - Calculate Energy Gap of Si & GaAs
i = 139;
T = 0:10:1000;
t = 100 + i;
a = 1.17;
b = (4.73*10^(-4)).*T.^2;
c = T.+636;
eg1 = a.-b./c;
k = 1.52;
l = (5.4*10^(-4).*T.^2);
m = T.+204;
eg2 = k.-l./m;
plot(T,eg1,'m',T,eg2,'r');
hold on
y = 0.8:0.01:1.6;
plot(t,y,'.');
hold on
xlabel('T(K)');
ylabel('Eg(eV)');
title('Eg(Si - GaAs)');


T = 100 + i; # Calculate Energy Gap of Si & GaAs with T = 100 + i
b = (4.73*10^(-4)).*T.^2;
c = T.+636;
l = (5.4*10^(-4).*T.^2);
m = T.+204;
fprintf("The Energy Gap of Si is:\n");
eg1 = a.-b./c;
disp(eg1);
fprintf("The Energy Gap of GaAs is:\n");
eg2 = k.-l./m;
disp(eg2);

# Exercise 2.2 - Fermi Diagram
energeia = 0.3:0.00005:0.8;
ef = 0.55;
k = 8.6*10^(-5);
i = 139;
T = 100 + i;
De = energeia - ef;
expon = De./(k*T);
a = e.^expon;
b = a.+1;
fe = 1./b;
figure;
plot(energeia,fe);
hold on
xlabel('E - Ef(eV)');
ylabel('F(E)');
title('F(E)');

# Exercise 2.3 - Carrier Density
# Carrier Density of Ge
i = 139;
t = 100 + i;
k = 8.6*10^(-5);
e = 2.7;
nc = 1.02*10^19;
Nc = nc*((t/300)^(3/2));
eg = 0.65;
ef = 0.32;
ec = ef + 0.5*eg;
b = (ec - ef)/(k*t);
n = nc*e^(-b);
fprintf("Ge: n = \n")
disp(n);
nv = 5.64*10^18;
Nv = nv*((t/300)^(3/2));
nvnc = log(nv/nc);
ev = 2*ef - ec - k*t*nvnc;
d = (ef - ev)/(k*t);
p = nv*e^(-d);
fprintf("Ge: p = \n")
disp(p);

# Carrier Density of Si
i = 139;
t = 100 + i;
k = 8.6*10^(-5);
e = 2.7;
nc = 2.81*10^19;
Nc = nc*((t/300)^(3/2));
eg = 1.14;
ef = 0.55;
ec = ef + 0.5*eg;
b = (ec - ef)/(k*t);
n = nc*e^(-b);
fprintf("Si: n = \n")
disp(n);
nv = 1.83*10^19;
Nv = nv*((t/300)^(3/2));
nvnc = log(nv/nc);
ev = 2*ef - ec - k*t*nvnc;
d = (ef - ev)/(k*t);
p = nv*e^(-d);
fprintf("Si: p = \n")
disp(p);

# Carrier Density of GaAs
i = 139;
t = 100 + i;
k = 8.6*10^(-5);
e = 2.7;
nc = 4.35*10^17;
Nc = nc*((t/300)^(3/2));
eg = 1.45;
ef = 0.7;
ec = ef + 0.5*eg;
b = (ec - ef)/(k*t);
n = nc*e^(-b);
fprintf("GaAs: n = \n")
disp(n);
nv = 7.57*10^18;
Nv = nv*((t/300)^(3/2));
nvnc = log(nv/nc);
ev = 2*ef - ec - k*t*nvnc;
d = (ef - ev)/(k*t);
p = nv*e^(-d);
fprintf("GaAs: p = \n")
disp(p);

# Exercise 2.4 - Proof Equation
# Si - 300 K
k = 8.6*10^(-5);
nc = 2.81*10^19;
eg = 1.12;
nv = 1.83*10^19;
T = 300;
ef = 0.6;
ec = ef + 0.5*eg;
nvnc = log(nv/nc);
ev = 2*ef - ec - k*T*nvnc;
n = nc*(exp((ef - ec)/(k*T)));
n2 = realpow(n,2);
fprintf("Si: n^2 = \n");
disp(n2);
n = nc*(exp((ef - ec)/(k*T)));
p = nv*exp((ev - ef)/(k*T));
fprintf("Si: n*p = \n");
disp(n*p);

# GaAs - 300 K
k = 8.6*10^(-5);
nc = 4.35*10^17;
eg = 1.42;
nv = 7.57*10^18;
T = 300;
ef = 0.71;
ec = ef + 0.5*eg;
nvnc = log(nv/nc);
ev = 2*ef - ec - k*T*nvnc;
n = nc*(exp((ef - ec)/(k*T)));
n2 = realpow(n,2);
fprintf("GaAs: n^2 = \n");
disp(n2);
n = nc*(exp((ef - ec)/(k*T)));
p = nv*exp((ev - ef)/(k*T));
fprintf("GaAs: n*p = \n");
disp(n*p);

# Exercise 2.5 - Density of Electrons Diagram in Counterfeit Semiconductor
# Si
To = linspace(400,400,100);
Ta = linspace(400,410,100);
Tb = linspace(410,600,100);
nc = 2.81*10^19;
Nc = nc*realpow(Tb./300,3/2);
nv = 1.83*10^19;
Nv = nv*realpow(Tb./300,3/2);
nd = 1; %10^15
% calculate eg of Si
eg0 = 1.17;
b = (4.73*10^(-4)).*Tb.^2;
c = Tb.+636;
eg = eg0.-b./c;
na = nd;
k = 8.6*(10^(-5));
exponent = eg./(k*Tb);
e = 2.71;
n = realpow(Nc.*Nv.*e.^(-exponent),1/2);
nb = n/10^15 + nd;
figure;
plot(To, 0, 'k', Ta, na, 'k', Tb, nb, 'c');
xlabel('T(K)');
hold on
ylabel('Density * 10^1^5 (cm^-^3)');
hold on
title('Density - T of Si');

#GaAs
Ta = linspace(400,410,100);
Tb = linspace(410,600,100);
nc = 4.35*10^17;
Nc = nc*realpow(Tb./300,3/2);
nv = 7.57*10^18;
Nv = nv*realpow(Tb./300,3/2);
nd = 1; %10^15
% calculate eg of GaAs
eg0 = 1.52;
l = (5.4*10^(-4)).*Tb.^2;
m = Tb.+204;
eg = eg0.-l./m;
na = nd;
k = 8.6*(10^(-5));
exponent = eg./(k*Tb);
e = 2.71;
%n = realpow(Nc.*Nv.*e.^(-exponent),1/2);
n = (Nc.*Nv.*e.^(-exponent)).^(1/2);
nb = n/10^15 + nd;
figure;
plot(Ta, na, 'r', Tb, nb, 'b');
xlabel('T(K)');
hold on
ylabel('Density * 10^1^5 (cm^-^3)');
hold on
title('Density - T of GaAs');

