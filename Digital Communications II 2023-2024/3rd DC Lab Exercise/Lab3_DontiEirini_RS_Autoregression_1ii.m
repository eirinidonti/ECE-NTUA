%%%Reed-Solomon decoding using Autoregression%%%
%RS decoding
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A.Confirm that p(x) is a primpoly on the
%GF(2^5). Find all the elements of this field and fill out the table
%with all the represantations of the elements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all;
t=3;
m=5;
n=2^m-1;
k=n-2*t;
d=primpoly(m);%primitive polynomial of gf(2^m) with m=5 D^5+D^2+1=37
a=gf(2,m,d); %the first non-zero, non-one element of the field
%b will contain the non-zero elements of gf(2^5)
b=gf([],m,d);
b(n)=1;
for i=n-1:-1:1
    b(i)=a^i;
end
% All elements of b are discrete, thus p(x) is primitive
%
%B.Find the RS encoder on that field capable of correcting up to 3
%erroneous elements. Then suppose that an all-zero 60-bit block
%(encoded with this encoder) is transmitted. At the receiver,
%it is found 1(instead of 0) at bit positions 31, 95, 103, 104
%(counted from the left-most bit position 0, or MSB), that is,
%the following bit stream is received:
rb=zeros(1,m*n); %an all-zero codeword
e_pos=[31, 95, 103, 104]; %bit-error positions within the
                                %(binary) codeword, from MSB
for i=1:length(e_pos)
    rb(e_pos(i))=~rb(e_pos(i)); %We invert the bits at erroneous bit positions to get
                                %the received message
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Combining the bits in  five (elements of the GF(2^5)), we get:
%r(x)=a^4*X^24+a^0*X^12+a^19*X^10
rm=reshape(rb,m,length(rb)/m);
r=gf(bi2de(rm','left-msb'),m)';
%{
gfr=[];
for i=1:m:n*m %μπορεί να γίνει και με χρήση της bi2de
    ele=0;
    for j=0:m-1
        ele=ele+rb(i+j)*2^(m-1-j);
    end
    gfr=[gfr, gf(ele,m)];
end
%gfr=flip(gfr);
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Syndrome Calculation
s=gf([],m,d);
for i=1:2*t
    s(i)=r(n);
    for j=1:n-1
        s(i)=s(i)+(a^i)^j*r(n-j);
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
    sigma=S^-1*cons_s';
    %Find roots of sigma
    s_roots_exp=[];   %vector of sigma roots exponents(of a)
    for i=1:n-1
        ai=a^i;
        %ai=a^(n-i); %
        sr=gf(1,m,d);
        for j=1:t
            sr=sr+sigma(j)*ai^(t-j+1);
        end
        if (sr==0)
            s_roots_exp=[s_roots_exp i];
        end
    end
    b=(a.^s_roots_exp).^-1;   %inverses of sigma roots
    er_pos=n-log(b);   %error positions from ms digit %
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
    u=r;
    for i=1:length(er)
        u(er_pos(i))=r(er_pos(i))+er(i);
    end
    r
    u
else
    disp('Determinant equal zero');
end
%{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Use high-level MATLAB functions for RS encoding & decoding
% ----------------------------------------------------------
msg=gf(zeros(1,k),m,d); % a message with k zero-value elements
r=rsenc(msg,n,k); % the rs-encoded message (n zeros)
r(3)=3;
r(9)=8;
r(12)=11; %the specified errors
[u,cnumerr]=rsdec(r,n,k); % u: the decoded data message
                          % cnumerr: the number of errors found
%}
