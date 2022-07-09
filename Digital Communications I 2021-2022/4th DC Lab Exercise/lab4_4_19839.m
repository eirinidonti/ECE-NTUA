% Eirini Donti 03119839
function errors=ask_Nyq_filter1(k,Nsymb,nsamp,EbNo)
% Εξομοιώνει την παραγωγή και αποκωδικοποίηση
% θορυβώδους ακολουθίας L-ASK και μετρά τα λαθεμένα σύμβολα,
% με μορφοποίηση παλμών μέσω φίλτρου τετρ. ρίζας Nyquist.
%%%%%% ΠΑΡΑΜΕΤΡΟΙ %%%%%%%
% k είναι ο αριθμός των bits ανά σύμβολο, έτσι L=2^k
% Nsymb είναι το μήκος της εξομοιούμενης ακολουθίας συμβόλων L-ASK
% nsamp είναι ο συντελεστής υπερδειγμάτισης, δηλ. #samples/Td
% EbNo είναι ο ανηγμένος σηματοθορυβικός λόγος, Εb/No, σε db
%clear all; %16-ASK
%k = 4; L=2^k; nsamp = 16; step=2;  Nsymb = 10000; EbNo = 10;
step=2; L=2^k;
SNR=EbNo-10*log10(nsamp/2/k); % SNR ανά δείγμα σήματος
% Ορισμός παραμέτρων φίλτρου
delay = 8; % Group delay (# of input symbols)
filtorder = delay*nsamp*2; % τάξη φίλτρου
rolloff = 1/3; % Συντελεστής πτώσης -- rolloff factor
% κρουστική απόκριση φίλτρου τετρ. ρίζας ανυψ. συνημιτόνου
rNyquist=rcosine(1,nsamp,'fir/sqrt',rolloff,delay);% κρουστική απόκριση φίλτρου
%figure; freqz(rNyquist);
%-----------------------
% Για φίλτρο γραμμικής πτώσης να χρησιμοποιηθεί η επόμενη εντολή
% (με την rtrapezium του Κώδικα 4.1 στο current directory)
% Πρέπει delay>5 για καλά αποτελέσματα στην αναγνώριση.
% rNyquist=rtrapezium(nsamp,rolloff,delay);
% ----------------------
% Gray Mapping 
step=4; 
mapping=[step/2; -step/2]; % mapping is vector of ask points in gray-coding order
                           % Για L=8 και step=2: mapping=[7 5 1 3 -7 -5 -1 -3]
if(k>1)
    for j=2:k
        mapping=[mapping+2^(j-1)*step/2; -mapping-2^(j-1)*step/2];
    end
end

% Without Gray coding
%mapping=-(L-1):step:L-1;
% Demo κωδικοποίησης Gray
%ask_scatterplot_gray(k,step);
%
x=randi(2,1,k*Nsymb)-1;
xsym=bi2de(reshape(x,k,length(x)/k).','left-msb');
y1 =[]; % ακολουθία παλμών στο φίλτρο πομπού
for i=1:length(xsym);
    y1=[y1 mapping(xsym(i)+1)];
end

% ΕΚΠΕΜΠΟΜΕΝΟ ΣΗΜΑ
% Υπερδειγμάτιση και εφαρμογή φίλτρου rNyquist
y=upsample(y1,nsamp);
ytx = conv(y,rNyquist,'same'); % εκπεμπόμενο σήμα - μετά την υπέρθεση - παραγόμενο σήμα - στην έξοδο πομπού
% Διάγραμμα οφθαλμού για μέρος του φιλτραρισμένου σήματος
% eyediagram(ytx(1:2000),nsamp*2);
ynoisy=awgn(ytx,SNR,'measured'); % θορυβώδες σήμα
%figure; stem(ytx(1:20*nsamp))
% ----------------------
%figure; stem(ynoisy(1:20*nsamp))
% ΛΑΜΒΑΝΟΜΕΝΟ ΣΗΜΑ
% Φιλτράρισμα σήματος με φίλτρο τετρ. ρίζας ανυψ. συνημ.
yrx=conv(ynoisy,rNyquist,'same');
yr = downsample(yrx,nsamp); % Υποδειγμάτιση - δείγματα κατά τις στιγμές kT
%yrx = yrx(2*delay*nsamp+1:end-2*delay*nsamp); % περικοπή, λόγω καθυστέρησης 
% Ανιχνευτής ελάχιστης απόστασης L πλατών
l=[-L+1:2:L-1];
xr=[];% γειτονικές τιμές του yr στον αστερισμό
for i=1:length(yr)
[m,j]=min(abs(mapping-yr(i)));
xr= [xr de2bi(j-1,k,'left-msb')];
end
errors=sum(not(x==xr));
end