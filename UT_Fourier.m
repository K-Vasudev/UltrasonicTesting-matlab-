% This script runs a Fourier analysis and graphing program on the section
% designated by the user. Make sure to read the Command Window on the
% Matlab program and enter one of the suggested options.
clear   % Clear Workspace variables
clc     % Clear Command Window

% ----------- SCRIPT PARAMETERS ------------
% (changes should only be made to constants listed below)
%
% DEFAULTS: FILTER = 1;
%           SMOOTHING_FILER_SIZE = 31
%           NPOINT = 65536
%           DISPLAY_SPECTRUM = 30
%           FONT_NAME = 'Calibri'
%
FILTER = 1;                 % Set or remove window filter, can be 0(no) or 1(yes)
SMOOTHING_FILTER_SIZE = 31;     % Size of smoothing Hamming filter
NPOINT = 65536;             % Size of Fourier Transform
DISPLAY_SPECTRUM = 30;      % Highest frequency to display (MHz)
FONT_NAME = 'Calibri';      % Font type to be used for graphs
FONT_SIZE_TITLE = 24;       % Font size to display for graph title
FONT_SIZE_AXES = 16;        % Font size for axes title and axes numbers
%
% FILTER:       Affets whether or not the windowed signal is filtered by
%               Hamming filter. Can take values of 1 or 0. 1 causes
%               filtereing, 0 does not. Window filtering is used to reduce
%               the amount of spectral leakage. SET TO 0 IF calculating
%               signal energy coefficients.
%
% SMOOTHING_FILTER_SIZE:  Affects how much smoothing to apply to the signal
%               Higher filter size ---> more smoothing
%
% NPOINT:       The size of the Fourier Transform that is performed
%               Should always be a power of 2
%
% DISPLAY_SECTRUM:  This is the highest frequency to be displayed when
%                   the Fourier trasnform figure is created. Given in MHz
%
% FONT_NAME:    Font to be used in figures for title and axes. Must be
%               placed with single quotes in order to work.
%
% FONT_SIZE_TITLE:  This sets the size of the font to be used for the
%                   title in graphs produced by this code.
%
% FONT-SIZE-AXES:   This number sets the size of the axes titles that will
%                   be displayed on the graphs for this script. It will 
%                   also affect the axes number markings, which are set
%                   to be 0.66% the size of the axis titles.
% ---------------------------


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
Filtered_Signal = HammingFilter(Signal_Data.Signal,SMOOTHING_FILTER_SIZE);

% Plot filtered signal
Ultrasonic_Signal = Plot_UT(Signal_Time_Vector, Filtered_Signal);

% Ask user to specify time location (in microseconds)
[Window_idx_start, Window_idx_end, Fourier_Figure] = Get_Fourier_Input(Filtered_Signal, ...
    Signal_Data.Duration, Signal_Data.Axis_Length, Signal_Data.Steel_Type, Signal_Data.Sample_Name);

% Plot the Fourier transform of the window selected above

% Create filter and isolate signal window for transformation
Window_length = Window_idx_end - Window_idx_start;
Filter = hamming(Window_length);
Transform_Window = Signal_Data.Signal(Window_idx_start:Window_idx_end-1);

% Filter the transform window to reduce spectral leakage
if FILTER == 1  
    Transform_Window = Filter.*Transform_Window;
end
% Pad with zeros
Front_zeros = floor((NPOINT-Window_length)/2);
End_zeros = ceil((NPOINT-Window_length)/2);
Transform_Window = [zeros(Front_zeros,1) ; Transform_Window ; zeros(End_zeros,1)];

% Apply fourier transform to window
Signal_FT = fft(Transform_Window,NPOINT);
% Get power spectrum from transform
P2 = abs(Signal_FT/NPOINT);     % Get symmetric spectrum
Power_Spectrum = P2(1:NPOINT/2+1);          % Take first half of spectrum
Power_Spectrum(2:end-1) = 2*Power_Spectrum(2:end-1);    % Convert to 1-sided spectrum

% Caluclate frequency domain
Sampling_Rate = (Signal_Data.Axis_Length/Signal_Data.Duration);
Freq_Vector = Sampling_Rate*(0:NPOINT/2)/NPOINT;

% Plot power spectrum on subplot
set(0,'CurrentFigure',Fourier_Figure);  % Set Fourier figure to current target
Fourier_Axis = subplot(2,1,2);      % Add second subplot
plot(Freq_Vector,Power_Spectrum);
xlim(Fourier_Axis, [0 DISPLAY_SPECTRUM]);         % Set x-domain of Fourier power spectrum

% Set title of Fourier figure
Fourier_Axis = SetAxes(Fourier_Axis,'Fourier Transform','Frequency (MHz)',...
    'Voltage (V)',FONT_SIZE_AXES,FONT_SIZE_TITLE,FONT_NAME);  

% Output variable access information to Command Window
Output_Text = '------------------------------';
disp(Output_Text)
Output_Text = 'Fourier Spectrum information can be accessed through variables ''Freq_Vector'' and ''Power_Spectrum''';
disp(Output_Text)

% Return to Root folder
cd(Root_Folder);


% June 13, 2018
% Advanced Materials and Processing Lab
% Dept. of Chem. and Materials Engineering
% University of Alberta
% Kartik Vasudev
% kvasudev@ualberta.ca
%
% Built and run on Matlab R2018a
