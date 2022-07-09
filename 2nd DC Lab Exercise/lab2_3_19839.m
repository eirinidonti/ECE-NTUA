 close all; clear all;clc;
 xb=[1 2 3 4 5 4 3 2 1] % πραγματικό σήμα με άρτια συμμετρία
 figure; subplot (2,1,1); plot([-4:4],xb); ylabel('xb');
 x=ifftshift(xb) % το σήμα με τις αρνητικές συνιστώσες στο άνω μέρος
 X=fft(x) % FFT
 Xb=fftshift(X) % το φάσμα με τη dc συνιστώσα στο κέντρο, πραγματικές
 % τιμές με άρτια συμμετρία όπως αναμένεται
 subplot (2,1,2); plot([-4:4],Xb);ylabel('Xb');
 close all; clear all;clc;
 Xb=[0 0 1 1 1 1 1 0 0] % φάσμα βαθυπερατού σήματος με άρτια συμμετρία
 figure; subplot (2,1,1); plot([-4:4],Xb); ylabel('Xb');
 X=ifftshift(Xb) % το φάσμα με τις αρνητικές συνιστώσες στο άνω μέρος
 x=ifft(X) % IFFT
 xb=fftshift(x) % πραγματικό σήμα με άρτια συμμετρία όπως αναμένεται
 subplot (2,1,2); plot([-4:4],xb); ylabel('xb');
