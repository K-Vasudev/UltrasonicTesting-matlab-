function [ New_UT_Signal ] = RawUT_Get( filename, steel_type, sample_number, other_info  )
% RawUT_Get function will read in a file from the 'Raw UT Data' folder.
% This file will then be saved as a Matlab object (class: UT_Signal).
% The raw UT signal must be directly within the 'Raw UT Data' folder, not in a
% subfolder, if it is to be read into Matlab.
%
% Inputs:   filename - STRING with the name of the '.txt' file to read
%           steel_type - STRING with the steel type analyzed in the file
%           sample_number - STRING with the jominy sample number (and cut)
%           other_info - STRING with other desired information
% Outputs:  New_UT_Signal - UT_Signal Class with ultrasonic information

[signal, duration, axis_length] = RawUT_Read(filename);     % Function call to 'UT Signal Analysis\Functions\RawUT_Read'

% Change to root folder (UT Signal Analysis)
% Assumes 'Functions' is current folder
Functions_Folder = cd('..');                % Saves 'Functions' folder destination

New_UT_Signal = UT_Signal;                  % Create new object with Class 'UT_Signal'

% Save UT_Signal properties
New_UT_Signal.Steel_Type = steel_type;
New_UT_Signal.Sample_Name = sample_number;
New_UT_Signal.Other = other_info;
New_UT_Signal.Date_Saved = date;            % Set to current date (built-in 'date' function)
New_UT_Signal.Signal = signal;
New_UT_Signal.Duration = duration;
New_UT_Signal.Axis_Length = axis_length;

cd(Functions_Folder);                       % Return to 'Functions' folder

end

% April 15, 2018
% Advanced Materials and Processing Lab
% Dept. of Chem. and Materials Engineering
% University of Alberta
% Kartik Vasudev
% kvasudev@ualberta.ca
%
% Built and run on Matlab R2018a

