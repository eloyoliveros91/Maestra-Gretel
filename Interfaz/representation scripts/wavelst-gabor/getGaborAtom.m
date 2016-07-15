function atom = getGaborAtom(N,scale,timeShift,frequency,phase)
%This function obtains a Gabor atom of given parameters
%N- Length of the signal
%scale- must be in number of samples
%timeShift - must be in number of samples
%frequency - its normalized frequency from 0 to 0.5   f/fs;
%Phase - a value from 0 to 2 pi
%This version uses the number of samples but seconds can also be used.

atom =zeros(N,1);
for n=1:N
    atom(n,1) = (1/sqrt(scale))*exp(-pi*(n-timeShift)^2/scale^2) * cos(2*pi*frequency*    (n-timeShift)+phase);
end
atom = (1/norm(atom)) .* atom;   %Normalization
end
