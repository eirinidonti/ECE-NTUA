% % Eirini Donti 03119839
% %  3rd-part 2-(a)
% % 
%   function errors=ask_errors(k,Nsymb,nsamp,EbNo)
% %  Η συνάρτηση αυτή εξομοιώνει την παραγωγή και αποκωδικοποίηση
% %  θορυβώδους σήματος L-ASK και μετρά τον αριθμό των εσφαλμένων συμβόλων.
% %  Επιστρέφει τον αριθμό των εσφαλμένων συμβόλων (στη μεταβλητή errors).
% %  k είναι ο αριθμός των bits/σύμβολο, επομένως L=2^k -- ο αριθμός των
% %  διαφορετικών πλατών
% %  Nsymb είναι ο αριθμός των παραγόμενων συμβόλων (μήκος ακολουθίας LASK)
% %  nsamp ο αριθμός των δειγμάτων ανά σύμβολο (oversampling ratio)
% %  EbNo είναι ο ανηγμένος σηματοθορυβικός λόγος Eb/No, σε db
% %  
%   L=2^k;
%   SNR=EbNo-10*log10(nsamp/2/k); % SNR ανά δείγμα σήματος
% %  Διάνυσμα τυχαίων ακεραίων {±1, ±3, ... ±(L-1)}. Να επαληθευθεί
%   x=2*floor(L*rand(1,Nsymb))-L+1;
%   Px=(L^2-1)/3; % θεωρητική ισχύς σήματος
%   sum(x.^2)/length(x); % μετρούμενη ισχύς σήματος (για επαλήθευση)
%   y=rectpulse(x,nsamp);
%   n=wgn(1,length(y),10*log10(Px)-SNR);
%   ynoisy=y+n; % θορυβώδες σήμα
%   y=reshape(ynoisy,nsamp,length(ynoisy)/nsamp);
%   matched=ones(1,nsamp);
%   z=matched*y/nsamp;
%   A=[-L+1:2:L-1];
%   for i=1:length(z)
%   [m,j]=min(abs(A-z(i)));
%   z(i)=A(j);
%   end
%   err=not(x==z);
%   errors=sum(err);
%   end

% %3rd-part 3
% function errors=ask_errors(k,Nsymb,nsamp,EbNo)
% % Η συνάρτηση αυτή εξομοιώνει την παραγωγή και αποκωδικοποίηση
% % θορυβώδους σήματος L-ASK και μετρά τον αριθμό των εσφαλμένων συμβόλων.
% % Υπολογίζει επίσης τη θεωρητική πιθανότητα εσφαλμένου συμβόλου, Pe.
% % Επιστρέφει τον αριθμό των εσφαλμένων συμβόλων, καθώς και τον συνολικό
% % αριθμό των συμβόλων που παρήχθησαν.
% % k είναι ο αριθμός των bits/σύμβολο, ώστε L=2^k,
% % M ο αριθμός των παραγόμενων συμβόλων (μήκος ακολουθίας L-ASK)
% % nsamp ο αριθμός των δειγμάτων ανά σύμβολο (oversampling ratio)
% % EbNo είναι ο λόγος Eb/No, σε db
% %k = mod(19839,2)+3; L=2^k; EbNo=12; nsamp=16; M=50000;
% %k=3; L=2^k; nsamp=32; M=50000;
% L=2^k; M=50000;
% SNR=EbNo-10*log10(nsamp/2/k); % SNR ανά δείγμα σήματος
% % Διάνυσμα τυχαίων ακεραίων {±1, ±3, ... ±(L-1)}. Να επαληθευτεί
% x=2*floor(L*rand(1,M))-L+1;
% Px=(L^2-1)/3; % θεωρητική ισχύς σήματος
% sum(x.^2)/length(x); % μετρούμενη ισχύς σήματος (για επαλήθευση)
% %y=rectpulse(x,nsamp);
% h=cos(2*pi*(1:nsamp)/nsamp); h=h/sqrt(h*h');%h=ones(1,nsamp); h=h/sqrt(h*h'); % κρουστική απόκριση φίλτρου %Part 3
% % πομπού (ορθογωνικός παλμός μοναδιαίας ενέργειας)
% y=upsample(x,nsamp); % μετατροπή στο πυκνό πλέγμα
% y=conv(y,h); % το προς εκπομπή σήμα
% y=y(1:M*nsamp); % περικόπτεται η ουρά που αφήνει η συνέλιξη
% 
% n=wgn(1,length(y),10*log10(Px)-SNR);
% 
% ynoisy=awgn(y,SNR,'measured'); % θορυβώδες σήμα %ynoisy=y+n; % θορυβώδες σήμα %ynoisy=y;
% %matched=h;
% %y=reshape(ynoisy,nsamp,length(ynoisy)/nsamp);
% %matched=ones(1,nsamp);
% %z=matched*y/nsamp;
% for i=1:nsamp matched(i)=h(end-i+1); end
% yrx=conv(ynoisy,matched);
% z = yrx(nsamp:nsamp:M*nsamp); % Yποδειγμάτιση -- στο τέλος
% 
% % κάθε περιόδου Τ
% l=[-L+1:2:L-1];
% for i=1:length(z)
% [m,j]=min(abs(l-z(i)));
% z(i)=l(j);
% end
% err=not(x==z);
% errors=sum(err);
% 
% %figure; stem(x(1:20));
% %figure; stem(y(1:20*nsamp));
% %figure; stem(yrx(1:20*nsamp));
% %figure; stem(h);
% end

