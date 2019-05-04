function fig = Set_Button_Location(fig)
% Set_Button_Location places buttons on the desired location within the
% ultrasonic plot
%
% fig = Set_Button_Location(fig)
%   Input Arguments:    fig     - the handle to the figure upon which
%                               buttons will be placed
%   Output Arguments:   fig     - the same figure, now complete with button

button_side_margin = 0.1;   % Spacing of buttons
button_width_points = 100;  % Size of buttons

button_idx = [];    % Placeholder for button counter

for children_counter = 1:length(fig.Children)       % Count number of buttons
    if strcmp(fig.Children(children_counter).Type,'uicontrol')  % Only count 'uicontrol' objects
        button_idx = [button_idx children_counter];
    elseif strcmp(fig.Children(children_counter).Type,'axes')   % Don't count 'axes' objects
        axes_child = children_counter;
    end
end

button_width = button_width_points/fig.Position(3); % Set the horizontal size of button

btn_number = length(button_idx);

for button_counter = 1:btn_number   % Iterate through all buttons
    button_center_hor = (1/btn_number)*(button_counter-1)+0.5*(1/btn_number);   % Set horizontal location
    button_left = button_center_hor - button_width/2;   % Set location
    button_bottom = 0.01;   % Place buttons at bottom of figure
    button_height = 0.08;
    
    fig.Children(button_idx(button_counter)).OuterPosition = ...
        [button_left button_bottom button_width button_height];     % Set button location properties
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