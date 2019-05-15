function fig = CreateButton(button_function, fig)
% CreateButton adds a button to an ultrasonic peak figure out of the
% possible options.
%
% Input:        button_function - STRING defining the purpose of the button
%               fig - handle to Figure object to which button is added
% Output:       fig - handle to the Figure object after button is added

% Determine which button to add based on 'button_function'
% Additional buttons can be added, but should be added as new cases
switch button_function
    case 'display_peak_values'
        button_text = 'Output Visible Peaks';       % Text on button
    case 'toggle_peaks'
        button_text = 'Toggle Peaks';               % Text on button
    otherwise
end

% Create the button using the 'uicontrol' call
new_button = uicontrol(fig,'String',button_text,'Tag',button_function);

% Call to function to set the button location, actions, etc...
% Function called is 'UT Signal Analysis\Function\Set_Button_Properties.m'
Set_Button_Properties(new_button);

end

% April 14, 2018
% Advanced Materials and Processing Lab
% Dept. of Chem. and Materials Engineering
% University of Alberta
% Kartik Vasudev
% kvasudev@ualberta.ca
%
% Built and run on Matlab R2018a
