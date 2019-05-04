function [window_start, window_end, fig] = Get_Fourier_Input(signal, duration, axis_length, steel_type, sample_name)
% Get_Fourier_Input function takes in user input to determine where to
% place the window for Fourier analysis. The user input is used to isolate
% the signal in the time domain for the user to correct and confirm the
% window location. This function outputs the location of the window as an
% index of the input signal, and outputs the handle to the figure subplots
% that will represent the Fourier transform.
%
% Input:        signal - 1D vector containing signal values
%               duration - time duration of signal
%               axis_length - number of entries in the time vector
%               steel_type - from 'UT_Signal' structure
%               sample_name - from 'UT_Signal' structure
% Output:       window_start - index of the starting time for window
%               window_end - index of ending time for window
%               fig - handle to the Fourier transform comparison plot

% Create tiem vector using TimeVector_Create function
time_vector = TimeVector_Create(duration, axis_length);

fig = figure;           % Create new figure
window_length = 0.4;    % in microseconds
input_mode = 'L';       % Initialize input mode for later in function

loop = 1;               % Set to true, for continuous while loop
while loop==1;
    
    % Take user input 
    switch input_mode
        % Take input for window position
        case 'L'    % Change window center location
            window_center = input('PLEASE ENTER THE DESIRED SIGNAL LOCATION (in us): ');
        case 'W'    % Change window width
            window_length = input('PLEASE ENTER THE DESIRED WINDOW WIDTH (in us): ');
    end

    % Determine number of data points in window
    digitizing_rate = duration/axis_length;     % Calculate digitizing rate
    window_points = floor(window_length/digitizing_rate);   % determine window length

    % Determine index of center point
    t_diff = time_vector-window_center; % Distance between data times and user specified time
    abs_diff = abs(t_diff); % Absolute value of distance, to eliminate negatives
    center_index = find(abs_diff == min(abs_diff));  % Find index of the center point

    % Determine start and end indices of window
    window_start = center_index - floor(window_points/2);
    window_end = center_index + ceil(window_points/2);

    % Plot time signal in subplot window
    set(0,'CurrentFigure',fig); % set 'fig' to target
    subplot(2,1,1)              % Output to top plot
    plot(time_vector(window_start:window_end),signal(window_start:window_end)); % plot time signal
    fig.Children.XLim = [time_vector(window_start) time_vector(window_end)];    % set xlimits
    
    % Set plot title and axes titles
    plot_title = [steel_type ' ' sample_name ' at ' num2str(window_center) ' us'];
    fig.Children = SetAxes(fig.Children,plot_title,'Time (us)',...
        'Voltage (V)',16,24,'Calibri');        

    inner_loop = 1;     % Set outer WHILE loop parameter
    while inner_loop == 1       % Continue until condition change
        
        % Ask user to change signal window parameters
        disp('---------------------------------');
        disp('Options:');
        disp('    (L) -  to adjust the window location.');
        disp('    (W) -  to adjust the width of the window.');
        disp('    (S) -  if you are satisfied with the window location and size');
        input_mode = input('SELECT FROM THE ABOVE LIST OF OPTIONS: ','s');
        
        % Ensure that a valid option has been chosen
        if strcmp(input_mode,'L') || strcmp(input_mode,'W') || strcmp(input_mode,'S')
            inner_loop = 0;     % Set break condition for inner WHILE loop
        else
            disp('------------------------------');
            disp('PLEASE SELECT A VALID OPTION FROM THE LIST')
        end
    end
    
    % Break out of selection mode or prime for user input
    if input_mode == 'S'
        loop = 0;       % Set break condition for outer WHILE loop
    else
        disp('------------------------------');
        disp(['CURRENTLY SHOWING: window length- ' num2str(window_length)...
            ' us, window position- ' num2str(window_center) ' us']);
    end
    
end

end

% June 13, 2018
% Advanced Materials and Processing Lab
% Dept. of Chem. and Materials Engineering
% University of Alberta
% Kartik Vasudev
% kvasudev@ualberta.ca
%
% Built and run on Matlab R2018a