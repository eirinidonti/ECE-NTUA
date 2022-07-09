%Eirini Donti 03119839
function errors=ask_Nyq_psk_6_5(k,Nsymb,nsamp,EbNo,rolloff)
k=2; Nsymb=10000; nsamp=16; EbNo=10;
rolloff=0.5;
L=2^k;
%% Gray Mapping
ph1=[pi/4]; 
theta=[ph1; -ph1; pi-ph1; -pi+ph1];
mapping=exp(1j*theta);
if(k>2)
 for j=3:k
 theta=theta/2;
 mapping=exp(1j*theta);
 mapping=[mapping; -conj(mapping)];
 theta=angle(mapping);
 end
end
%% Convert Random Bits to Symbols
x=floor(2*rand(k*Nsymb,1)); 
xsym=bi2de(reshape(x,k,length(x)/k).','left-msb')';
y=[];
for i=1:length(xsym)
 y=[y mapping(xsym(i)+1)];
end
%% Filter Creation
delay=8;
filtorder = delay*nsamp*2;
rNyquist= rcosine(1,nsamp,'fir/sqrt',rolloff,delay);
%% Transmitter
y=upsample(y,nsamp);
ytx = conv(y,rNyquist);
R=2000000; % 2 Mbps % R=4575000
Fs=R/k*nsamp;
fc=8;  % fc/1/T
m=(1:length(ytx));
s=real(ytx.*exp(1j*2*pi*fc*m/nsamp));
figure(1); pwelch(s,[],[],[],Fs);
%% Noise
SNR=EbNo-10*log10(nsamp/2/k);
Ps=10*log10(s*s'/length(s)); % dΒ
Pn=Ps-SNR; % dΒ
n=sqrt(10^(Pn/10))*randn(1,length(ytx));
snoisy=s+n;
clear ytx xsym s n;
%% Receiver
yrx=2*snoisy.*exp(-1j*2*pi*fc*m/nsamp); clear s;
yrx = conv(yrx,rNyquist);
yrx = yrx(2*nsamp*delay+1:end-2*nsamp*delay);
figure(2); pwelch(real(yrx),[],[],[],Fs);
yr = downsample(yrx,nsamp); 
%% Calculate Errors
xr=[];
q=[0:1:L-1];
for n=1:length(yr)
 [m,j]=min(abs(theta-angle(yr(n)))); 
 yr(n)=q(j);
 xr=[xr; de2bi(q(j),k,'left-msb')'];
end
errors=sum(not(x==xr));