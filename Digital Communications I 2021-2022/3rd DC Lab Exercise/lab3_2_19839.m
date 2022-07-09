clc
close all;
clear all;

%Part 2 - Eirini Donti
%(a)
  %(i)
  k=2;%4-ASK %k=mod(19839,2)+3;
  L=2^k; M=50000.0;
  EbNo_dB = 0:0.1:20;
  EbNo_linear = 10.^(EbNo_dB/10);
  Pe = ((L-1)/L)*erfc(sqrt((3*log2(L)/(L^2-1)).*EbNo_linear));
  BER4 = Pe./log2(L);
  figure; S1=semilogy(EbNo_dB,BER4,'r'); hold on
  
  k=3;%8-ASK
  L=2^k; M=50000.0;
  Pe = ((L-1)/L)*erfc(sqrt((3*log2(L)/(L^2-1)).*EbNo_linear));
  BER8 = Pe./log2(L);
  S2=semilogy(EbNo_dB,BER8,'g'); legend('8-ASK');

  k=4;%16-ASK
  L=2^k; M=50000.0;
  Pe = ((L-1)/L)*erfc(sqrt((3*log2(L)/(L^2-1)).*EbNo_linear));
  BER16 = Pe./log2(L);
  S3=semilogy(EbNo_dB,BER16,'b'); legend('16-ASK');
  title('Theoretical BER diagram (a),(i)');
  xlabel('Es/No (dB)'); ylabel('BER'); grid on;
  S=[S1;S2;S3];
  legend(S,'4-ASK','8-ASK','16-ASK');
  hold off;
  %(ii)
Pe=[];%4-ASK
for EbNo = 1:20
    errors=ask_errors(2,50000,16,EbNo); 
    Pe=[Pe; errors./50000];
end   
   BER=Pe./log2(L);
   EbNo_dB= 1:20;
  figure; s1=semilogy(EbNo_dB,BER,'ok'); hold on;

Pe=[]; %8-ASK
for EbNo = 1:20
    errors=ask_errors(3,50000,16,EbNo);
    Pe=[Pe; errors./50000];
end   
   BER=Pe./log2(L);
   EbNo_dB= 1:20;
   s2=semilogy(EbNo_dB,BER,'+');

 Pe=[];%16-ASK
for EbNo = 1:20
    errors=ask_errors(4,50000,16,EbNo);
    Pe=[Pe; errors./50000];
end   
   BER=Pe./log2(L);
   EbNo_dB= 1:20;
   s3=semilogy(EbNo_dB,BER,'x');
   title('Theoretical BER diagram (a),(ii)');
   xlabel('Es/No (dB)'); ylabel('BER'); grid on;
  s=[s1;s2;s3];
  legend(s,'4-ASK','8-ASK','16-ASK');
  hold off;
 % S=[S1;S2;S3;s1;s2;s3];
 % legend(S,'4-ASK','8-ASK','16-ASK','4-ASK','8-ASK','16-ASK');
 
% %(b)
% function [ber,numBits] = ask_ber_func(EbNo, maxNumErrs, maxNumBits)
% % Import Java class for BERTool.
% import com.mathworks.toolbox.comm.BERTool.*;
% % Initialize variables related to exit criteria.
% totErr = 0; % Number of errors observed
% numBits = 0; % Number of bits processed
% % Α. --- Set up parameters. ---
% % --- INSERT YOUR CODE HERE.
% k=3; % number of bits per symbol
% Nsymb=2000; % number of symbols in each run
% nsamp=16; % oversampling,i.e. number of samples per T
% % Simulate until number of errors exceeds maxNumErrs
% % or number of bits processed exceeds maxNumBits.
% while((totErr < maxNumErrs) && (numBits < maxNumBits))
%  % Check if the user clicked the Stop button of BERTool.
%  if (BERTool.*getSimulationStop)
%  break;
%  end
%  % Β. --- INSERT YOUR CODE HERE.
%  errors=ask_errors(k,Nsymb,nsamp,EbNo);
%  % Assume Gray coding: 1 symbol error ==> 1 bit error
%  totErr=totErr+errors;
%  numBits=numBits + k*Nsymb;
% end % End of loop
% % Compute the BER
% ber = totErr/numBits;
% end