%3rd-part 3
function errors=ask_errors(k,Nsymb,nsamp,EbNo)
% Η συνάρτηση αυτή εξομοιώνει την παραγωγή και αποκωδικοποίηση
% θορυβώδους σήματος L-ASK και μετρά τον αριθμό των εσφαλμένων συμβόλων.
% Υπολογίζει επίσης τη θεωρητική πιθανότητα εσφαλμένου συμβόλου, Pe.
% Επιστρέφει τον αριθμό των εσφαλμένων συμβόλων, καθώς και τον συνολικό
% αριθμό των συμβόλων που παρήχθησαν.
% k είναι ο αριθμός των bits/σύμβολο, ώστε L=2^k,
% M ο αριθμός των παραγόμενων συμβόλων (μήκος ακολουθίας L-ASK)
% nsamp ο αριθμός των δειγμάτων ανά σύμβολο (oversampling ratio)
% EbNo είναι ο λόγος Eb/No, σε db
%k = mod(19839,2)+3; L=2^k; EbNo=12; nsamp=16; M=50000;
%k=3; L=2^k; nsamp=32; M=50000;
L=2^k; M=50000;
SNR=EbNo-10*log10(nsamp/2/k); % SNR ανά δείγμα σήματος
% Διάνυσμα τυχαίων ακεραίων {±1, ±3, ... ±(L-1)}. Να επαληθευτεί
x=2*floor(L*rand(1,M))-L+1;
Px=(L^2-1)/3; % θεωρητική ισχύς σήματος
sum(x.^2)/length(x); % μετρούμενη ισχύς σήματος (για επαλήθευση)
%y=rectpulse(x,nsamp);
h=cos(2*pi*(1:nsamp)/nsamp); h=h/sqrt(h*h');%h=ones(1,nsamp); h=h/sqrt(h*h'); % κρουστική απόκριση φίλτρου %Part 3
% πομπού (ορθογωνικός παλμός μοναδιαίας ενέργειας)
y=upsample(x,nsamp); % μετατροπή στο πυκνό πλέγμα
y=conv(y,h); % το προς εκπομπή σήμα
y=y(1:M*nsamp); % περικόπτεται η ουρά που αφήνει η συνέλιξη

n=wgn(1,length(y),10*log10(Px)-SNR);

ynoisy=awgn(y,SNR,'measured'); % θορυβώδες σήμα %ynoisy=y+n; % θορυβώδες σήμα %ynoisy=y;
matched=h;
%y=reshape(ynoisy,nsamp,length(ynoisy)/nsamp);
%matched=ones(1,nsamp);
%z=matched*y/nsamp;
%for i=1:nsamp matched(i)=h(end-i+1); end
yrx=conv(ynoisy,matched);
z = yrx(nsamp:nsamp:M*nsamp); % Yποδειγμάτιση -- στο τέλος

% κάθε περιόδου Τ
l=[-L+1:2:L-1];
for i=1:length(z)
[m,j]=min(abs(l-z(i)));
z(i)=l(j);
end
err=not(x==z);
errors=sum(err);

%figure; stem(x(1:20));
%figure; stem(y(1:20*nsamp));
%figure; stem(yrx(1:20*nsamp));
%figure; stem(h);
end