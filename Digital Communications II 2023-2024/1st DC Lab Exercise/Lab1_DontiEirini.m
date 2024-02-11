%%%%%%     Simulation of a DMT Tx-RX System over an AWGN  line     %%%%%%
%  --------------------------     winter semester 2020      --------------------------------%%

clear all; close all;

%% System parameters 
K=255;       % number of subcarriers 
Tu=1/4000;   % DMT symbol duration - 4000 frames per second
Fi=4312.5;   % subcarrier spacing
d=0;         % guard interval portion -- zero in this simulation
delta=d*Tu;  % guard interval duration
Ts=Tu+delta; % actual symbol duration
Ks=2*(K+1);  % FFT size
Fs=Ks*Fi;    % Nyquist frequency
T=1/Fs;      % time-sampling period  
%
% Gain vector
% It contains the gain for each subcarrier (zero means "don't use")
G=[0 ones(1,K-1) 0];
for i=1:31 G(i)=0; end;    % voice and uplink band -- not used 
G(64)=0;                   % sub-carrier 64 will be used as pilot
for i=180:200 G(i)=0; end; % very noisy band -- not used
for i=201:230 G(i)=1.5; end; % higher gain band
for i=231:256 G(i)=0; end; % very noisy band -- not used
used_carriers=sum(G~=zeros(1,256));
% other parameters
M = 16;      % Size of signal constellation per subcarrier - same for all
mb = log2(M); % Number of bits per subcarrier
Ns = 500;      % Number of DMT symbols to process. 
% Use a small value of Ns (e.g. 10) for demonstration 
% and a large value (e.g. 500) for BER estimation
n_bits=Ns*mb*used_carriers;    % number of bits to generate
Rate=mb*used_carriers/Tu;  %actual transmission rate, in bps
nsamp = 16;  % Oversampling rate, for analog signal simulation
Tn=T/nsamp;  % oversampling period
SNR=5;      % signal-to-noise-ratio, in db
%% Input bit stream
% Create a binary data stream as a vector.
x = randi(2,1,n_bits)-1; %x = randint(1,n_bits); % Random binary data stream

%% QAM constellation encoding
% A. Define a vector for mapping bits to symbols using
% orthogonal full-grid constellation and Gray coding. 
% The vector corresponds to 16-QAM constellation.
mapping = [0 1 3 2 4 5 7 6 12 13 15 14 8 9 11 10].';

% B. Do ordinary binary-to-decimal mapping.
xsym=bi2de(reshape(x,mb,length(x)/mb).','left-msb');   

% C. Mapping to QAM constellation
xsym = mapping(xsym+1);
y=qammod(xsym,M)';
% show a scatterplot of the QAM-encoded data

scatterplot(y);
%-----------------------------------------------------
%  Exercise # 1
% Display the 16-QAM constellation with the associated
% 4-bit codes shown next to ech point of the constellation
%------------------------------------------------------
% .....

text(real(y) - 0.0,imag(y) + 0.3, dec2base(xsym,2,4),'Color',[0 1 0]);
text(real(y) - 0.5,imag(y) + 0.3, num2str(xsym),'Color',[0 1 0]);

title('16-QAM Symbol Mapping')
axis([-4 4 -4 4])

% .....
% D. Compute weights over thye entire spectrum
power=y*y'/length(y); amp=sqrt(power);
k=1;
y_mat=[];
for n=1:Ns
    z=zeros(2*(K+1),1);
    for i=1:length(G)
        if G(i)~=0
           z(i)=G(i)*y(k);
           z(2*(K+1)-i+1)=z(i)';
           k=k+1;
        end; 
    end;
    z(64)=1.5*amp; z(2*(K+1)-63)=z(64);  % pilot
    y_mat=[y_mat z];
end;
% Stem Plot of a DMT symbol (amplitudes of complex values)
figure;
stem(abs(y_mat(:,1)));
title('carrier modulation within a DMT symbol');
xlabel('carier index'); ylabel('amplitude');
 
% Compute IFFT to get DMT time symbols 
s=2*(K+1)*ifft(y_mat, 'symmetric');
figure; pwelch(reshape(s,Ns*2*(K+1),1),[],[],[],Fs);

%%
% Upsampling by using the MATLAB interp function.
% This is needed for the simulation of the analog signal
for n=1:length(s(1,:))
    s_up(:,n)=interp(s(:,n),nsamp);
end;

% plot spectrum of upsampled signal and explain the high freq spectral images
figure; pwelch(reshape(s_up,Ns*2*(K+1)*nsamp,1),[],[],[],Fs); 
Fs1=Fs*nsamp; Ks1=Ks*nsamp; % the sampling frequency is changed accordingly
% 
%%  add noise
sr=awgn(s_up,SNR,'measured');
figure; pwelch(reshape(sr,Ns*2*(K+1)*nsamp,1),[],[],[],Fs);
clear s_up;
%
%%  Filter out the out-of-band noise and downsample the signal
% filter-out the bandpass components
% LP (Parks-McClellan) filtering
order=16*nsamp;
f1=1.1*Fi*(K+1)/Fs1; f2=1.3*f1;
fpts=[0 2*[f1 f2] 1];
mag=[1 1 0 0]; wt=[1 1];
b = firpm(order,fpts,mag,wt);
a=1;
for i=1:length(sr(1,:))
    dummy=[sr(:,i);zeros(order,1)];
    dummy1=filter(b,a,dummy);
    delay=order/2;
    sr_up(:,i)=dummy1(delay+(1:length(sr(:,1))));
end
figure; pwelch(reshape(sr_up,Ns*2*(K+1)*nsamp,1),[],[],[],Fs);
sr_down=downsample(sr_up,nsamp);
% figure; pwelch(reshape(sr_down,Ns*2*(K+1),1),[],[],[],Fs);
% sr_down=downsample(sr,nsamp);  %without filtering
clear sr sr_up;

%% Delineate DMT symbols and perform FFT to get the QAM symbols
yr_mat=1/Ks*fft(sr_down, Ks);
% keep only the payload carriers
yr=[];
for n=1:length(yr_mat(1,:))
    for i=1:length(G)
        if G(i)~=0
           yr=[yr yr_mat(i,n)/G(i)];
        end; 
    end;
end;
scatterplot(yr);

%% QAM decoding and error counting
%---------------------------------------------------------------
%  Exercise # 2
% Complete the code to implement QAM decoding and error counting.
% For each element of the received vector yr (complex value)
% find the nearest point on the 16-QAM constellation
% Compare the results with the transmitted vector y, 
% count the errors and compute the BER
%---------------------------------------------------------------
% ANSWER
% --------
% ...

dataSymbolsOutG = qamdemod(sr_down,M);    % Gray-coded data symbols
yreal=real(yr);  yimag=imag(yr);          % in phase & quadrature components
l=[-3:2:3];
for n=1:length(yreal)
   [m,j]=min(abs(l-yreal(n)));
   yreal(n)=l(j);
   [m,j]=min(abs(l-yimag(n)));
   yimag(n)=l(j);
end
%scatterplot(yreal+1i*yimag);
err=not(y==(yreal+1i*yimag));
errors=sum(err);
BER=errors/(length(y))/mb;
fprintf("BER = %s \n", BER);

% ...