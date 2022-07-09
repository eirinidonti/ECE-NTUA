   %03119839 - Eirini Dontis NTUA
   
   %1.1
   
%a)orismos a & b %
c = 0.55;
%P = 5
a1 = [0 0 0 0 0 0]
b1 = [c 0 0 0 0 1-c]

%b)apokrisi platous kai fashs %
freqz(b1,a1)

%c) poloi kai mhdenika %
[z,p] = tf2zp(a1,b1)
zplane(z,p)

%d) kroustikh apokroysh %
impz(b1,1,10)

%st)%
anew = b1
bnew = a1
  
  %1.2

%a)%
p = [0.65-0.65i 0.65+0.65i 0.65-0.65i 0.65+0.65i]
z = [0.8 0.8 -0.8i 0.8i]

%diagramma p & z
 zplane(z,p)

z = [0.8; 0.8; -0.8i; 0.8i;] %z must be column
%euresh a & b
[b,a] = zp2tf(z,p,1);

%b)%
%sxediasmos apokrishs platous
figure
freqz(b,a)

%c)%
%sxediasmos kroustikhs apokroyshs 

figure
impz(b,a)

%vhmatikh apokrish systhmatos
stepz(b,a,80)

%d)%
p1 = [0.7-0.7i 0.7+0.7i 0.7-0.7i 0.7+0.7i]
p2 = [0.707-0.707i 0.707+0.707i 0.707-0.707i 0.707+0.707i]
p3 = [0.75-0.75i 0.75+0.75i 0.75-0.75i 0.75+0.75i]
z = [0.8; 0.8; -0.8i; 0.8i;]

[b1,a1] = zp2tf(z,p1,1);
[b2,a2] = zp2tf(z,p2,1);
[b3,a3] = zp2tf(z,p3,1);

%kroustikh apokrish susthmatos
z = [0.8; 0.8; 0.8i; -0.8i;]

impz(b1,a1)
impz(b2,a2)
impz(b3,a3)

%apokrish platous gia p1
freqz(b1,a1)

%gia aitiologhsh
z = [0.8 0.8 -0.8i 0.8i]
zplane(z,p1)
zplane(z,p2)
zplane(z,p3)

%e)%

p = [0.4-0.7i 0.4+0.7i 0.4-0.7i 0.4+0.7i]
z = [0.8 0.8 -0.8i 0.8i]

%diagramma p & z
 zplane(z,p)

z = [0.8; 0.8; 0.8i; -0.8i;] %z must be column
%euresh a & b
[b,a] = zp2tf(z,p,1);

%sxediasmos apokrishs platous
figure
freqz(b,a)

%st)%

p = [0.65-0.65i 0.65+0.65i 0.65-0.65i 0.65+0.65i]
z1 = [0.77-0.2i 0.77+0.2i 0.2-0.77i 0.2+0.77i]
z2 = [0.4-0.7i 0.4+0.7i 0.7-0.4i 0.7+0.4i]

%diagramma p & z
zplane(z1,p)
zplane(z2,p)

z1 = [0.77-0.2i; 0.77+0.2i; 0.2-0.77i; 0.2+0.77i;] %z must be column
z2 = [0.4-0.7i; 0.4+0.7i; 0.7-0.4i; 0.7+0.4i;]
%euresh a & b
[b4,a4] = zp2tf(z1,p,1);
[b5,a5] = zp2tf(z2,p,1);

%sxediasmos apokrishs platoys kai fashs

figure
freqz(b4,a4)
freqz(b5,a5)

  %2.1

%a)%
%akoume to shma
aud1 = audioread('viola_series.wav');
fs = 44100; %Hz
sound(aud1,fs)
 
%apeikonizoyme to shma
plot(aud1)
xlabel('time')
ylabel('viola audio')
 
%b)%
range1 = max(aud1(:))-min(aud1(:));
m1 = (aud1 - min(aud1(:)))/range1;
aud1 = 2*m1-1;

%Energy of Signals

N = linspace(-1,1,10);
w = 0.54 + 0.46.*cos(2.*pi.*N) %n/N = N
energy = conv(aud1.*aud1,w.*w, 'same');
plot(energy)

%c)%
Fs = 44100; % Sampling frequency                    
T = 1/Fs;   % Sampling period       
L = 50000;  % Length of signal
Y = fft(aud1);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1)
xlabel('frequency (Hz)')
ylabel('viola spectrum |x[f]|')

