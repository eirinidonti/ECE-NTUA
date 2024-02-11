%%%RS_decoding_autoregression_ATSC
%%%Reed-Solomon decoding using Autoregression%%%
 
clear all; close all;
t=10;
m=8;
k=187;
n=2*t+k;
d=primpoly(m);%primitive polynomial of gf(2^m)
a=gf(2,m,d); %the first non-zero, non-one element of the field
%b will contain the non-zero elements of gf(2^m)
b=gf([],m,d);
b(n)=1;
for i=n-1:-1:1
    b(i)=a^i;
end
% All elements of b are discrete, thus p(x) is primitive
%An all-zero 60-bit block(encoded with this encoder) is transmitted. At the receiver,
%(counted from the left-most bit position 0, or MSB), that is,
%the following bit stream is received:
rb=zeros(1,m*n); %an all-zero codeword
e_pos=[106,107, 109, 112, 249, 250, 256, 290, 291, 294, 296, 411, 413, 414, 737, 738, 739, 742, 743, 1249, 1250, 1253, 1254, 1256, 1305, 1306, 1307, 1309, 1364, 1513, 1514, 1517, 1519, 1520, 1571, 1575]; %bit-error positions within the
                                %(binary) codeword, from MSB
for i=1:length(e_pos)
    rb(e_pos(i))=~rb(e_pos(i)); %We invert the bits at erroneous bit positions to get
                                %the received message
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Combining the bits in fives (elements of the GF(2^m)), we get:
%gfr(x)=r(x)   
 
gfr=[];
for i=1:m:n*m 
    elem=0;
    for j=0:m-1
        elem=elem+rb(i+j)*2^(m-1-j);
    end
    gfr=[gfr, gf(elem,m)];
end
 
%{ 
%Το παραπάνω μπορεί να γίνει και με χρήση της bi2de
rm=reshape(rb,m,length(rb)/m);
r=gf(bi2de(rm','left-msb'),m)';
%}
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Syndrome Calculation
s=gf([],m,d);
for i=1:2*t
    s(i)=gfr(n);
    for j=1:n-1
        s(i)=s(i)+(a^i)^j*gfr(n-j);
    end
end
S=gf([],m,d);
cons_s=gf([],m,d);
for i=1:t
    for j=0:t-1
        S=[S s(i+j)];
    end
    cons_s(i)=-s(t+i);
end
S=reshape(S,t,length(S)/t)';
if det(S)~=0
    sig=S^-1*cons_s';
    %Find roots of sigma
    s_roots_exp=[];   %vector of sigma roots exponents(of a)
    for i=1:2^m-1
        ai=a^i;
        sr=gf(1,m,d);
        for j=1:t
            sr=sr+sig(j)*ai^(t-j+1);
        end
        if (sr==0)
            s_roots_exp=[s_roots_exp i];
        end
    end

    b=(a.^s_roots_exp).^-1;   %inverses of sigma roots
    er_pos=n-log(b);   %error positions from ms digit 
    B=gf([],m,d);
    cons_b=gf([],m,d);
    for i=1:t
        for j=1:t
            B=[B b(j)^i];
        end
        cons_b(i)=s(i);
    end
    B=reshape(B,t,length(B)/t)';
    er=(B^-1*cons_b')';
    u=gfr;
    for i=1:length(er)
        u(er_pos(i))=gfr(er_pos(i))+er(i);
    end
    gfr
    u
else
    disp('Determinant equal zero');
end