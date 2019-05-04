function [UT_Figure] = Plot_UT(time_vector, ut_signal,...
    peak_times, peak_voltage)
% Plot_UT takes either 2 or 4 inputs, and creates a graph for that data.
% If 2 inputs are entered, then a simple plot is produced.
% If 4 inputs are entered, it is assumed to be a peak plot, and additional
% features are added.
%
% Inputs:       time_vector - vector of DOUBLE with X axis information
%               ut_signal - vector of DOUBLE with Y axis information
%               peak_times - vector of DOUBLE mapping onto X axis
%               peak_voltage - vector of DOUBLE mapping onto Y axis
% Outputs:      UT_Figure - handle to 'Figure' object containing the
%                       ultrasonic plot

% Set properties of figure
fontSize_Axes = 16;             % Axis title font size
fontSize_Title = 24;            % Plot title font size
fontName = 'Calibri';

xLabel = 'Time (us)';
yLabel = 'Signal Voltage (V)';

% Create new figure window
UT_Figure = figure;

% Determine how many input arguments were given
switch nargin
    case 2
        % Plot simple UT figure
        plot(time_vector, ut_signal);
        plot_Title = 'Ultrasonic Signal';
        % Create figure elements using call to 
        % 'UT Signal Analysis\Functions\SetAxes.m'
        UT_Figure.Children = SetAxes(UT_Figure.Children,plot_Title,xLabel,yLabel,...
            fontSize_Axes,fontSize_Title,fontName);
    case 4
        % Plot ltrasonic signal
        plot(time_vector, ut_signal, 'Tag', 'UT_Signal')
        hold on        % Set hold to 'on' to allow superimposed plots
        % Plot peaks overtop of ultrasonic signal
        plot(peak_times,peak_voltage,'ro','Tag','Peaks')
        hold off
         
        plot_Title = 'Ultrasonic Signal with Labelled Peaks';

        % Set figure elements using 'UT Signal Analysis\Function\SetAxes.m'
        UT_Figure.Children = SetAxes(UT_Figure.Children,plot_Title,xLabel,yLabel,...
            fontSize_Axes,fontSize_Title,fontName);
        
        % Call to function to move the plot within the figure
        UT_Figure = Resize_Axes(UT_Figure);
        
        % Create button for selecting peaks and hiding peaks.
        % Calls 'UT Signal Analysis\Functions\CreateButton.m'
        UT_Figure = CreateButton('display_peak_values',UT_Figure);
        UT_Figure = CreateButton('toggle_peaks',UT_Figure);
        
        % Adjust the locations of the buttons by calling
        % 'UT Signal Analysis\Functions\Set_Button_Location.m'
        UT_Figure = Set_Button_Location(UT_Figure);
    otherwise
        error(['Error in script using ''Plot_UT'' function. '...
            'Incorrect number of inputs (requires 2 or 4).']);
end

end

% April 14, 2018
% Advanced Materials and Processing Lab
% Dept. of Chem. and Materials Engineering
% University of Alberta
% Kartik Vasudev
% kvasudev@ualberta.ca
%
% Built and run on Matlab R2018a

