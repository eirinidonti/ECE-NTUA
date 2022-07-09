%%
clear all
close all
clc
%%
Fs=2000;
% Fs=500; Fs=1000;
Ts=1/Fs;
T=0.1;
% T=0.2; T=0.5; T=1;
t=0:Ts:T-Ts;
A=1;
x=A*sin(2*pi*100*t);
L=length(x);
plot(t,x)
pause
%%
N = 1*L;
%N = 2*L; N=4*L;
Fo=Fs/N;
Fx=fft(x,N);
freq = (0:N-1)*Fo;
plot(freq,abs(Fx))
title('FFT')
pause
axis([0 100 0 L/2])
pause
%%
N = 1*L;
Fx=fft(x,N);
Fo=Fs/N;
freq=(0:N-1)*Fo;
x=A*sin(2*pi*100*t);
L=length(x);


power = Fx.*conj(Fx)/Fs/L;
plot(freq,power)
xlabel('Frequency (Hz)')
ylabel('power')
title('{\bf Periodogram}')
%%
A=1;
x=A*sin(2*pi*100*t);

power_theory=A^2/2
db=10*log10(power_theory)
power_time_domain=sum ...
    (abs(x).^2)/L
power_frequency_domain=sum ...
    (power)*Fo

