%Eirini Donti 03119839
function [ber,numBits] = ask_ber_func_qam(EbNo, maxNumErrs, maxNumBits,varargin)
% Import Java class for BERTool.
import com.mathworks.toolbox.comm.BERTool.*;
% Initialize variables related to exit criteria.
totErr = 0; % Number of errors observed
numBits = 0; % Number of bits processed
% Α. --- Set up parameters. ---
% --- INSERT YOUR CODE HERE.
M=16; % M-QAM
L=sqrt(M);l=log2(L); k=log2(M);
Nsymb=10000; % number of symbols in each run
nsamp=16; % oversampling,i.e. number of samples per T
rolloff=0.29; % rolloff for raised cosine filter
% Simulate until number of errors exceeds maxNumErrs
% or number of bits processed exceeds maxNumBits.
while((totErr < maxNumErrs) && (numBits < maxNumBits))
 % Check if the user clicked the Stop button of BERTool.
 if(isBERToolSimulationStopped(varargin{:}))
 break;
 end
 % Β. --- INSERT YOUR CODE HERE.
 errors=ask_Nyq_qam(M,Nsymb,nsamp,EbNo,rolloff);
 % Assume Gray coding: 1 symbol error ==> 1 bit error 
 totErr=totErr+errors; 
 numBits=numBits + k*Nsymb;
end % End of loop
% Compute the BER
ber = totErr/numBits;