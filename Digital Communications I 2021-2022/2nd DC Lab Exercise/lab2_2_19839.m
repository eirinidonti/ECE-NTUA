% Part 3 - Eirini Donti 
% (α)
% Bandpass FIR filter - closed-form and windowing
clear all; close all;
load sima; % Fs = 8192;
flow=600; fhigh=2000; Ts=1/Fs;
f2m1=(fhigh-flow); f2p1=(flow+fhigh)/2; N=256;
t=[-(N-1):2:N-1]*Ts/2;
hbp=2/Fs*cos(2*pi*f2p1*t).*sin(pi*f2m1*t)/pi./t;
hbpw=hbp.*kaiser(length(hbp),5)';
wvtool(hbp,hbpw);
sima_bp=conv(s,hbp);
figure; pwelch(sima_bp,[],[],[],Fs); hold on; legend("(before) Eirini Donti");
sima_bpw=conv(s,hbpw);
figure; pwelch(sima_bpw,[],[],[],Fs); hold on; legend("(after windowing) Eirini Donti");
% (β)
% Bandpass Parks-MacClellan
clear all; close all; load sima;
flow = 600; fhigh=2000; %Hz
f=2*[0 flow*0.95 flow*1.05 fhigh*0.95 fhigh*1.05 Fs/2]/Fs; %high side lobe
f=2*[0 570 630 1970 2030 4096]/Fs;                         %normal side lobe
hbp_pm=firpm(256,f, [0 0 1 1 0 0]);                       
%figure; freqz(hpm,1);
wvtool(hbp_pm);
sima_pm=conv(s,hbp_pm);
figure; pwelch(sima_pm,[],[],[],Fs); hold on; legend("(after filtering) Eirini Donti");