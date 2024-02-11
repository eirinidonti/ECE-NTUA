% Eirini Donti 03119839
clear all; close all;
m=4; n=2^m-1; t=3; k=5;
g= gf([1 0 1 0 0 1 1 0 1 1 1],1); % BCH (15,5) - trivial gf
msg1 = gf(zeros(k,1)',1);
msg2 = gf(ones(k,1)',1);
msg3 = gf([1 0 1 0 1],1);         % random msg
%% verify that with the same 3-bit error the syndrome is the same for all three messages
u1 = [msg1 zeros(n-k,1)']; % codeword
[q,b1] = deconv(u1,g);     % remainder b1
u1 = u1 + b1;
u2 = [msg2 zeros(n-k,1)'];
[q,b2] = deconv(u2,g);
u2 = u2 + b2;
u3 = [msg3 zeros(n-k,1)'];
[q,b3] = deconv(u3,g);
u3 = u3 + b3;
e = gf([ones(t,1)',zeros(n-t,1)'],1); % random error e
r1 = u1 + e;
r2 = u2 + e;
r3 = u3 + e;
[q br1] = deconv(r1,g); % syndrome br1
[q br2] = deconv(r2,g); % syndrome br2
[q br3] = deconv(r3,g); % syndrome br3
%last 10 bits is syndrome
%br1 + br2 
%br1 + br3
%% --------------
% Form the syndrome-error look_up table
% 2^10 = 1024 syndromes with the corresponding errors
% n = 15 single-error patterns nx(n-1)/2 = 105 double-error pattern
% ---------------
%% --- Try the single- and double-error patterns
zer = zeros(n,1)';
E=[]; S=[]; j=0;
for i=1:n
    e1=zer;e1(i) = 1;
    E=[E;e1];
    r1 = u1+e1;
    [q br] = deconv(r1,g);
    S=[S;br(k+1:end)];
    j=j+1;
    e2 = e1;
    for kk=1:n
        ee=e2;
        if e2(kk)==0 ee(kk)=1; end
        flag=0; J=j;
        for l=1:J;
            if E(l,:)==ee flag=1; break;end
        end
        if flag==0;
            E=[E;ee];
            r1=u1+ee;
            [q br] = deconv(r1,g);
            S=[S;br(k+1:end)];
            j=j+1;
        end
    end
end

%%-----Now,with all,three patterns
zer=zeros(n,1)';
E=[];S=[];j=0;
for i=1:n
    e1=zer;e1(i)=1;
    E=[E;e1];
    r1=u1+e1;
    [q br]=deconv(r1,g);
    S=[S;br(k+1:end)];
    j=j+1;
    e2=e1;
    for ii=1:n
        ee=e2;
        if e2(ii)==0 ee(ii)=1; end
        flag=0; J=j;
        for l=1:J
            if E(l,:)==ee flag=1; break; end
        end
        if flag==0
            E=[E;ee];
            r1=u1+ee;
            [q br] = deconv(r1,g);
            S=[S;br(k+1:end)];
            j=j+1;
        end
        e3=ee;
        for iii=1:n
            eee=e3;
            if e3(iii)==0 eee(iii)=1; end
            flag=0; J=j;
            for l=1:J
                if E(l,:)==eee flag=1;break;end
            end
            if flag==0
                E=[E;eee];
                r1=u1+eee;
                [q br]=deconv(r1,g);
                S=[S;br(k+1:end)];
                j=j+1;
            end
        end
    end
end

%%------------ Tests ---------
r3=u3+E(end-3,:);
[q br3]=deconv(r3,g);
br3(k+1:end)+S(end-3,:);

%%------ Add zero error and 448 4-bit error patterns
E=[zeros(n,1)'; E]; S=[zeros(n-k,1)';S]; %0 bit error
J=length(E); JJ=min(n*(n-1)*(n-2)/2/3,2^(n-k)-J);
jj=1;
for j=1:J
    if sum(E(j,:))==3
        eeee=E(j,:);
        for i=1:length(eeee)
            if eeee(i)==0
                eeee(i)=1;
                break;
            end
        end
        E=[E;eeee];
        r1=u1+eeee;
        [q br]=deconv(r1,g);
        S=[S;br(k+1:end)];
        jj=jj+1;
    end
    if jj>JJ break; end
end
