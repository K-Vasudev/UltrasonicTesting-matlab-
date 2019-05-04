function [time_vector] = TimeVector_Create(duration,axis_length)
% TimeVector_Create generates a timevector based on the output of
% the AcquisitionLogic digitizer board, as saved in UT_Signal.m structure
% format.
%
% Inputs:       duration - the total length of the ultrasonic
%                       signal (in milliseconds)
%               axis_length - the total number of data points in the
%                       ultrasonic signal (unitless)
% Output:       time_vector - an array of the times corresponding to 
%                       data points of the ultrasonic signal (in us)

% Determine the spacing between individual data points
digitizing_rate = duration/axis_length;

% Create a time-vector with the above spacing, starting at 0
% and ending one time spacing before 'duration'
time_vector = [0: digitizing_rate: duration-digitizing_rate];

end

% April 14, 2018
% Advanced Materials and Processing Lab
% Dept. of Chem. and Materials Engineering
% University of Alberta
% Kartik Vasudev
% kvasudev@ualberta.ca
%
% Built and run on Matlab R2018a
