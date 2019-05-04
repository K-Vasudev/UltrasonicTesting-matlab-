function Set_Button_Properties(button)
% Set_Button_Properties is used to change the layout of the figure showing
% ultrasonic peak plots. It changes the position of the buttons on the
% figure window.

% Set general button properties
% Normalized units makes it so button location is set as absolute value
% of screen size.
button.Units = 'normalized';

% Set properties for specific buttons
% This section uses function handles to call functions.
%   In this way, a function can be created and called everytime a button is
%   pressed. 'src' is the button that is pressed (source), and 'event' is the action
%   that is elicited by that button press.
switch button.Tag   % Set the different button types, fuction definitions below
    case 'display_peak_values'
        set(button,'Callback',@(src,event)Print_Peak_Values(src,event));
    case 'toggle_peaks'
        set(button,'Callback',@(src,event)Hide_Peaks(src,event));
    otherwise
end

end

function Print_Peak_Values(src,~)
% This local function is called by button press
% It takes all visible peaks and displays their voltage and time values in
% the command window

src_parent = src.Parent;    % The parent of the button should be the figure
siblings = src_parent.Children; % The button is siblings with the graph axes

% Family hierarchy in Matlab goes:
% Figure-->Axes/Button-->Line/AxesProperties/ButtonProperties
for sib_counter = 1:length(siblings)
    if strcmp(siblings(sib_counter).Type,'axes') % 'axes' is a graph type object
        nephews = siblings(sib_counter).Children;   % Get all 'line' objects (Children of 'axes')
        for nephew_counter = 1:length(nephews)
            if strcmp(nephews(nephew_counter).Tag,'Peaks')  
                figure_axes = siblings(sib_counter);    % Find 'axes' containing 'Peaks' line
                peak_plot = nephews(nephew_counter);    % Find 'line' named 'Peaks'
                break;
            end
        end
    end    
end
% Determine boundaries of plotted figure
XLimits = figure_axes.XLim;
YLimits = figure_axes.YLim;

% Check which peaks are in displayed x domain, set to 1 if yes, 0 if no
inDomain = (peak_plot.XData>XLimits(1)) .* (peak_plot.XData<XLimits(2)); 
% Check which peaks are in displayed y range, set to 1 if yes, 0 if no
inRange = (peak_plot.YData>YLimits(1)) .* (peak_plot.YData<YLimits(2));
peaks_to_display = inRange .* inDomain; % Create boolean of peaks to print

% Print heading in the command window
text = newline; % Create empty line
disp(text)
text = sprintf('%15s %15s','Peak Time', 'Peak Voltage'); % Create header (conditional formatting)
disp(text)
text = sprintf('%15s %15s','(us)', '(V)'); % Create string with units
disp(text)
text = '-------------------------------'; % Create horizontal line
disp(text)

% Print voltage and time values in command window
% Only peaks which are in the visible area are printed
for peak_counter = 1:length(peaks_to_display)   % Check all peaks
    if peaks_to_display(peak_counter) == 1
        text = sprintf('%15.3f %15.3f',peak_plot.XData(peak_counter),...
            peak_plot.YData(peak_counter));     % Get peak info
        disp(text)
    end
end

end

function Hide_Peaks(src,~)
% This local function is called by button press
% It toggles the visiblilty of red-circled peaks on the plot figure

src_parent = src.Parent;    % Parent of button is the entire figure
siblings = src_parent.Children; % Finds all children of the figure
for sib_counter = 1:length(siblings)
    if strcmp(siblings(sib_counter).Type,'axes') % Find all 'axes' objects
        nephews = siblings(sib_counter).Children;
        for nephew_counter = 1:length(nephews)
            if strcmp(nephews(nephew_counter).Tag,'Peaks') % Find the 'Peaks' line object
                peak_plot = nephews(nephew_counter);        
                break;
            end
        end
    end    
end

if strcmp(peak_plot.Visible,'on')   % If peaks are visible, turn them off
    peak_plot.Visible = 'off';
    src.String = 'Show Peaks';
elseif strcmp(peak_plot.Visible,'off')  % If peaks are not visible, turn them on
    peak_plot.Visible = 'on';
    src.String = 'Hide Peaks';
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