%d)%
fs = 44100 %Hz
[l1,v] = size(aud1); 
dt = 1./fs;
dt_ms = dt.*1000;
t1 = (0:l1-1).*dt_ms;
n0 = 11000;

plot(t1(10000:n0), aud1(10000:n0))
xlabel('time')
ylabel('viola audio')

%e)%
aud1 = audioread('viola_series.wav');
Fs = 44100; % Sampling frequency                    
T = 1/Fs;   % Sampling period       
L = 3800;  % Length of signal - T prohgoumenoy erwthmatos
Y = fft(aud1);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1)
xlabel('frequency (Hz)')
ylabel('viola spectrum |x[f]|')

%st)%
aud1 = audioread('viola_note.wav');
plot(aud1)

  %2.2
  
%a)%
%akoume to shma
fs = 44100; %Hz
[yc,fs] = audioread('piano_note.wav');
sound(yc,fs)

%apeikonizoyme to shma
plot(yc)
xlabel('time')
ylabel('piano audio')

%b)%
[yc,fs] = audioread('piano_note.wav');
c = 0.6;
fs = 44100;
P = 7448;% ypologizoyme gia kathisterhsh 0.15 sec
rv = zeros(1,7449);
rv(1) = c;
rv(7449)= 1-c;
echoed = filter(rv,1,yc);
plot(echoed)
xlabel('echoed')
ylabel('piano audio')
sound(echoed,fs);

reverbed = filter(echoed,1,echoed);
plot(reverbed)
sound(reverbed,fs);
xlabel('reverbed')
ylabel('piano audio')

%c)%
[yc,fs] = audioread('piano_note.wav');
c = 0.6;
fs = 44100;
P = 7448;
rv = zeros(1,7449);
rv(1) = c;
rv(7449)= 1-c;
echoed = filter(rv,1,yc);
reverbed = filter(echoed,1,echoed);

fftSignal=fft(yc);
fftSignal1=fft(echoed);
fftSignal2=fft(reverbed);

figure; 
subplot(3,1,1)
plot(20*log(abs(fftSignal)))
ylabel('Magnitude (In db)')
xlabel('spectrum')
hold on
subplot(3,1,1)
plot(20*log(abs(fftSignal1)),'g')
ylabel('Magnitude (In db)')
xlabel('spectrum')
hold on 
subplot(3,1,1)
plot(20*log(abs(fftSignal2)),'r')
ylabel('Magnitude (In db)')
xlabel('spectrum')

%d)%
[yc,fs] = audioread('piano_note.wav');
c = 0.6;
fs = 44100;
P = 4999;
x = 5000;
rv = zeros(1,x);
rv(1) = c;
rv(x)= 1-c;
echoed = filter(rv,1,yc);
plot(echoed)
sound(echoed,fs)

% P: no echo effect
[yc,fs] = audioread('piano_note.wav');
c = 0.6;
fs = 44100;
P = 2995;
x = 2996;
rv = zeros(1,x);
rv(1) = c;
rv(x)= 1-c;
echoed = filter(rv,1,yc);
plot(echoed)
xlabel('no echo effect')
sound(echoed,fs)

%e)%
[yc,fs] = audioread('piano_note.wav');
c = 0.6;
P = 7448;% ypologizoyme gia kathisterhsh 0.15 sec
rv = zeros(1,P+1);
rv(1) = c;
rv(P+1)= 1-c;
echoed = filter(rv,1,yc);
reverbed = filter(echoed,1,echoed);
filename = 'echoed.wav';
audiowrite(filename,echoed,44100);
clear echoed fs
filename = 'reverbed.wav';
audiowrite(filename,reverbed,44100);
clear reverbed fs

%st)%
[yc,fs] = audioread('piano_note.wav');
c = 0.6;
fs = 44100;
P = 7448;% ypologizoyme gia kathisterhsh 0.15 sec
rv = zeros(1,7449);
rv(1) = c;
rv(7449)= 1-c;
echoed = filter(rv,1,yc);
reverbed = filter(echoed,1,echoed);
rvde = zeros(1,7449);
rvde(1) = 1-c;
rvde(7449)= c;
dereverbed = filter(rvde,1,yc);
sound(dereverbed,fs)
plot(dereverbed,'y')
hold on 
plot(yc)

  






