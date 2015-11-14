%% Novelty function: weighted phase deviation
% Paper : S. Dixon, 2006, onset detection revisited 
% [nvt] = myWPD(x, windowSize, hopSize)
% input: 
%   x: N by 1 float vector, input signal
%   windowSize: int, number of samples per block
%   hopSize: int, number of samples per hop
% output: 
%   nvt: m by 1 float vector, the resulting novelty function 

function [nvt] = myWPD(x, windowSize, hopSize,fs)

frames = Windows(x,windowSize,hopSize,fs);
spectra = fft(frames);
phase = angle(spectra);
delphase = myUnwrap(phase,windowSize,hopSize); % unwrapped first derivative of phase
delphase = princarg(delphase); % re-wrapped first derivative

delphase2 = myUnwrap(delphase,windowSize,hopSize); %unwrapped second derivative of phase
delphase2 = princarg(delphase2); % re-wrapped second derivative

nvt = sum(abs(spectra.*delphase2))/windowSize;

nvt(1) = nvt(3);
nvt(2) = nvt(3); 
nvt = nvt'/max(nvt); % normalizing the nvt
end
