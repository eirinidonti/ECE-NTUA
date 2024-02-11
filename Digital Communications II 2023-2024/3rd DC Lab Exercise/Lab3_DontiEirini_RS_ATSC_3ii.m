%%%RS_decoding_Euclid's GCD algorithm ATSC
clear all; close all; clc;
t=10;
m=8;
k=187;
n=k+2*t;
d=primpoly(m);%primitive polynomial of gf(2^m)
a=gf(2,m,d); %the first non-zero, non-one element of the field
%b will contain the non-zero elements of gf(2^8)
b=gf([],m,d);
b(n)=1;
for i=2^m-1:-1:1
    b(i)=a^i;
end

e_x=[];
er_pos=[193, 175, 170, 155, 114, 99, 43, 36, 17, 10]; %θέσεις λαθών όπου οι τιμές αντιπροσωπεύουν 
                               %τους εκθέτες των όρων όπου τα λάθη εμφανίζονται
er=[a^58, a^45, a^72, a^240, a^160, a^12, a^11, a^4, a^236, a^101]; %τιμές λαθών
%er_pos=[24 12 10];
%er=[a^4 a^0 a^19];
count=1;

for i=1:n
    if er_pos(count)==n-i 
        e_x=[e_x, er(count)];
        if count<t
            count=count+1;
        end
    else
        e_x=[e_x,0];
    end
end
r_x=e_x; %Μόνο αν θεωρήσουμε τη μηδενική κωδικολέξη


%%%%Υπολογισμός συνδρόμων
S=gf([zeros(1,2*t)],m,d);
for i=1:2*t
    for j=1:n-1
        S(i)=S(i)+(a^(rem(i*(n-j),2^m-1)))*e_x(j);
    end
   
end
log(S) %εκθέτες των συνδρόμων σε εκθετική μορφή

%%%%%%%%%%%Euclid's algorithm
%αρχικοποιούμε βήματα -1 και 0
u_iminus2=gf([1,zeros(1,2*t)],m,d);
u_iminus1=flip(S);
phi_i=gf([],m,d);
s_iminus2=gf([1],m,d);
s_iminus1=gf([0],m,d);
t_iminus2=gf([0],m,d);
t_iminus1=gf([1],m,d);
i=1;

while length(u_iminus1)>t %συνθήκη τερματισμού του αλγορίθμου
    
    [p,q]=deconv(u_iminus2,u_iminus1);
    u_iminus2=u_iminus1;
    u_iminus1=q;
    phi_i=p;   
    
    temp=[];
    no_zeros=0; %αφαιρούμε τα μηδενικά από την αρχή του πολυωνύμου
    for j=1:length(u_iminus1)
        if u_iminus1(j)==0 && no_zeros==0
            continue
        else
            temp=[temp,u_iminus1(j)];
            no_zeros=1;
        end
    end
    u_iminus1=temp;
    temp=[];
    no_zeros=0;
    for j=1:length(phi_i)
        if phi_i(j)==0 && no_zeros==0
            continue
        else
            temp=[temp,phi_i(j)];
            no_zeros=1;
        end
    end
    phi_i=temp;
    fprintf('For step %d we get u_%d, phi_%d',i,i,i);
    u_iminus1 %u_i(x) for step i
    phi_i %φ_i(x) for step i
  
    while length(s_iminus2)-length(conv(phi_i,s_iminus1))~=0
        s_iminus2=[0,s_iminus2]; %απαιτείται για να είναι τα πολυώνυμα ίδιων διαστάσεων 
                                 %και να μπορεί το MATLAB να τα προσθέσει
    end
    mu=s_iminus2+conv(phi_i,s_iminus1);
    s_iminus2=s_iminus1;
    s_iminus1=mu;
    
    while length(t_iminus2)-length(conv(phi_i,t_iminus1))~=0
        t_iminus2=[0,t_iminus2]; %απαιτείται για να είναι τα πολυώνυμα ίδιων διαστάσεων 
                                 %και να μπορεί το MATLAB να τα προσθέσει
    end
    mu=t_iminus2+conv(phi_i,t_iminus1);
    t_iminus2=t_iminus1;
    t_iminus1=mu;
    
    
    
    fprintf('And we also get s_%d, t_%d',i,i);
    s_iminus1 %s_i(x) for step i
    t_iminus1 %t_i(x) for step i
    i=i+1;
end
lambda=1/t_iminus1(length(t_iminus1));
sig_x=t_iminus1*lambda;
o_x=u_iminus1*lambda;
log(sig_x)%οι εκθέτες των συντελεστών του πολυωνύμου εντοπισμού λαθών
log(o_x)%οι εκθέτες των συντελεστών του πολυωνύμου υπολογισμού λαθών

solution_count=0;
solutions=[];
for i=0:2^m-2
    ai=a^i;
    v=1;
    for j=1:t
     v=v+sig_x(j)*ai^(t+1-j);
    end
    if v==0
        solutions=[solutions,a^i];
        fprintf('a^%d is a solution \n',i);
        solution_count=solution_count+1;
    end
end

inv=solutions.^-1; %Αντίστροφα ριζών
error_pos=log(inv); %θέσεις των λαθών
der_sig=gf(zeros(1,t),m,d); %παράγωγος του πολυωνύμου εντοπισμού σφαλμάτων
for j=1:t
    temp=gf([1],m,d);
    for k=1:t
        if k~=j
            temp=conv(temp,gf([inv(k) 1],m,d));
        end
    end
    der_sig=der_sig+temp*inv(j);
end

for i=1:t
    if der_sig(i)~=0
        fprintf('a^%d*x^%d',log(der_sig(i)),t-i);
        if i<t
            fprintf(' + ');
        else
            fprintf('\n');
        end
    end
    
end

errors=gf(zeros(1,t),m,d);
for i=1:t
    errors(i)=polyval(o_x,solutions(i))/polyval(der_sig,solutions(i)); %τιμές σφαλμάτων
end
errors==er %Η αποκωδικοποίηση πέτυχε ;


