function [ signal, duration, axis_length ] = RawUT_Read( filename )
% RawUT_Read takes in a ultrasonic signal file (.txt)
%   Take a filename (.txt) which contains an ultrasonic signal
%   Find the '.txt' file within the 'UT Signal Analysis\Raw UT Data' folder
%   Loads the file
%   Saves variables from the file
%
% Inputs:   filename - STRING containing the file with the raw signal
% Outputs:  signal - DOUBLE (vector) containing the UT signal
%           duration - DOUBLE containing the time length of the signal
%           axis_length - DOUBLE containing the number of data points

% Change to 'UT Signal Analysis\Raw UT Data' folder
Functions_Folder = cd ('..\Raw UT Data');         % Save 'Functions' folder location

fileID = fopen(filename);                         % Create a filepath to the desired file

line = fgetl(fileID);                             % Obtains the value of the first line in 'filename'
while line ~= -1                                  % Continues to run until document is finished reading

    if strcmp('[Data]', line)                     % 'Data' preceeds the actual UT data array in 'filename'
        line = fgetl(fileID);
        for counter = 1:length(signal)            % Write each data point to SignalValue vector
            signal(counter) = str2num(line);      % Read in data line by line and store it
            line = fgetl(fileID);                 % Get next line of data
        end    
    elseif strcmp('[Axis Length]', line)          % Section to determine the number of data points
        line = fgetl(fileID);                     % Get next line
        axis_length = str2num(line);              % Set line contents to axis length
        signal = zeros(axis_length,1);            % Create an array of zeros to store the signal
        line = fgetl(fileID);
    elseif strcmp('[X Axis Range]', line)
        line = fgetl(fileID);
        space_pos = find(isspace(line));          % Find the position of the spaces in the line
        time_min = str2num(line(1:space_pos(1)-1));               % Get into upto the first space
        time_max = str2num(line(space_pos(2)+1:space_pos(3)-1));        % Deteremine the value of signal end time
        line = fgetl(fileID);
    elseif strcmp('[Data Range]', line)           % Data Range gives the maximum and minimum voltages
        fgetl(fileID);
        line = fgetl(fileID);
    end
end

duration = time_max - time_min;                   % Duration of signal in microseconds (us)

cd(Functions_Folder);                             % Return to the 'UT Signal Analysis\Functions' folder


end

% April 15, 2018
% Advanced Materials and Processing Lab
% Dept. of Chem. and Materials Engineering
% University of Alberta
% Kartik Vasudev
% kvasudev@ualberta.ca
%
% Built and run on Matlab R2018a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NOTE:
% Data in an output file from the Acquisition Logic digitizer will be in
% the following form:
%
% 
%' [Axis Length]            '
%' 120000                   '
%' [X Axis Range]           '
%' 0.000 	30.000 	us      '
%' [Data Range]             '
%' -1.000 	1.000 	V       '
%' [Data]                   '
%' -0.016                   '   
%' -0.016                   '
%' -0.016                   '
%'... (data)                '
