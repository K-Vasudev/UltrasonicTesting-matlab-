function [ signal_filtered ] = HammingFilter( signal, filter_size )
% SignalFilterHamming runs a signal through a hamming filter and outputs
% the filtered result. The filter used is a normalized, backward-forward
% Hamming filter.
%
% Inputs:       signal - vector of DOUBLE containing the raw ultrasonic 
%                           signal to be filtered
%               filter_size - DOUBLE, INT, CONST with the size of the 
%                           filter. Larger filter ---> more smoothing
% Outputs:      signal_filtered - vector of DOUBLE containing the filtered
%                           version of signal.

% Use Matlab's built-in function 'hamming' to produce a hamming
% window of size 'filter_size'
hamming_window = hamming(filter_size);
window_sum = sum(hamming_window);

% Use Matlab's built-in function 'filtfilt' to filter the signal.
% This is a 'zero-phase' filter, meaning no time change results 
% from its application.
signal_filtered = filtfilt(hamming_window, window_sum, signal);

end

% April 14, 2018
% Advanced Materials and Processing Lab
% Dept. of Chem. and Materials Engineering
% University of Alberta
% Kartik Vasudev
% kvasudev@ualberta.ca
%
% Built and run on Matlab R2018a