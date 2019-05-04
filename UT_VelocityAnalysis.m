% This script is used to open an ultrasonic signal in a graph window.
% Peaks are also isolated and displayed on the graph.
% Buttons allow:
%       - hiding/showing of peaks on the graph (default = show)
%       - displaying time and voltage of all peaks VISIBLE in the graph
%               (information is displayed in the 'Command Window' (below)
clear;
clc;



% ----------- SCRIPT PARAMETERS ------------
% (Changes made to this script should only be made in this section)
% DEFAULTS: FILTER_SIZE = 31
%           THRESHOLD = 0.5
%           DECREASE_RATE = 0.2
%
FILTER_SIZE = 31;           % Size of smoothing Hamming filter
THRESHOLD = 0.5;            % Minimum voltage for first peak detection
DECREASE_RATE = 0.2;        % Minimum threshold decreases for subsequent peaks
%
% FILTER_SIZE:  Affects how much smoothing to apply to the signal
%               Higher filter size ---> more smoothing
%
% THRESHOLD:    The minimum value the first peak needs to reach in order to
%               register. If no peak meets the threshold, then no peaks are detected.
%               Increasing THRESHOLD may result in LESS peaks detected.
%
% DECREASE_RATE:    The fraction of the previous peak that needs to be met,
%               in order to register a new peak. 
%               Increasing this will result in LESS peaks detected.
%
% -----------------------------------



% Change to 'UT Signal Analysis\MatLab UT Data' folder
Root_Folder = cd('Functions');

% Load steel sample ultrasonic files using 'Functions\SavedUT_Load.m'
% Choices will be displayed in Command Window.
UT_Signal_Structure = SavedUT_Load();

% Load data file for specific Jominy sample portion
% Choices will be displayed in Command Window.
Data_Structure_Index = Select_Signal(UT_Signal_Structure);

% Save data for the desired signal and output information to Command Window
Signal_Data = UT_Signal_Structure(Data_Structure_Index);
clear UT_Signal_Structure            % Clear other ultrasonic signals
disp(['Showing data for ' Signal_Data.Steel_Type ', '...
    Signal_Data.Sample_Name ', ' Signal_Data.Other]);

% Create time vector, to act as X-axis.
% The time vector is based on info in the 'UT_Signal' class storage.
% Using call to 'UT Signal Analysis\Functions\TimeVector_Create.m'
Signal_Time_Vector = TimeVector_Create(Signal_Data.Duration, Signal_Data.Axis_Length);

% Filter signal to reduce noise.
% Using function call to 'UT Signal Analysis\Functions\HammingFilter.m'
Filtered_Signal = HammingFilter(Signal_Data.Signal,FILTER_SIZE);

% Peak detection (basic local maxima detection for discreet data)
% This uses the Maatlab built in function 'findpeaks'
[Maxima_Voltage, Maxima_Index] = findpeaks(Filtered_Signal);

% Advanced peak detections, using thresholds.
% Using function call to 'UT Signal Analysis\Functions\Find_UTPeaks.m'
[Peak_Voltage, Peak_Time] = Find_UTPeaks(Maxima_Voltage, Maxima_Index, Signal_Time_Vector,...
    THRESHOLD, DECREASE_RATE);

% Plot the signal using 'UT Signal Analysis\Functions\Plot_UT.m'
% This is also where buttons, and red circles are inserted.
Figure_withPeaks = Plot_UT(Signal_Time_Vector, Filtered_Signal,...
    Peak_Time, Peak_Voltage);

% Return to original folder (UT Signal Analysis)
cd(Root_Folder);

% April 14, 2018
% Advanced Materials and Processing Lab
% Dept. of Chem. and Materials Engineering
% University of Alberta
% Kartik Vasudev
% kvasudev@ualberta.ca
%
% Built and run on Matlab R2018a
