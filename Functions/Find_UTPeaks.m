function [peak_voltage, peak_times] = Find_UTPeaks(maxima_voltage, maxima_index, time_vector,...
    threshold, decrease_rate)
% Find_UTPeaks takes in a set of individual points, and compares them to
% a set of criteria to determine which may be real ultrasonic signal peaks.
% This function may miss ultrasonic peaks due to several reasons. Input
% values, specifically threshold and decrease_rate may not be optimal.
% Important peaks may also be too small to differentiate from noise peaks.
%
% Inputs:       maxima_voltage - array of DOUBLE containing voltages of
%                       ultrasonic signals
%               maxima_index - array of DOUBLE containing the index from
%                       the original ultrasonic signal to which
%                       maxima_voltage is mapped
%               time_vector - array of DOUBLE containing the time vector
%                       for an ultrasonic signal. 
%               threshold - DOUBLE specifying initial minimum peak height
%               decrease_rate - DOUBLE specifying necessary height of
%                       subsequent peaks
% Outputs:      peak_voltage - array of DOUBLE contaning Y indices of
%                       ultrasonic peaks
%               peak_times - array of DOUBLE containing X indices of
%                       ulrasonic peaks

% Initialize output variables to be written into
peak_voltage = [];
peak_index = [];

% Check every input voltage to see if it meets criteria
for counter = 1:length(maxima_voltage)
    % Check if the voltage is greater than the threshold*decrease_rate
    if maxima_voltage(counter) > (threshold * decrease_rate)
        % Assign the input point as an ultrasonic signal
        peak_voltage = [peak_voltage, maxima_voltage(counter)];
        peak_index = [peak_index, maxima_index(counter)];
        
        % Reset the threshold to the most recent peak height
        threshold = maxima_voltage(counter);
    end
end

% Assign ultrasonic peak times
peak_times = time_vector(peak_index);

end

% April 14, 2018
% Advanced Materials and Processing Lab
% Dept. of Chem. and Materials Engineering
% University of Alberta
% Kartik Vasudev
% kvasudev@ualberta.ca
%
% Built and run on Matlab R2018a