clear all; close all;
% Eirini Donti - Το αρχείο "sima.mat" περιέχει το σήμα s και τη συχνότητα
% δειγματοληψίας Fs. Το φάσμα του σήματος εκτείνεται σχεδόν σε όλη την
% περιοχή συχνοτήτων μέχρι 4 KHz. Πάνω από 1 KHz, όμως, είναι θόρυβος
% και πρέπει να φιλτραριστεί.
load sima;
figure; pwelch(s,[],[],[],Fs);
% Ορίζεται η ιδανική βαθυπερατή συνάρτηση Η, με συχνότ. αποκοπ. Fs/8
H=[ones(1,Fs/8) zeros(1,Fs-Fs/4) ones(1,Fs/8)];
% Υπολογίζεται η κρουστική απόκριση με αντίστροφο μετασχ. Fourier
% Εναλλακτικά, μπορεί να χρησιμοποιηθεί η αναλυτική σχέση Sa(x)
h=ifft(H,'symmetric');
middle=length(h)/2;
h = fftshift(h); %h2=[h(middle+1:end) h(1:middle)]; isequal(h,h2) %1)
h32=h(middle+1-16:middle+17);
h196=h(middle+1-98:middle+99); h64=h(middle+1-32:middle+33); %2)
h128=h(middle+1-64:middle+65);
% figure; stem([0:length(h64)-1],h64); grid;
%figure; freqz(h64,1); % σχεδιάζουμε την απόκριση συχνότητας της h64
wvtool(h32,h196,h128); %wvtool(h32,h64,h128); % αποκρίσεις συχνότητας των περικομμένων h %2)
% Οι πλευρικοί λοβοί είναι υψηλοί!
% Πολλαπλασιάζουμε την περικομμένη κρουστική απόκριση με κατάλληλο
% παράθυρο. Χρησιμοποιούμε την h64 και παράθυρα hamming και kaiser
wh=hamming(length(h196)); %wh=hamming(length(h64));
wk=kaiser(length(h64),5);
figure; plot(0:64,wk,'r',0:196,wh,'b'); grid; %figure; plot(0:64,wk,'r',0:64,wh,'b'); grid;
h_hamming=h196.*wh'; %h_hamming=h64.*wh';
% figure; stem([0:length(h64)-1],h_hamming); grid;
% figure; freqz(h_hamming,1);
h_kaiser=h64.*wk';
wvtool(h196,h_hamming); %wvtool(h64,h_hamming,h_kaiser); %2) rect & Hamming frequency response
% Φιλτράρουμε το σήμα μας με καθένα από τα τρία φίλτρα
y_rect=conv(s,h196);%y_rect=conv(s,h64);
figure; pwelch(y_rect,[],[],[],Fs);
y_hamm=conv(s,h_hamming);
figure; pwelch(y_hamm,[],[],[],Fs);
y_kais=conv(s,h_kaiser);
figure; pwelch(y_kais,[],[],[],Fs);
%
% Βαθυπερατό Parks-MacClellan
hpm=firpm(196, [0 0.1 0.15 0.5]*2, [1 1 0 0]);%hpm=firpm(196, [0 0.1 0.15 0.5]*2, [1 1 0 0]); %3) %4)
%figure; freqz(hpm,1);
t = 0:1/Fs:1-1/Fs;
s=1*sin(2*pi*500*t)+1*sin(2*pi*800*t)+1*sin(2*pi*1500*t)+1*sin(2*pi*3000*t);
figure; pwelch(s,[],[],[],Fs);
s_pm=conv(s,hpm);
figure; pwelch(s_pm,[],[],[],Fs);
%sound(20*s); % ακούμε το αρχικό σήμα, s