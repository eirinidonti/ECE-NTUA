%Eirini Donti 0319839
function errors=ask_errors(k,Nsymb,nsamp,EbNo)
% Η συνάρτηση αυτή εξομοιώνει την παραγωγή και αποκωδικοποίηση
% θορυβώδους σήματος L-ASK και μετρά τον αριθμό των εσφαλμένων συμβόλων.
% Επιστρέφει τον αριθμό των εσφαλμένων συμβόλων (στη μεταβλητή errors).
% k είναι ο αριθμός των bits/σύμβολο, επομένως L=2^k -- ο αριθμός των
% διαφορετικών πλατών
% Nsymb είναι ο αριθμός των παραγόμενων συμβόλων (μήκος ακολουθίας LASK)
% nsamp ο αριθμός των δειγμάτων ανά σύμβολο (oversampling ratio)
% EbNo είναι ο ανηγμένος σηματοθορυβικός λόγος Eb/No, σε db
%
%k=mod(19839,2)+3; L=2^k; d=3; M=50000; nsamp=16; EbNo = 12; A=[(-L+1)*d/2:2*d/2:(L-1)*d/2]; %1)
k=3; M=50000; nsamp=16; EbNo = 12; L=2^k;  %2)
L=2^k;
SNR=EbNo-10*log10(nsamp/2/k); % SNR ανά δείγμα σήματος
% Διάνυσμα τυχαίων ακεραίων {±1*d/2, ±3*d/2, ... ±(L-1)*d/2}. Να επαληθευθεί
%x=[2*floor(L*rand(1,M))-L+1]*d/2; hist(x,A); title("Histogram - Eirini Donti")
x=[2*floor(L*rand(1,M))-L+1];
%Px=(d^2/4)*(L^2-1)/3 % θεωρητική ισχύς σήματος %1)
%sum(x.^2)/length(x) % μετρούμενη ισχύς σήματος (για επαλήθευση) %1)
Px=(L^2-1)/3; % θεωρητική ισχύς σήματος
sum(x.^2)/length(x); % μετρούμενη ισχύς σήματος (για επαλήθευση) 
y=rectpulse(x,nsamp);
n=wgn(1,length(y),10*log10(Px)-SNR);
ynoisy=y+n; % θορυβώδες σήμα
y=reshape(ynoisy,nsamp,length(ynoisy)/nsamp);  %size_y = size(y)
matched=ones(1,nsamp); %size_matched=size(matched)
z=matched*y/nsamp; size_z=size(z)
hist(z,200); title("Histogram - Eirini Donti"); %2) 
A=[-L+1:2:L-1];
for i=1:length(z)
[m,j]=min(abs(A-z(i)));
z(i)=A(j);
end
err=not(x==z);
errors=sum(err);
end